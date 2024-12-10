import 'package:flutter/material.dart';
import 'package:ui_project/core/constant/textStyle.dart';

class UserInfo extends StatelessWidget {
  final String title;
  final String info;
  const UserInfo({
    super.key,
    required this.title,
    required this.info,
  });

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: const EdgeInsets.only(
          left: 24,
          bottom: 5,
          top: 24,
        ),
        child: Text(
          title,
          style: AppTextStyle.bodyStyle,
        ),
      ),
      Container(
        width: MediaQuery.sizeOf(context).width * 1,
        margin: const EdgeInsets.only(
          left: 24,
          right: 24,
        ),
        padding: const EdgeInsets.only(
          top: 16,
          bottom: 16,
          left: 15,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: const Color.fromRGBO(225, 225, 225, 1),
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          info,
          style: AppTextStyle.subUser,
        ),
      ),
    ]);
  }
}
