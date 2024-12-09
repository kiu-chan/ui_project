import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ui_project/core/constant/color.dart';
import 'package:ui_project/core/constant/textStyle.dart';
import 'package:ui_project/presentation/screens/explore/post_screen.dart';

class PostListScreen extends StatelessWidget {
  const PostListScreen({Key? key}) : super(key: key);

  // Xử lý chữ cái đầu cho avatar
  String getInitial(String? userName) {
    if (userName == null || userName.isEmpty) {
      return 'U';
    }
    return userName[0].toUpperCase();
  }

  // Xây dựng avatar từ base64 string hoặc chữ cái đầu
  Widget buildAvatar(String? avatarString, String? userName) {
    if (avatarString != null && avatarString.isNotEmpty) {
      try {
        return CircleAvatar(
          radius: 20,
          backgroundColor: AppColors.primaryColor,
          backgroundImage: MemoryImage(base64Decode(avatarString)),
        );
      } catch (e) {
        // Fallback nếu decode base64 thất bại
        return CircleAvatar(
          radius: 20,
          backgroundColor: AppColors.primaryColor,
          child: Text(
            getInitial(userName),
            style: TextStyle(color: Colors.white),
          ),
        );
      }
    }
    return CircleAvatar(
      radius: 20,
      backgroundColor: AppColors.primaryColor,
      child: Text(
        getInitial(userName),
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  // Xây dựng phần header của bài post
  Widget buildPostHeader(Map<String, dynamic> post) {
    final userName = post['userName'] as String? ?? 'Người dùng';
    final timestamp = post['timestamp'] as Timestamp?;
    final avatarString = post['userAvatar'] as String?;

    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 16),
      leading: buildAvatar(avatarString, userName),
      title: Text(userName, style: AppTextStyle.headLineStyle),
      subtitle: Text(
        timestamp != null 
            ? timestamp.toDate().toString()
            : 'Vừa xong',
        style: AppTextStyle.bodyStyle,
      ),
    );
  }

  // Xây dựng phần nội dung của bài post
  Widget buildPostContent(Map<String, dynamic> post) {
    final content = post['content'] as String?;
    return content != null && content.isNotEmpty
        ? Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(content, style: AppTextStyle.bodyStyle),
          )
        : SizedBox.shrink();
  }

  // Xây dựng phần hình ảnh của bài post
  Widget buildPostImage(Map<String, dynamic> post) {
    final imageUrl = post['imageUrl'] as String?;
    if (imageUrl == null || imageUrl.isEmpty) return SizedBox.shrink();

    try {
      return Container(
        width: double.infinity,
        constraints: BoxConstraints(maxHeight: 300),
        child: Image.memory(
          base64Decode(imageUrl),
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => SizedBox.shrink(),
        ),
      );
    } catch (e) {
      return SizedBox.shrink();
    }
  }

  // Xây dựng phần tương tác của bài post
  Widget buildInteractionBar(Map<String, dynamic> post) {
    final likes = post['likes'] as int? ?? 0;
    final comments = post['comments'] as int? ?? 0;

    return Padding(
      padding: EdgeInsets.all(16),
      child: Row(
        children: [
          Icon(Icons.favorite_border, color: Colors.grey),
          SizedBox(width: 8),
          Text('$likes', style: AppTextStyle.bodyStyle),
          SizedBox(width: 16),
          Icon(Icons.comment_outlined, color: Colors.grey),
          SizedBox(width: 8),
          Text('$comments bình luận', style: AppTextStyle.bodyStyle),
        ],
      ),
    );
  }

  // Xây dựng các nút tương tác
  Widget buildActionButtons(Map<String, dynamic> post) {
    return Row(
      children: [
        Expanded(
          child: TextButton.icon(
            onPressed: () {},
            icon: Icon(Icons.favorite_border),
            label: Text('Thích'),
            style: TextButton.styleFrom(foregroundColor: Colors.grey[600]),
          ),
        ),
        VerticalDivider(width: 1),
        Expanded(
          child: TextButton.icon(
            onPressed: () {},
            icon: Icon(Icons.comment_outlined),
            label: Text('Bình luận'),
            style: TextButton.styleFrom(foregroundColor: Colors.grey[600]),
          ),
        ),
      ],
    );
  }

  // Xây dựng thanh tạo bài viết
  Widget buildCreatePostBar() {
    return Card(
      margin: EdgeInsets.all(16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser?.uid)
            .snapshots(),
        builder: (context, snapshot) {
          final userData = snapshot.data?.data() as Map<String, dynamic>?;
          final userName = userData?['fullName'] as String? ?? 'Người dùng';
          final avatarString = userData?['avatar'] as String?;

          return ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            leading: buildAvatar(avatarString, userName),
            title: Text(
              'Bạn đang nghĩ gì?',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 16,
              ),
            ),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => PostScreen()),
            ),
          );
        },
      ),
    );
  }

  // Xây dựng card bài viết hoàn chỉnh
  Widget buildPostCard(Map<String, dynamic> post) {
    return Card(
      margin: EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildPostHeader(post),
          buildPostContent(post),
          buildPostImage(post),
          buildInteractionBar(post),
          Divider(height: 1),
          buildActionButtons(post),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildCreatePostBar(),
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('posts')
                .orderBy('timestamp', descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    'Đã có lỗi xảy ra',
                    style: AppTextStyle.bodyStyle,
                  ),
                );
              }

              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return Center(
                  child: Text(
                    'Chưa có bài đăng nào',
                    style: AppTextStyle.bodyStyle,
                  ),
                );
              }

              return ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 16),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  try {
                    final post = snapshot.data!.docs[index].data() 
                        as Map<String, dynamic>;
                    return buildPostCard(post);
                  } catch (e) {
                    return SizedBox.shrink();
                  }
                },
              );
            },
          ),
        ),
      ],
    );
  }
}