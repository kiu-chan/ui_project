import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ui_project/presentation/screens/home/home_screen.dart';
import 'package:ui_project/presentation/screens/select_screen.dart';

Future<void> handleLogout(BuildContext context) async {
  bool? confirmLogout = await showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Xác nhận đăng xuất'),
        content: const Text('Bạn có chắc chắn muốn đăng xuất không?'),
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
    await FirebaseAuth.instance.signOut();
    // Navigate to HomePage and clear the navigation stack
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => SelectPage(),
      ),
      (route) => false,
    );
  }
}