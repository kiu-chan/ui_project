class UsersModel {
  final String fullName;
  final String email;
  final String dOb;
  final String avatar;
  final int userId;
  UsersModel({
    required this.fullName,
    required this.email,
    required this.dOb,
    required this.avatar,
    required this.userId,
  });

  factory UsersModel.fromJson(Map<String, dynamic> json) {
    return UsersModel(
      fullName: json['fullName'] ?? '',
      email: json['email'] ?? '',
      dOb: json['dateOfBirth'] ?? '',
      avatar: json['avatar'] ?? '',
      userId: json['userId'] ?? 0,
    );
  }

  firstWhere(bool Function(dynamic user) param0, {required Null Function() orElse}) {}
}
