import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ui_project/core/constant/assets.dart';
import 'package:ui_project/core/constant/color.dart';
import 'package:ui_project/presentation/screens/auth/login.dart';
import 'package:ui_project/presentation/screens/settings/app_profile.dart';
import 'package:ui_project/presentation/screens/settings/email_service.dart';
import 'package:ui_project/presentation/screens/settings/profile/profile_dialog.dart';
import 'package:ui_project/presentation/screens/settings/trips_screen.dart';
import 'package:ui_project/presentation/screens/settings/user_screen.dart';
import 'package:ui_project/presentation/widgets/list_settings.dart';
import 'package:ui_project/presentation/screens/select_screen.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  Map<String, dynamic> userData = {};
  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    checkAuthState();
    fetchUserData();
  }

  void checkAuthState() {
    final user = FirebaseAuth.instance.currentUser;
    setState(() {
      isLoggedIn = user != null;
    });
  }

  Future<void> fetchUserData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      setState(() {
        userData = snapshot.data() ?? {};
      });
    }
  }

  void _updateUserData(Map<String, dynamic> newData) {
    setState(() {
      userData = newData;
    });
  }

  Future<void> handleLogin(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Login()),
    );
    if (result == true) {
      checkAuthState();
      fetchUserData();
    }
  }

  Future<void> handleLogout(BuildContext context) async {
    bool? confirmLogout = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Xác nhận đăng xuất'),
          content: const Text('Bạn có chắc chắn muốn đăng xuất không?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Hủy'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Đăng xuất'),
            ),
          ],
        );
      },
    );

    if (confirmLogout == true) {
      await FirebaseAuth.instance.signOut();
      setState(() {
        isLoggedIn = false;
        userData = {};
      });
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const SelectPage()),
        (route) => false,
      );
    }
  }

  Widget _buildUserInfo() {
    if (!isLoggedIn) {
      return ListTile(
        leading: const CircleAvatar(
          radius: 30,
          child: Icon(Icons.person, size: 30),
        ),
        title: const Text('Chưa đăng nhập'),
        subtitle: const Text('Đăng nhập để truy cập thêm tính năng'),
      );
    }

    return ListTile(
      leading: CircleAvatar(
        radius: 30,
        backgroundImage: userData['avatar'] != null
            ? MemoryImage(base64Decode(userData['avatar']))
            : null,
        child: userData['avatar'] == null
            ? const Icon(Icons.person, size: 30)
            : null,
      ),
      title: Text(userData['fullName'] ?? ''),
      subtitle: Text(userData['email'] ?? ''),
      trailing: IconButton(
        icon: Icon(Icons.edit, color: AppColors.primaryColor),
        onPressed: () async {
          await showDialog(
            context: context,
            builder: (context) => ProfileDialog(userData: userData),
          ).then((newData) {
            if (newData != null) {
              _updateUserData(newData);
            }
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          children: [
            const SizedBox(height: 20),
            _buildUserInfo(),
            const SizedBox(height: 20),
            if (isLoggedIn) ...[
              ListSettings(
                leading: AppAssets.Person,
                title: 'Thông tin cá nhân',
                screen: UserScreen(userData: userData),
              ),
              ListSettings(
                leading: AppAssets.language,
                title: 'Lịch trình của tôi',
                screen: const TripsScreen(),
              ),
              ListTile(
                onTap: () async {
                  String? deleteReason;
                  bool? confirmDelete = await showDialog<bool>(
                    context: context,
                    builder: (BuildContext context) {
                      final TextEditingController reasonController = TextEditingController();

                      return StatefulBuilder(
                        builder: (context, setState) {
                          return AlertDialog(
                            title: const Text('Xác nhận xoá tài khoản'),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text('Bạn có chắc chắn muốn xoá tài khoản không?'),
                                const SizedBox(height: 16),
                                TextFormField(
                                  controller: reasonController,
                                  decoration: InputDecoration(
                                    labelText: 'Lý do xoá tài khoản',
                                    border: const OutlineInputBorder(),
                                    suffixIcon: reasonController.text.length < 30
                                        ? const Icon(Icons.error, color: Colors.red)
                                        : const Icon(Icons.check, color: Colors.green),
                                  ),
                                  maxLines: 3,
                                  onChanged: (value) {
                                    setState(() {});
                                    deleteReason = value;
                                  },
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  '${reasonController.text.length}/30 ký tự',
                                  style: TextStyle(
                                    color: reasonController.text.length < 30 ? Colors.red : Colors.green,
                                  ),
                                ),
                              ],
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop(false);
                                },
                                child: const Text('Hủy'),
                              ),
                              TextButton(
                                onPressed: () {
                                  if (reasonController.text.trim().length >= 30) {
                                    Navigator.of(context).pop(true);
                                  }
                                },
                                child: const Text('Xoá tài khoản'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  );

                  if (confirmDelete == true) {
                    final user = FirebaseAuth.instance.currentUser;
                    if (user != null) {
                      await EmailService.sendDeleteAccountRequest(user.email!, deleteReason!);
                      if (mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Yêu cầu xoá tài khoản đã được gửi, chúng tôi sẽ phản hồi lại cho bạn trong vòng 30 ngày.'),
                          ),
                        );
                      }
                    }
                  }
                },
                leading: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
                title: const Text(
                  'Xoá tài khoản',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
            ListSettings(
              leading: AppAssets.Family,
              title: 'Về chúng tôi',
              screen: const AppProfile(),
            ),
            ListTile(
              onTap: () {
                if (isLoggedIn) {
                  handleLogout(context);
                } else {
                  handleLogin(context);
                }
              },
              leading: SvgPicture.asset(
                isLoggedIn ? AppAssets.Logout : AppAssets.Logout,
                color: isLoggedIn?  Colors.red : Colors.green,
                height: 20,
                width: 20,
              ),
              title: Text(
                isLoggedIn ? 'Đăng xuất' : 'Đăng nhập',
                style: TextStyle(
                  color: isLoggedIn ? Colors.red : Colors.green,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}