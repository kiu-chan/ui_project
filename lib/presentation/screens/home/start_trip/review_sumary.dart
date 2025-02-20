import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ui_project/core/constant/assets.dart';
import 'package:ui_project/core/constant/color.dart';
import 'package:ui_project/core/constant/textStyle.dart';
import 'package:ui_project/presentation/screens/home/start_trip/trip_data_manager.dart';
import 'package:ui_project/presentation/screens/select_screen.dart';

class ReviewSummary extends StatelessWidget {
  ReviewSummary({super.key});

  final tripData = TripDataManager();

  Future<void> saveTripToFirestore() async {
    try {
      final firestore = FirebaseFirestore.instance;
      final currentUser = FirebaseAuth.instance.currentUser;
      
      if (currentUser == null) {
        throw Exception('Người dùng chưa đăng nhập');
      }

      final tripRef = firestore
          .collection('trips')
          .doc(currentUser.uid)
          .collection('userTrips');

      await tripRef.add({
        'destination': tripData.destination,
        'group': tripData.group,
        'date': tripData.date,
        'budget': tripData.budget,
        'imageUrl': tripData.imageUrl,
        'createdAt': FieldValue.serverTimestamp(),
        'status': 'planned',
        'userId': currentUser.uid,
      });

      tripData.clear();
      
    } catch (e) {
      print('Lỗi khi lưu chuyến đi: $e');
      rethrow;
    }
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Column(
            children: [
              Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 50,
              ),
              SizedBox(height: 10),
              Text(
                'Tạo lịch trình thành công!',
                textAlign: TextAlign.center,
                style: AppTextStyle.headStyle.copyWith(
                  color: Colors.green,
                ),
              ),
            ],
          ),
          content: Text(
            'Lịch trình của bạn đã được lưu thành công. Bạn có thể xem và quản lý nó trong danh sách các chuyến đi của mình.',
            textAlign: TextAlign.center,
            style: AppTextStyle.bodyStyle,
          ),
          actions: [
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  minimumSize: Size(200, 45),
                ),
                onPressed: () {
                  Navigator.of(context).pop(); // Close dialog
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SelectPage(),
                    ),
                  );
                },
                child: Text(
                  'Đồng ý',
                  style: AppTextStyle.buttonText,
                ),
              ),
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
        centerTitle: true,
        title: Text(
          'Xem lại lịch trình',
          style: AppTextStyle.appBarStyle,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: CachedNetworkImage(
                  imageUrl: tripData.imageUrl,
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              const SizedBox(height: 20),
              _buildInfoSection('Điểm đến:', tripData.destination),
              _buildInfoSection('Ngày đi:', tripData.date),
              _buildInfoSection('Nhóm:', tripData.group),
              _buildInfoSection('Ngân sách:', tripData.budget),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    onPressed: () async {
                      try {
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                        );

                        await saveTripToFirestore();
                        Navigator.of(context).pop(); // Đóng loading dialog
                        
                        _showSuccessDialog(context);

                      } catch (e) {
                        Navigator.of(context).pop(); // Đóng loading dialog
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Không thể lưu lịch trình: $e'),
                          ),
                        );
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        "Lưu lịch trình",
                        style: AppTextStyle.buttonText,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoSection(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: AppTextStyle.bodyStyle.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: AppTextStyle.bodyStyle,
            ),
          ),
        ],
      ),
    );
  }
}