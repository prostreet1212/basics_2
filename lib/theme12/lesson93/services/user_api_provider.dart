import 'package:basics_2/theme12/lesson93/model/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserProvider {
  Future<List<User>> getUsers() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    if (response.statusCode == 200) {
      final List<dynamic>userJson = json.decode(response.body);
      return userJson.map((json)=>User.fromJson(json)).toList();
    } else {
      throw Exception('Error fetching users');
    }
  }
}
