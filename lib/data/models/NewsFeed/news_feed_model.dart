import 'package:cloud_firestore/cloud_firestore.dart';

class NewsFeedModel {
  final String content;
  final String imageUrl;
  final Timestamp timestamp;
  final String userId;
  final String userName;
  final String avatar;

  NewsFeedModel({
    required this.content,
    required this.imageUrl,
    required this.timestamp,
    required this.userId,
    required this.userName,
    required this.avatar,
  });

  factory NewsFeedModel.fromJson(Map<String, dynamic> json) {
    return NewsFeedModel(
      content: json['content'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      timestamp: (json['timestamp']),
      userId: json['userId'] ?? 0,
      userName: json['userName'] ?? '',
      avatar: json['avatar'] ?? '',
    );
  }
}
