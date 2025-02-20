import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ui_project/core/constant/assets.dart';
import 'package:ui_project/core/constant/color.dart';
import 'package:ui_project/presentation/screens/auth/login.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _fullNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Future<void> _registerUser() async {
    if (_formKey.currentState!.validate()) {
      try {
        if (_passwordController.text.trim() != _confirmPasswordController.text.trim()) {
          _showSnackbar('Passwords do not match');
          return;
        }

        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );

        await _saveUserToFirestore(
          userCredential.user!.uid,
          _fullNameController.text.trim(),
          _emailController.text.trim(),
        );

        _showSnackbar('Registration successful!');
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Login()),
        );
      } catch (e) {
        _showSnackbar('Error: ${e.toString()}');
      }
    }
  }

  Future<void> _saveUserToFirestore(String userId, String fullName, String email) async {
    int userNumericId = await _generateUniqueUserId();

    await FirebaseFirestore.instance.collection('users').doc(userId).set({
      'userId': userNumericId,
      'fullName': fullName,
      'email': email,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  Future<int> _generateUniqueUserId() async {
    final random = Random();
    int userId = 0;
    bool isUnique = false;

    while (!isUnique) {
      userId = 10000 + random.nextInt(90000);
      final querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('userId', isEqualTo: userId)
          .get();

      if (querySnapshot.docs.isEmpty) {
        isUnique = true;
      }
    }
    return userId;
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _fullNameController.dispose();
    super.dispose();
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    bool obscureText = false,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: labelText,
          filled: true,
          fillColor: Colors.grey[200],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.blue),
          ),
        ),
        validator: validator,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Đăng ký'),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    AppAssets.Marker,
                    width: 100,
                    height: 100,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Hello there!',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Hãy điền thông tin của bạn!',
                    style: TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 20),

                  _buildTextField(
                    controller: _fullNameController,
                    labelText: 'Họ tên',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your full name';
                      }
                      return null;
                    },
                  ),

                  _buildTextField(
                    controller: _emailController,
                    labelText: 'Email',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                        return 'Enter a valid email';
                      }
                      return null;
                    },
                  ),

                  _buildTextField(
                    controller: _passwordController,
                    labelText: 'Mật khẩu',
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  ),

                  _buildTextField(
                    controller: _confirmPasswordController,
                    labelText: 'Nhập lại mật khẩu',
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please confirm your password';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: ElevatedButton(
                      onPressed: _registerUser,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        padding: const EdgeInsets.all(16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          'Đăng ký',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Bạn đã có tài khoản?',
                        style: TextStyle(color: Colors.black54),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Login(),
                            ),
                          );
                        },
                        child: const Text(
                          ' Đăng nhập',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}