import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ui_project/core/constant/assets.dart';
import 'package:ui_project/core/constant/color.dart';
import 'package:ui_project/core/constant/textStyle.dart';
import 'package:ui_project/presentation/widgets/custome_appbar.dart';

class ProfileScreen extends StatefulWidget {
  final String userId;
  
  const ProfileScreen({
    Key? key,
    required this.userId,
  }) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  bool isEditing = false;
  
  // Controllers for editing
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _addressController;
  late TextEditingController _birthDateController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    _addressController = TextEditingController();
    _birthDateController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _birthDateController.dispose();
    super.dispose();
  }

  Future<void> _updateUserData() async {
    if (_formKey.currentState!.validate()) {
      try {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(widget.userId)
            .update({
          'fullName': _nameController.text,
          'phone': _phoneController.text,
          'address': _addressController.text,
          'dateOfBirth': _birthDateController.text,
        });
        setState(() {
          isEditing = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Profile updated successfully')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error updating profile')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      appBar: CustomeAppbar(title: 'Thông tin cá nhân'),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(widget.userId)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Đã xảy ra lỗi'));
          }

          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          final userData = snapshot.data!.data() as Map<String, dynamic>;
          
          // Set controller values when data is loaded
          if (!isEditing) {
            _nameController.text = userData['fullName'] ?? '';
            _emailController.text = userData['email'] ?? '';
            _phoneController.text = userData['phone'] ?? '';
            _addressController.text = userData['address'] ?? '';
            _birthDateController.text = userData['dateOfBirth'] ?? '';
          }

          return SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Stack(
                      children: [
                        Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.primaryColor,
                              width: 2,
                            ),
                          ),
                          child: ClipOval(
                            child: CachedNetworkImage(
                              imageUrl: userData['avatar'] ?? '',
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Image.asset(
                                AppAssets.Marker,
                                fit: BoxFit.cover,
                              ),
                              errorWidget: (context, url, error) => Icon(
                                Icons.person,
                                size: 60,
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ),
                        ),
                        if (isEditing)
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.primaryColor,
                                shape: BoxShape.circle,
                              ),
                              child: IconButton(
                                icon: Icon(Icons.camera_alt, color: Colors.white),
                                onPressed: () {
                                  // Implement image picker
                                },
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24),
                  _buildTextField(
                    label: 'Họ và tên',
                    controller: _nameController,
                    enabled: isEditing,
                  ),
                  _buildTextField(
                    label: 'Email',
                    controller: _emailController,
                    enabled: false,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  _buildTextField(
                    label: 'Số điện thoại',
                    controller: _phoneController,
                    enabled: isEditing,
                    keyboardType: TextInputType.phone,
                  ),
                  _buildTextField(
                    label: 'Địa chỉ',
                    controller: _addressController,
                    enabled: isEditing,
                  ),
                  _buildTextField(
                    label: 'Ngày sinh',
                    controller: _birthDateController,
                    enabled: isEditing,
                  ),
                  SizedBox(height: 24),
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: () {
                        if (isEditing) {
                          _updateUserData();
                        } else {
                          setState(() {
                            isEditing = true;
                          });
                        }
                      },
                      child: Text(
                        isEditing ? 'Lưu thông tin' : 'Chỉnh sửa',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required bool enabled,
    TextInputType? keyboardType,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        enabled: enabled,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: AppTextStyle.bodyStyle,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: AppColors.primaryColor,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: AppColors.primaryColor,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: AppColors.primaryColor,
              width: 2,
            ),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Vui lòng nhập $label';
          }
          return null;
        },
      ),
    );
  }
}