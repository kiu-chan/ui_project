import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ui_project/core/constant/textStyle.dart';


Widget cardPopular(
  Widget image,
  String title,
  SvgPicture flag,
  String address,
  Widget widget,
 
) {
  return SizedBox(
    width: 220,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            SizedBox(
              height: 140,
              width: 220,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                    20,
                  ),
                  child: image,
                  ),
            ),
            // save
            widget,
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          title,
          style: AppTextStyle.headLineStyle,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            flag,
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
        )
      ],
    ),
  );
}
