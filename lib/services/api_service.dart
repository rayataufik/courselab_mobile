import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:courselab_mobile/models/category_model.dart';

class ApiService {
  static const String apiUrl =
      'https://0584-182-253-124-16.ngrok-free.app/api/category';

  static Future<List<CategoryModel>> fetchCategories() async {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      final List<dynamic> categoryJsonList = json.decode(response.body)['data'];
      return categoryJsonList
          .map((json) => CategoryModel.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load categories: HTTP ${response.statusCode}');
    }
  }
}
