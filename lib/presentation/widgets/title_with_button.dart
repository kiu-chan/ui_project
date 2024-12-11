import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:ui_project/core/constant/color.dart';
import 'package:ui_project/core/constant/textStyle.dart';

class TitleWithButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  const TitleWithButton({
    Key? key,
    required this.title,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: AppTextStyle.headLineStyle,
        ),
        TextButton(
          onPressed: onPressed,
          child: Row(
            children: [
              Text(
                'Tất cả',
                style: AppTextStyle.viewAllStyle,
              ),
              SizedBox(
                width: 5,
              ),
              Icon(
                LucideIcons.arrowRight,
                color: AppColors.primaryColor,
                size: 18,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
