import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ui_project/core/constant/assets.dart';

class MarkerMap extends StatelessWidget {
  final String image;
  const MarkerMap({
    super.key,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SvgPicture.asset(
          AppAssets.MarkerMap,
          width: 50,
          height: 50,
        ),
        Positioned(
          top: 8,
          left: 10,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: CachedNetworkImage(
              imageUrl: image,
              fit: BoxFit.cover,
              width: 20,
              height: 20,
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
    );
  }
}
