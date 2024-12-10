import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:ui_project/core/constant/assets.dart';
import 'package:ui_project/core/constant/color.dart';
import 'package:ui_project/core/constant/textStyle.dart';
import 'package:ui_project/presentation/widgets/marker.dart';
import 'package:url_launcher/url_launcher.dart';

class CardMap extends StatelessWidget {
  final String title;
  final LatLng location;
  final String image;
  final String address;

  const CardMap({
    super.key,
    required this.title,
    required this.location,
    required this.image,
    required this.address,
  });

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
              height: MediaQuery.sizeOf(context).height * 0.38,
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
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    title,
                    style: AppTextStyle.headStyle,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    address,
                    style: AppTextStyle.bodyStyle1,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(
                        AppColors.primaryColor,
                      ),
                      shape: WidgetStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                    ),
                    onPressed: () async {
                      final Uri url = Uri.parse(
                          'https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(address)}');

                      if (!await launchUrl(url,
                          mode: LaunchMode.externalApplication)) {
                        throw 'Could not launch $url';
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Đường đi',
                        style: AppTextStyle.buttonText,
                      ),
                    ),
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
