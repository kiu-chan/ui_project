// lib/presentation/screens/settings/setting_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ui_project/core/constant/assets.dart';
import 'package:ui_project/core/constant/color.dart';
import 'package:ui_project/presentation/screens/settings/profile/profile_dialog.dart';
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
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser?.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          final userData = snapshot.data?.data() as Map<String, dynamic>? ?? {};

          return ListView(
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 15),
            children: [
              ListSettings(
                leading: AppAssets.Person,
                title: 'Thông tin cá nhân',
                onPressed: () => showDialog(
                  context: context,
                  builder: (context) => ProfileDialog(userData: userData),
                ),
              ),
              ListSettings(
                leading: AppAssets.language,
                title: 'Ngôn ngữ',
                onPressed: () {},
              ),
              ListSettings(
                leading: AppAssets.ThemeMode,
                title: 'Giao diện',
                onPressed: () {},
              ),
              ListTile(
                onTap: () async {
                  await FirebaseAuth.instance.signOut();
                  if (context.mounted) {
                    pushWithoutNavBar(
                      context,
                      MaterialPageRoute(builder: (context) => Login()),
                    );
                  }
                },
                leading: SvgPicture.asset(
                  AppAssets.Logout,
                  color: Colors.red,
                  height: 20,
                  width: 20,
                ),
                title: Text(
                  'Đăng xuất',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}