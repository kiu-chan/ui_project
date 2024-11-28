import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:ui_project/presentation/screens/explore/news_feed.dart';

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

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NewsfeedScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Create Post")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _contentController,
              decoration: InputDecoration(labelText: "What's on your mind?"),
              maxLines: 4,
            ),
            SizedBox(height: 10),
            if (_selectedImage != null)
              Image.file(_selectedImage!, height: 150, fit: BoxFit.cover),
            SizedBox(height: 10),
            Row(
              children: [
                ElevatedButton(
                  onPressed: _pickImage,
                  child: Text("Add Image"),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _uploadPost,
                  child: Text("Post"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
