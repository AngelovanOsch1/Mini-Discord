class UserModel {
  final int id;
  final String username;
  final String email;
  final String? banner;
  final String? profilePhoto;
  final bool isOnline;

  UserModel({required this.id, required this.username, required this.email, this.banner, this.profilePhoto, required this.isOnline});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      banner: json['banner'],
      profilePhoto: json['profile_photo'] as String?,
      isOnline: json['isOnline']
    );
  }
}
