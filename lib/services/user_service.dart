import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserService {
  final String apiUrl = "http://127.0.0.1:8080/users";
  final _storage = const FlutterSecureStorage();

  Future<List<UserModel>> fetchUsers() async {
    final token = await _storage.read(key: 'access_token');

    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<UserModel> users = body.map((dynamic item) => UserModel.fromJson(item)).toList();
      return users;
    } else {
      throw Exception("Failed to load users");
    }
  }
}
