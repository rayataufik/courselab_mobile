import 'package:courselab_mobile/services/local_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:courselab_mobile/models/category_model.dart';
import 'package:courselab_mobile/models/detail_category_model.dart';

const String baseUrl = 'https://a37a-182-253-124-24.ngrok-free.app';

class ApiService {
  static const String baseUrl =
      'https://a37a-182-253-124-24.ngrok-free.app/api';

  static Future<List<CategoryModel>> fetchCategories() async {
    final response = await http.get(Uri.parse('$baseUrl/category'));
    if (response.statusCode == 200) {
      final List<dynamic> categoryJsonList = json.decode(response.body)['data'];
      return categoryJsonList
          .map((json) => CategoryModel.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load categories: HTTP ${response.statusCode}');
    }
  }

  static Future<DetailCategoryModel> fetchCategoryDetails(
      int categoryId) async {
    final response = await http.get(Uri.parse('$baseUrl/category/$categoryId'));
    if (response.statusCode == 200) {
      return DetailCategoryModel.fromJson(json.decode(response.body)['data']);
    } else {
      throw Exception(
          'Failed to load category details: HTTP ${response.statusCode}');
    }
  }

  static Future<dynamic> fetchCourseDetails(int courseId) async {
    String url = '$baseUrl/course/$courseId';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        return json.decode(response.body)['data'];
      } else {
        throw Exception('Failed to load course details');
      }
    } catch (e) {
      throw Exception('Failed to fetch data: ${e.toString()}');
    }
  }

  static Future<dynamic> login(String email, String password) async {
    String url = '$baseUrl/login';
    try {
      final response = await http.post(Uri.parse(url), body: {
        'email': email,
        'password': password,
      });
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to login');
      }
    } catch (e) {
      throw Exception('Failed to login: ${e.toString()}');
    }
  }

  static Future<dynamic> logout() async {
    String url = '$baseUrl/logout';
    try {
      final response =
          await http.post(Uri.parse(url), headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${LocalStorage().box.read("token")}'
      });

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to logout');
      }
    } catch (e) {
      throw Exception('Failed to logout: ${e.toString()}');
    }
  }

  static Future<dynamic> register(
      String name, String email, String password) async {
    String url = '$baseUrl/register';
    try {
      final response = await http.post(Uri.parse(url),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            'name': name,
            'email': email,
            'password': password,
          }));
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to register');
      }
    } catch (e) {
      throw Exception('Failed to register: ${e.toString()}');
    }
  }
}
