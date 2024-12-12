import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ui_project/core/constant/color.dart';
import 'package:ui_project/core/constant/textStyle.dart';
import 'package:ui_project/presentation/widgets/user_info.dart';

class UserScreen extends StatefulWidget {
  final Map<String, dynamic> userData;

  const UserScreen({Key? key, required this.userData}) : super(key: key);

  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final _formKey = GlobalKey<FormState>();
  bool isEditing = false;
  bool isLoading = false;
  
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _birthDateController;
  late TextEditingController _phoneController;
  String? _avatarBase64;

  @override
  void initState() {
    super.initState();
    _initializeControllers();
  }

  void _initializeControllers() {
    _nameController = TextEditingController(text: widget.userData['fullName'] ?? '');
    _emailController = TextEditingController(text: widget.userData['email'] ?? '');
    _birthDateController = TextEditingController(text: widget.userData['dateOfBirth'] ?? '');
    _phoneController = TextEditingController(text: widget.userData['phone'] ?? '');
    _avatarBase64 = widget.userData['avatar'];
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _birthDateController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    try {
      setState(() => isLoading = true);
      
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 512,
        maxHeight: 512,
        imageQuality: 70,
      );

      if (image == null) {
        setState(() => isLoading = false);
        return;
      }

      final bytes = await image.readAsBytes();
      final base64String = base64Encode(bytes);
      
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .update({'avatar': base64String});

      setState(() {
        _avatarBase64 = base64String;
        isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Cập nhật ảnh đại diện thành công')),
      );
    } catch (e) {
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Lỗi khi cập nhật ảnh: $e')),
      );
    }
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        _birthDateController.text = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  Future<void> _updateProfile() async {
    if (!_formKey.currentState!.validate()) return;

    try {
      setState(() => isLoading = true);

      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .update({
        'fullName': _nameController.text,
        'dateOfBirth': _birthDateController.text,
        'phone': _phoneController.text,
      });

      setState(() => isEditing = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Cập nhật thông tin thành công')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Lỗi khi cập nhật thông tin: $e')),
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  Widget _buildAvatar() {
    ImageProvider? imageProvider;
    if (_avatarBase64 != null && _avatarBase64!.isNotEmpty) {
      try {
        imageProvider = MemoryImage(base64Decode(_avatarBase64!));
      } catch (e) {
        print('Error decoding image: $e');
      }
    }

    return Stack(
      children: [
        CircleAvatar(
          radius: 75,
          backgroundColor: Colors.grey[200],
          backgroundImage: imageProvider,
          child: imageProvider == null
              ? Icon(Icons.person, size: 75, color: Colors.grey)
              : null,
        ),
        if (isEditing)
          Positioned(
            bottom: 0,
            right: 0,
            child: GestureDetector(
              onTap: !isLoading ? _pickImage : null,
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.camera_alt, color: Colors.white, size: 20),
              ),
            ),
          ),
        if (isLoading)
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black38,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
            ),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backGroundColor,
        centerTitle: true,
        title: Text(
          'Thông tin người dùng',
          style: AppTextStyle.appBarStyle,
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() => isEditing = !isEditing);
              if (!isEditing) _updateProfile();
            },
            icon: Icon(isEditing ? Icons.check : Icons.edit),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _buildAvatar(),
                SizedBox(height: 16),
                TextFormField(
                  controller: _nameController,
                  enabled: isEditing,
                  decoration: InputDecoration(labelText: 'Họ và tên'),
                  validator: (val) =>
                      val!.isEmpty ? 'Vui lòng nhập họ và tên' : null,
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _emailController,
                  enabled: false,
                  decoration: InputDecoration(labelText: 'Email'),
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _birthDateController,
                  enabled: isEditing,
                  decoration: InputDecoration(
                    labelText: 'Ngày sinh',
                    suffixIcon: isEditing
                        ? IconButton(
                            onPressed: _selectDate,
                            icon: Icon(Icons.calendar_today),
                          )
                        : null,
                  ),
                  validator: (val) =>
                      val!.isEmpty ? 'Vui lòng chọn ngày sinh' : null,
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _phoneController,
                  enabled: isEditing,
                  decoration: InputDecoration(labelText: 'Số điện thoại'),
                  validator: (val) => val!.isEmpty
                      ? 'Vui lòng nhập số điện thoại'
                      : null,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}