import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:user_list_app/user.dart';

class ApiService{
  static String apiUrl = 'https://jsonplaceholder.typicode.com/users';
  Future<List<User>> fetchUsers() async {
    final response = await http.get(Uri.parse(apiUrl));
    if(response.statusCode == 200){
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => User.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }
}