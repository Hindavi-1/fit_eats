import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiService {
  static final String apiKey = dotenv.env['SPOONACULAR_API_KEY'] ?? '';
  static const String baseUrl = 'https://api.spoonacular.com/recipes';

  static Future<List<Map<String, dynamic>>> fetchVegetarianRecipes({int number = 10}) async {
    final url = '$baseUrl/complexSearch?diet=vegetarian&number=$number&addRecipeInformation=true&apiKey=$apiKey';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List results = data['results'] ?? [];
        return results.map((e) => Map<String, dynamic>.from(e)).toList();
      } else {
        throw Exception('Failed to load recipes: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch recipes: $e');
    }
  }

  static Future<Map<String, dynamic>> fetchRecipeDetail(int id) async {
    final url = '$baseUrl/$id/information?apiKey=$apiKey';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        return Map<String, dynamic>.from(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load recipe detail: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch recipe detail: $e');
    }
  }
}
