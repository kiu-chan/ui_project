// lib/presentation/screens/settings/setting_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ui_project/core/constant/assets.dart';
import 'package:ui_project/core/constant/color.dart';
import 'package:ui_project/presentation/screens/auth/login.dart';
import 'package:ui_project/presentation/screens/settings/user_screen.dart';
import 'package:ui_project/presentation/widgets/appbar_root.dart';
import 'package:ui_project/presentation/widgets/list_settings.dart';
import 'package:ui_project/presentation/screens/auth/login.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      appBar: AppbarRoot(
        title: 'Cài đặt',
      ),
      body: ListView(
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
        ),
        children: [
          ListSettings(
            leading: AppAssets.Person,
            title: 'Thông tin cá nhân',
            screen: const UserScreen(),
          ),
          ListSettings(
            leading: AppAssets.language,
            title: 'Ngôn ngữ',
            screen: const UserScreen(),
          ),
          ListSettings(
            leading: AppAssets.ThemeMode,
            title: 'Giao diện',
            screen: const UserScreen(),
          ),
          ListTile(
            onTap: () async {
              bool? confirmLogout = await showDialog<bool>(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Xác nhận đăng xuất'),
                    content:
                        const Text('Bạn có chắc chắn muốn đăng xuất không?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                        child: const Text('Hủy'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(true);
                        },
                        child: const Text('Đăng xuất'),
                      ),
                    ],
                  );
                },
              );

              if (confirmLogout == true) {
                pushWithoutNavBar(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Login(),
                  ),
                );
              }
            },
            leading: SvgPicture.asset(
              AppAssets.Logout,
              // ignore: deprecated_member_use
              color: Colors.red,
              height: 20,
              width: 20,
            ),
            title: const Text(
              'Đăng xuất',
              style: TextStyle(
                color: Colors.red,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}