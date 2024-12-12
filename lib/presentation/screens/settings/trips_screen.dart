import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ui_project/core/constant/color.dart';
import 'package:ui_project/core/constant/textStyle.dart';
import 'package:ui_project/core/constant/assets.dart';
import 'package:ui_project/presentation/widgets/detail.dart';

class TripsScreen extends StatefulWidget {
  const TripsScreen({Key? key}) : super(key: key);

  @override
  State<TripsScreen> createState() => _TripsScreenState();
}

class _TripsScreenState extends State<TripsScreen> {
  bool _sortDescending = true;

  Future<Map<String, dynamic>?> getDestinationDetails(String destinationName) async {
    try {
      final destinationSnapshot = await FirebaseFirestore.instance
          .collection('Destinations')
          .where('title', isEqualTo: destinationName)
          .get();

      if (destinationSnapshot.docs.isNotEmpty) {
        return {
          ...destinationSnapshot.docs.first.data(),
          'type': 'destination'
        };
      }

      final foodSnapshot = await FirebaseFirestore.instance
          .collection('Food')
          .where('title', isEqualTo: destinationName)
          .get();

      if (foodSnapshot.docs.isNotEmpty) {
        return {
          ...foodSnapshot.docs.first.data(),
          'type': 'food'
        };
      }

      final festivalSnapshot = await FirebaseFirestore.instance
          .collection('Festivals')
          .where('title', isEqualTo: destinationName)
          .get();

      if (festivalSnapshot.docs.isNotEmpty) {
        return {
          ...festivalSnapshot.docs.first.data(),
          'type': 'festival'
        };
      }

      final cultureSnapshot = await FirebaseFirestore.instance
          .collection('Culture')
          .where('title', isEqualTo: destinationName)
          .get();

      if (cultureSnapshot.docs.isNotEmpty) {
        return {
          ...cultureSnapshot.docs.first.data(),
          'type': 'culture'
        };
      }

      return null;
    } catch (e) {
      print('Error getting destination details: $e');
      return null;
    }
  }

  void navigateToDetail(Map<String, dynamic> destinationData) {
    String address = '';
    String feature = '';
    
    if (destinationData['type'] == 'food') {
      address = (destinationData['address'] as List).first;
      feature = destinationData['feature'];
    } else if (destinationData['type'] == 'culture') {
      address = destinationData['address'];
      feature = (destinationData['feature'] as List)[1];
    } else {
      address = destinationData['address'];
      feature = destinationData['feature'];
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          body: DetailPage(
            title: destinationData['title'],
            image: List<String>.from(destinationData['image']),
            address: address,
            description: destinationData['description'] ?? 'Không có mô tả',
            history: destinationData['history'] ?? 'Không có lịch sử',
            feature: feature,
            widget: Container(),
          ),
        ),
      ),
    );
  }

  Future<void> _deleteTrip(String tripId) async {
    try {
      await FirebaseFirestore.instance
          .collection('trips')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .collection('userTrips')
          .doc(tripId)
          .delete();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Đã xóa lịch trình thành công'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Lỗi khi xóa lịch trình: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<bool?> _showDeleteConfirmation(String tripId, String destination) async {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Xác nhận xóa'),
          content: Text('Bạn có chắc chắn muốn xóa lịch trình đến $destination không?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text('Hủy'),
            ),
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.red,
              ),
              onPressed: () {
                _deleteTrip(tripId);
                Navigator.of(context).pop(true);
              },
              child: Text('Xóa'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backGroundColor,
        title: Text('Lịch trình của tôi', style: AppTextStyle.appBarStyle),
        actions: [
          IconButton(
            icon: Icon(
              _sortDescending ? Icons.arrow_downward : Icons.arrow_upward,
              color: AppColors.primaryColor,
            ),
            onPressed: () {
              setState(() {
                _sortDescending = !_sortDescending;
              });
            },
            tooltip: 'Sắp xếp theo thời gian',
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('trips')
            .doc(FirebaseAuth.instance.currentUser?.uid)
            .collection('userTrips')
            .orderBy('createdAt', descending: _sortDescending)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Đã xảy ra lỗi',
                style: TextStyle(color: Colors.red),
              ),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: AppColors.primaryColor,
              ),
            );
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.calendar_today,
                    size: 64,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Chưa có lịch trình nào',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: EdgeInsets.all(16),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final trip = snapshot.data!.docs[index];
              final tripData = trip.data() as Map<String, dynamic>;

              return Dismissible(
                key: Key(trip.id),
                direction: DismissDirection.endToStart,
                background: Container(
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.only(right: 20),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.delete,
                        color: Colors.white,
                        size: 32,
                      ),
                      Text(
                        'Xóa',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                confirmDismiss: (direction) => _showDeleteConfirmation(
                  trip.id,
                  tripData['destination'] ?? 'Không có tên',
                ),
                child: Card(
                  margin: EdgeInsets.only(bottom: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 4,
                  child: Stack(
                    children: [
                      InkWell(
                        onTap: () async {
                          final destinationDetails = await getDestinationDetails(tripData['destination']);
                          if (destinationDetails != null) {
                            navigateToDetail(destinationDetails);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Không tìm thấy thông tin chi tiết điểm đến')),
                            );
                          }
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                              child: CachedNetworkImage(
                                imageUrl: tripData['imageUrl'] ?? '',
                                height: 150,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                placeholder: (context, url) => Image.asset(
                                  AppAssets.Marker,
                                  fit: BoxFit.cover,
                                ),
                                errorWidget: (context, url, error) => Image.asset(
                                  AppAssets.Marker,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    tripData['destination'] ?? 'Chưa có tên',
                                    style: AppTextStyle.headLineStyle,
                                  ),
                                  SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Icon(Icons.calendar_today, size: 16),
                                      SizedBox(width: 8),
                                      Text(
                                        tripData['date'] ?? 'Chưa có ngày',
                                        style: AppTextStyle.bodyStyle,
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Icon(Icons.people, size: 16),
                                      SizedBox(width: 8),
                                      Text(
                                        tripData['group'] ?? 'Chưa có nhóm',
                                        style: AppTextStyle.bodyStyle,
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Icon(Icons.attach_money, size: 16),
                                      SizedBox(width: 8),
                                      Text(
                                        tripData['budget'] ?? 'Chưa có ngân sách',
                                        style: AppTextStyle.bodyStyle,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Thay thế phần Positioned trong Stack bằng đoạn code sau:
                      Positioned(
                        top: 8,
                        right: 8,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.8),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                spreadRadius: 1,
                                blurRadius: 3,
                                offset: Offset(0, 1),
                              ),
                            ],
                          ),
                          child: IconButton(
                            icon: Icon(
                              Icons.delete_outline,
                              color: Colors.red,
                              size: 24,
                            ),
                            onPressed: () async {
                              final confirm = await _showDeleteConfirmation(
                                trip.id,
                                tripData['destination'] ?? 'Không có tên',
                              );
                              if (confirm == true) {
                                _deleteTrip(trip.id);
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}