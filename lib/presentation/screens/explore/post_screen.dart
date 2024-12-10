import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'dart:io';
import '../../../core/constant/color.dart';
import '../../../core/constant/textStyle.dart';

class PostScreen extends StatefulWidget {
  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final TextEditingController _contentController = TextEditingController();
  File? _selectedImage;

  Future<void> _pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
      });
    }
  }

  Future<void> _uploadPost() async {
    if (_contentController.text.isEmpty) return;

    // Upload image to Firebase Storage if an image is selected (optional)
    String? imageUrl;
    if (_selectedImage != null) {
      // Upload image code goes here
      // Example: final ref = FirebaseStorage.instance.ref().child('post_images').child(imageName);
    }

    // Add post to Firestore
    await FirebaseFirestore.instance.collection('posts').add({
      'userId': '',
      'userName': '',
      'content': _contentController.text,
      'imageUrl': imageUrl,
      'timestamp': FieldValue.serverTimestamp(),
    });

    _contentController.clear();
    setState(() {
      _selectedImage = null;
    });

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backGroundColor,
        centerTitle: true,
        title: Text(
          'Tạo bài viết',
          style: AppTextStyle.appBarStyle,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _contentController,
              maxLines: 5,
              style: const TextStyle(
                color: Colors.black,
              ),
              decoration: InputDecoration(
                hintText: "Có gì mới?",
                hintStyle: const TextStyle(
                  color: Color.fromARGB(255, 120, 120, 120),
                ),
                filled: true,
                fillColor: Color.fromARGB(255, 240, 238, 238),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 240, 238, 238),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: const Icon(
                          LucideIcons.smile,
                          color: AppColors.primaryColor,
                        ),
                        onPressed: () {},
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    if (_selectedImage != null)
                      Image.file(_selectedImage!,
                          height: 150, fit: BoxFit.cover),
                    Container(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 240, 238, 238),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: const Icon(
                          LucideIcons.image,
                          color: AppColors.primaryColor,
                        ),
                        onPressed: () {
                          _pickImage();
                        },
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  onPressed: () {
                    _uploadPost();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: const Text(
                      "Đăng bài",
                      style: AppTextStyle.buttonText,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
