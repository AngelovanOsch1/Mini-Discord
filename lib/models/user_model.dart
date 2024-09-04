import 'package:flutter_riverpod/flutter_riverpod.dart';
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
    return UserModel(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      banner: json['banner'],
      profilePhoto: json['profile_photo'],
      isOnline: json['is_online'] ?? false,
      role: json['role']
    );
  }
}

class UserModelNotifier extends StateNotifier<UserModel?> {
  UserModelNotifier() : super(null);

  void setUser(UserModel user) {
    state = user;
  }

  void clearUser() {
    state = null;
  }
}

final userModelProvider = StateNotifierProvider<UserModelNotifier, UserModel?>((ref) {
  return UserModelNotifier();
});
