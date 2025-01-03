import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ui_project/core/constant/color.dart';
import 'package:ui_project/presentation/screens/explore/news_feed.dart';
import 'package:ui_project/presentation/screens/explore/saved_screen.dart';
import 'package:ui_project/presentation/widgets/appbar_root.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  int? selectedSegment = 1;
  final isLogin = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 50,
          ),
          if (isLogin != null) ...[
            // Hiển thị thanh segment khi đã đăng nhập
            CustomSlidingSegmentedControl<int>(
              fixedWidth: MediaQuery.sizeOf(context).width * 0.45,
              initialValue: selectedSegment,
              children: {
                1: Text(
                  'Đã lưu',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: selectedSegment == 1
                        ? FontWeight.bold
                        : FontWeight.normal,
                    color: selectedSegment == 1
                        ? Colors.white
                        : Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),
                2: Text(
                  'Bảng tin',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: selectedSegment == 2
                        ? FontWeight.bold
                        : FontWeight.normal,
                    color: selectedSegment == 2
                        ? Colors.white
                        : Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),
              },
              decoration: BoxDecoration(
                color: Color.fromRGBO(243, 243, 247, 1),
                borderRadius: BorderRadius.circular(8),
              ),
              thumbDecoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(6),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(.15),
                    blurRadius: 4.0,
                    offset: const Offset(0.0, 1.0),
                  ),
                ],
              ),
              duration: const Duration(milliseconds: 280),
              curve: Curves.linear,
              onValueChanged: (v) {
                setState(() {
                  selectedSegment = v;
                });
              },
            ),
          ] else ...[
            // Khi chưa đăng nhập, chỉ hiển thị tab "Đã lưu"
            CustomSlidingSegmentedControl<int>(
              fixedWidth: MediaQuery.sizeOf(context).width * 0.45,
              initialValue: 1,
              children: {
                1: Text(
                  'Đã lưu',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              },
              decoration: BoxDecoration(
                color: Color.fromRGBO(243, 243, 247, 1),
                borderRadius: BorderRadius.circular(8),
              ),
              thumbDecoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(6),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(.15),
                    blurRadius: 4.0,
                    offset: const Offset(0.0, 1.0),
                  ),
                ],
              ),
              duration: const Duration(milliseconds: 280),
              curve: Curves.linear,
              onValueChanged: (v) {
                // Không cần xử lý vì chỉ có 1 tab
              },
            ),
          ],
          const Padding(
            padding: EdgeInsets.symmetric(
              vertical: 15,
              horizontal: 15,
            ),
          ),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.75,
            child: isLogin != null && selectedSegment == 2 
                ? NewsfeedScreen()
                : SaveScreen(),
          ),
        ],
      ),
    );
  }
}