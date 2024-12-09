import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:ui_project/core/constant/assets.dart';
import 'package:ui_project/core/constant/color.dart';
import 'package:ui_project/core/constant/textStyle.dart';
import 'package:ui_project/presentation/widgets/map/marker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ui_project/presentation/widgets/detail.dart';
import 'package:ui_project/presentation/widgets/detail_food.dart';

class CardMap extends StatelessWidget {
  final String title;
  final LatLng location;
  final String image;
  final String address;
  final String description;
  final String history;
  final String feature;
  final bool isFood;
  final String? ingredients;
  final List<String> images;

  const CardMap({
    super.key,
    required this.title,
    required this.location,
    required this.image,
    required this.address,
    required this.description,
    required this.history,
    required this.feature,
    this.isFood = false,
    this.ingredients,
    required this.images,
  });

  String _truncateText(String text, int maxLength) {
    if (text.length <= maxLength) return text;
    return '${text.substring(0, maxLength)}...';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          barrierColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          context: context,
          builder: (BuildContext context) {
            return Container(
              height: MediaQuery.sizeOf(context).height * 0.45,
              margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height * 0.12,
                left: 15,
                right: 15,
              ),
              padding: EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 15,
              ),
              decoration: BoxDecoration(
                color: AppColors.backGroundColor,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: ListView(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      imageUrl: image,
                      height: MediaQuery.sizeOf(context).height * 0.15,
                      fit: BoxFit.cover,
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) => Image.asset(
                        AppAssets.Marker,
                        fit: BoxFit.cover,
                      ),
                      errorWidget: (context, url, error) => Image.asset(
                        AppAssets.Marker,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    title,
                    style: AppTextStyle.headStyle,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.location_on, 
                           color: AppColors.primaryColor,
                           size: 16),
                      SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          address,
                          style: AppTextStyle.bodyStyle1,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    _truncateText(description, 150),
                    style: AppTextStyle.bodyStyle,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          icon: Icon(
                            Icons.directions,
                            color: Colors.white,
                            size: 18,
                          ),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              AppColors.primaryColor,
                            ),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          onPressed: () async {
                            final Uri url = Uri.parse(
                                'https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(title)}');
                            if (!await launchUrl(url,
                                mode: LaunchMode.externalApplication)) {
                              throw 'Could not launch $url';
                            }
                          },
                          label: Text(
                            'Đường đi',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton.icon(
                          icon: Icon(
                            Icons.info_outline,
                            color: Colors.white,
                            size: 18,
                          ),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              AppColors.primaryColor,
                            ),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => isFood
                                    ? DetailFoodPage(
                                        title: title,
                                        image: images,
                                        address: address,
                                        description: description,
                                        history: history,
                                        feature: feature,
                                        ingredients: ingredients!,
                                      )
                                    : DetailPage(
                                        title: title,
                                        image: images,
                                        address: address,
                                        description: description,
                                        history: history,
                                        feature: feature,
                                      ),
                              ),
                            );
                          },
                          label: Text(
                            'Chi tiết',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
      child: MarkerMap(
        image: image,
      ),
    );
  }
}