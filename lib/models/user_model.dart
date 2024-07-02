class UserModel {
  final int id;
  final String username;
  final String email;
  final String? banner;
  final String? profilePhoto;
  final bool isOnline;
  final String role;

  UserModel({required this.id, required this.username, required this.email, this.banner, this.profilePhoto, required this.isOnline, required this.role});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    print(json);
    return UserModel(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      banner: json['banner'],
      profilePhoto: json['profile_photo'],
      isOnline: json['isOnline'] == 1,
      role: json['role']
    );
  }
}
