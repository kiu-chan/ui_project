import 'package:flutter/material.dart';

class AppProfile extends StatelessWidget {
  const AppProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Thông tin ứng dụng',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.blueAccent,
        elevation: 1,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.blue[50],
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 5,
                  spreadRadius: 1,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: const Text(
              'Ứng dụng Hà Nội vibe là ứng dụng phi lợi nhuận được nhóm chúng tôi phát triển với mục đích quảng bá văn hoá Hà Nội',
              style: TextStyle(fontSize: 18, color: Colors.black87),
              textAlign: TextAlign.justify,
            ),
          ),
          const SizedBox(height: 20),
          const Center(
            child: Text(
              'Danh sách thành viên',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
          ),
          const SizedBox(height: 20),
          TeamMemberCard(
            name: 'Hoàng Bảo Khanh',
            role: 'Trưởng nhóm',
            avatarAsset: 'assets/images/avatar1.jpg',
          ),
          TeamMemberCard(
            name: 'Nguyễn Khánh Linh',
            role: 'Thiết kế UI/UX',
            avatarAsset: 'assets/images/avatar2.jpg',
          ),
          TeamMemberCard(
            name: 'Lê Khánh Toàn',
            role: 'Lập trình viên',
            avatarAsset: 'assets/images/avatar3.jpg',
          ),
          TeamMemberCard(
            name: 'Nguyễn Thị Hoài Thu',
            role: 'Database',
            avatarAsset: 'assets/images/avatar3.jpg',
          ),
        ],
      ),
    );
  }
}

class TeamMemberCard extends StatelessWidget {
  final String name;
  final String role;
  final String avatarAsset;

  const TeamMemberCard({
    Key? key,
    required this.name,
    required this.role,
    required this.avatarAsset,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 2,
      shadowColor: Colors.black.withOpacity(0.1),
      color: Colors.white,
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: CircleAvatar(
          radius: 30,
          backgroundColor: Colors.blue[100],
          backgroundImage: AssetImage(avatarAsset),
        ),
        title: Text(
          name,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.blueAccent,
          ),
        ),
        subtitle: Text(
          role,
          style: const TextStyle(fontSize: 16, color: Colors.black54),
        ),
      ),
    );
  }
}
