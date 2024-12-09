import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ui_project/core/constant/assets.dart';
import 'package:ui_project/core/constant/color.dart';
import 'package:ui_project/core/constant/textStyle.dart';
import 'package:ui_project/presentation/widgets/appbar_root.dart';
import 'package:ui_project/presentation/widgets/list_settings.dart';
import 'package:ui_project/presentation/screens/auth/login.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final _formKey = GlobalKey<FormState>();
  bool isEditing = false;
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _birthDateController;
  late TextEditingController _userIdController;
  String? avatarUrl;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _birthDateController = TextEditingController();
    _userIdController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _birthDateController.dispose();
    _userIdController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2003),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _birthDateController.text = "${picked.month}/${picked.day}/${picked.year}";
      });
    }
  }

  Future<void> _updateUserData() async {
    if (_formKey.currentState!.validate()) {
      try {
        final user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
            'fullName': _nameController.text,
            'email': _emailController.text,
            'dateOfBirth': _birthDateController.text,
            'userId': _userIdController.text,
            'avatar': avatarUrl,
            'createdAt': DateTime.now().toUtc().add(Duration(hours: 7)).toString(),
          }, SetOptions(merge: true));

          setState(() => isEditing = false);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Cập nhật thông tin thành công')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Lỗi khi cập nhật thông tin: $e')),
        );
      }
    }
  }

  void _showProfileDialog(Map<String, dynamic> userData) {
    // Khởi tạo giá trị cho controllers từ userData
    _nameController.text = userData['fullName'] ?? '';
    _emailController.text = userData['email'] ?? '';
    _birthDateController.text = userData['dateOfBirth'] ?? '';
    _userIdController.text = userData['userId']?.toString() ?? '';
    avatarUrl = userData['avatar'];

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Thông tin cá nhân',
                          style: AppTextStyle.headLineStyle,
                        ),
                        IconButton(
                          icon: Icon(
                            isEditing ? Icons.check : Icons.edit,
                            color: AppColors.primaryColor,
                          ),
                          onPressed: () {
                            if (isEditing) {
                              _updateUserData().then((_) {
                                setState(() => isEditing = false);
                              });
                            } else {
                              setState(() => isEditing = true);
                            }
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: avatarUrl != null ? NetworkImage(avatarUrl!) : null,
                      backgroundColor: Colors.grey[200],
                      child: avatarUrl == null
                          ? Icon(Icons.person, size: 50, color: Colors.grey)
                          : null,
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Created: ${userData['createdAt'] ?? 'Not available'}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 20),
                    _buildTextField(
                      controller: _nameController,
                      label: 'Họ và tên',
                      enabled: isEditing,
                    ),
                    SizedBox(height: 10),
                    _buildTextField(
                      controller: _emailController,
                      label: 'Email',
                      enabled: false,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(height: 10),
                    _buildTextField(
                      controller: _birthDateController,
                      label: 'Ngày sinh',
                      enabled: isEditing,
                      readOnly: true,
                      onTap: isEditing ? () => _selectDate(context) : null,
                      suffixIcon: isEditing
                          ? Icon(Icons.calendar_today, color: AppColors.primaryColor)
                          : null,
                    ),
                    SizedBox(height: 10),
                    _buildTextField(
                      controller: _userIdController,
                      label: 'User ID',
                      enabled: false,
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF40B59F),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text(
                        'Đóng',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    bool enabled = true,
    TextInputType? keyboardType,
    bool readOnly = false,
    VoidCallback? onTap,
    Widget? suffixIcon,
  }) {
    return TextFormField(
      controller: controller,
      enabled: enabled,
      readOnly: readOnly,
      keyboardType: keyboardType,
      onTap: onTap,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.grey),
        border: UnderlineInputBorder(),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.primaryColor),
        ),
        suffixIcon: suffixIcon,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Vui lòng nhập $label';
        }
        return null;
      },
    );
  }

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
                onPressed: () => _showProfileDialog(userData),
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
                  if (!mounted) return;
                  pushWithoutNavBar(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Login(),
                    ),
                  );
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