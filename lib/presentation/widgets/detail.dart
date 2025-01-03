import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:ui_project/core/constant/assets.dart';
import 'package:ui_project/core/constant/button.dart';
import 'package:ui_project/core/constant/color.dart';
import 'package:ui_project/core/constant/textStyle.dart';
import 'package:ui_project/presentation/screens/home/start_trip/trip_data_manager.dart';
import '../screens/home/start_trip/step_screen.dart';

class DetailPage extends StatelessWidget {
  final String title;
  final List<String> image;
  final String address;
  final String description;
  final String history;
  final String feature;
  final Widget? widget;
  
  DetailPage({
    super.key,
    required this.title,
    required this.image,
    required this.address,
    required this.description,
    required this.history,
    required this.feature,
    this.widget,
  });

  @override
  Widget build(BuildContext context) {
  final isLogin = FirebaseAuth.instance.currentUser;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Hero Image Section
          Stack(
            children: [
              CachedNetworkImage(
                imageUrl: image.isNotEmpty ? image[0] : '',
                fit: BoxFit.cover,
                height: 250, // Increased height for better visual impact
                width: MediaQuery.sizeOf(context).width,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    Image.asset(
                  AppAssets.Marker,
                  fit: BoxFit.cover,
                  height: 250,
                  width: MediaQuery.sizeOf(context).width,
                ),
                errorWidget: (context, url, error) => Image.asset(
                  AppAssets.Marker,
                  fit: BoxFit.cover,
                ),
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      back(),
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: widget,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title and Address Section
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Text(title, style: AppTextStyle.headStyle),
                ),
                Row(
                  children: [
                    SvgPicture.asset(
                      AppAssets.Vn,
                      width: 20,
                      height: 20,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        address,
                        style: AppTextStyle.bodyStyle,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
                
                const Divider(height: 30, thickness: 1),
                
                // Description Section
                Text(description, style: AppTextStyle.bodyStyle),
                
                const Divider(height: 30, thickness: 1),
                
                // Gallery Section
                Text('Ảnh minh họa', style: AppTextStyle.headLineStyle),
                SizedBox(height: 20),
                if (image.length >= 4)
                  SizedBox(
                    height: 120,
                    child: ListView(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      children: [
                        for (int i = 1; i < 4; i++)
                          Padding(
                            padding: EdgeInsets.only(right: i < 3 ? 10 : 0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: CachedNetworkImage(
                                imageUrl: image[i],
                                width: 160, // Fixed width for consistent look
                                fit: BoxFit.cover,
                                progressIndicatorBuilder: (context, url, downloadProgress) =>
                                    Image.asset(
                                  AppAssets.Marker,
                                  fit: BoxFit.cover,
                                ),
                                errorWidget: (context, url, error) => Image.asset(
                                  AppAssets.Marker,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                
                const Divider(height: 30, thickness: 1),
                
                // History Section
                Text('Lịch sử', style: AppTextStyle.headLineStyle),
                SizedBox(height: 10),
                Text(history, style: AppTextStyle.bodyStyle),
                
                const Divider(height: 30, thickness: 1),
                
                // Feature Section
                Text('Đặc trưng', style: AppTextStyle.headLineStyle),
                SizedBox(height: 10),
                Text(feature, style: AppTextStyle.bodyStyle),
              ],
            ),
          ),

          // Bottom Button
          Container(
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              top: 20,
              bottom: MediaQuery.sizeOf(context).height * 0.1,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: Offset(0, -5),
                ),
              ],
            ),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 15),
                ),
                onPressed: () {
                  TripDataManager().setDestination(title, image[0]);
                  if (isLogin != null) {
                    pushWithoutNavBar(
                      context,
                      MaterialPageRoute(
                        builder: (context) => StepScreen(),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Vui lòng đăng nhập để tạo lịch trình'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                child: Text(
                  "Tạo lịch trình",
                  style: AppTextStyle.buttonText,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}