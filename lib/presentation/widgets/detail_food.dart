import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:ui_project/core/constant/assets.dart';
import 'package:ui_project/core/constant/button.dart';
import 'package:ui_project/core/constant/color.dart';
import 'package:ui_project/core/constant/textStyle.dart';

import '../screens/home/start_trip/step_screen.dart';

// ignore: must_be_immutable
class DetailFoodPage extends StatefulWidget {
  String title;
  List<String> image;
  String address;
  String description;
  String history;
  String feature;
  String ingredients;

  DetailFoodPage({
    super.key,
    required this.title,
    required this.image,
    required this.address,
    required this.description,
    required this.history,
    required this.feature,
    required this.ingredients,
  });

  @override
  State<DetailFoodPage> createState() => _DetailFoodPageState();
}

class _DetailFoodPageState extends State<DetailFoodPage> {
  final CollectionReference collectDestinations =
      FirebaseFirestore.instance.collection('Destinations');
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              CachedNetworkImage(
                imageUrl: widget.image[0],
                fit: BoxFit.cover,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    Image.asset(
                  AppAssets.Marker,
                  fit: BoxFit.cover,
                  height: 150,
                  width: MediaQuery.sizeOf(context).width * 1,
                ),
                errorWidget: (context, url, error) => Image.asset(
                  AppAssets.Marker,
                  fit: BoxFit.cover,
                ),
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
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
                        child: IconButton(
                          onPressed: () {},
                          icon: SvgPicture.asset(
                            AppAssets.BookMark,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 15,
                  ),
                  child: Text(
                    widget.title,
                    style: AppTextStyle.headStyle,
                  ),
                ),
                Row(
                  children: [
                    SvgPicture.asset(
                      AppAssets.Vn,
                      width: 20,
                      height: 20,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width * 0.8,
                      child: Text(
                        widget.address[1],
                        style: AppTextStyle.bodyStyle,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 15,
                  ),
                  child: Text(
                    widget.description,
                    style: AppTextStyle.bodyStyle,
                  ),
                ),
                Text(
                  'Ảnh minh họa',
                  style: AppTextStyle.headLineStyle,
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 120,
                  child: ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: CachedNetworkImage(
                          imageUrl: widget.image[1],
                          fit: BoxFit.cover,
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) => Image.asset(
                            AppAssets.Marker,
                            fit: BoxFit.cover,
                            height: 150,
                            width: MediaQuery.sizeOf(context).width * 1,
                          ),
                          errorWidget: (context, url, error) => Image.asset(
                            AppAssets.Marker,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: CachedNetworkImage(
                          imageUrl: widget.image[2],
                          fit: BoxFit.cover,
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) => Image.asset(
                            AppAssets.Marker,
                            fit: BoxFit.cover,
                            height: 150,
                            width: MediaQuery.sizeOf(context).width * 1,
                          ),
                          errorWidget: (context, url, error) => Image.asset(
                            AppAssets.Marker,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: CachedNetworkImage(
                          imageUrl: widget.image[3],
                          fit: BoxFit.cover,
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) => Image.asset(
                            AppAssets.Marker,
                            fit: BoxFit.cover,
                            height: 150,
                            width: MediaQuery.sizeOf(context).width * 1,
                          ),
                          errorWidget: (context, url, error) => Image.asset(
                            AppAssets.Marker,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 20,
                  ),
                  child: Text(
                    'Lịch sử',
                    style: AppTextStyle.headLineStyle,
                  ),
                ),
                Text(
                  widget.history,
                  style: AppTextStyle.bodyStyle,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 20,
                  ),
                  child: Text(
                    'Nguyên liệu',
                    style: AppTextStyle.headLineStyle,
                  ),
                ),
                Text(
                  widget.ingredients,
                  style: AppTextStyle.bodyStyle,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 20,
                  ),
                  child: Text(
                    'Đặc trưng',
                    style: AppTextStyle.headLineStyle,
                  ),
                ),
                Text(
                  widget.feature,
                  style: AppTextStyle.bodyStyle,
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              top: 20,
              bottom: MediaQuery.sizeOf(context).height * 0.1,
            ),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                onPressed: () {
                  pushWithoutNavBar(
                    context,
                    MaterialPageRoute(
                      builder: (context) => StepScreen(),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    "Tạo lịch trình",
                    style: AppTextStyle.buttonText,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
