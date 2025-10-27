// // import 'dart:convert';
// // import 'package:http/http.dart' as http;
// // import 'package:flutter/foundation.dart' show kIsWeb;
// // import 'package:flutter_dotenv/flutter_dotenv.dart';
// //
// // class ApiService {
// //   static final String apiKey = dotenv.env['SPOONACULAR_API_KEY'] ?? '';
// //   static const String baseUrl = 'https://api.spoonacular.com/recipes';
// //
// //   /// Helper: Adds CORS proxy for web only
// //   static String fixImageUrl(String? url) {
// //     if (url == null || url.isEmpty) return '';
// //     if (kIsWeb) {
// //       return 'https://corsproxy.io/?$url'; // Works for web preview
// //     }
// //     return url;
// //   }
// //
// //   static Future<List<Map<String, dynamic>>> fetchVegetarianRecipes({int number = 10}) async {
// //     final url =
// //         '$baseUrl/complexSearch?diet=vegetarian&number=$number&addRecipeInformation=true&apiKey=$apiKey';
// //
// //     try {
// //       final response = await http.get(Uri.parse(url));
// //
// //       if (response.statusCode == 200) {
// //         final data = jsonDecode(response.body);
// //         final List results = data['results'] ?? [];
// //
// //         // Fix image URLs
// //         return results.map((e) {
// //           e['image'] = fixImageUrl(e['image']);
// //           return Map<String, dynamic>.from(e);
// //         }).toList();
// //       } else {
// //         throw Exception('Failed to load recipes: ${response.statusCode}');
// //       }
// //     } catch (e) {
// //       throw Exception('Failed to fetch recipes: $e');
// //     }
// //   }
// //
// //   static Future<Map<String, dynamic>> fetchRecipeDetail(int id) async {
// //     final url = '$baseUrl/$id/information?apiKey=$apiKey';
// //     try {
// //       final response = await http.get(Uri.parse(url));
// //       if (response.statusCode == 200) {
// //         final Map<String, dynamic> data = jsonDecode(response.body);
// //         data['image'] = fixImageUrl(data['image']);
// //         return data;
// //       } else {
// //         throw Exception('Failed to load recipe detail: ${response.statusCode}');
// //       }
// //     } catch (e) {
// //       throw Exception('Failed to fetch recipe detail: $e');
// //     }
// //   }
// // }
// import 'dart:convert';
// import 'package:http/http.dart' as http;
//
// class ApiService {
//   static const String backendUrl = 'http://127.0.0.1:5000';
//
//   /// 🍲 Fetch vegetarian recipes from backend
//   static Future<List<Map<String, dynamic>>> fetchVegetarianRecipes({int number = 10}) async {
//     final url = '$backendUrl/recipes';
//     try {
//       final response = await http.get(Uri.parse(url));
//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         final results = data['results'] ?? [];
//         return List<Map<String, dynamic>>.from(results);
//       } else {
//         throw Exception('Failed to load recipes: ${response.statusCode}');
//       }
//     } catch (e) {
//       throw Exception('Failed to fetch recipes: $e');
//     }
//   }
//
//   /// 📖 Fetch recipe detail from backend
//   static Future<Map<String, dynamic>> fetchRecipeDetail(int id) async {
//     final url = '$backendUrl/recipe/$id';
//     try {
//       final response = await http.get(Uri.parse(url));
//       if (response.statusCode == 200) {
//         return Map<String, dynamic>.from(jsonDecode(response.body));
//       } else {
//         throw Exception('Failed to load recipe detail: ${response.statusCode}');
//       }
//     } catch (e) {
//       throw Exception('Failed to fetch recipe detail: $e');
//     }
//   }
//
//   /// 🌄 Get image via backend proxy (avoids CORS)
//   static String imageUrl(String originalUrl) {
//     return '$backendUrl/image?url=$originalUrl';
//   }
// }


// services/api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://127.0.0.1:5000'; // your Flask backend

  /// 🍲 Fetch vegetarian recipes list from backend
  static Future<List<Map<String, dynamic>>> fetchVegetarianRecipes({int number = 10}) async {
    final url = Uri.parse('$baseUrl/recipes?number=$number&diet=vegetarian');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List results = data['recipes'] ?? [];
        return results.map((e) => Map<String, dynamic>.from(e)).toList();
      } else {
        throw Exception('Failed to load recipes: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch recipes: $e');
    }
  }

  /// 📖 Fetch full recipe details by ID
  static Future<Map<String, dynamic>> fetchRecipeDetail(int id) async {
    final url = Uri.parse('$baseUrl/recipe/$id');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        return Map<String, dynamic>.from(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load recipe detail: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch recipe detail: $e');
    }
  }

  /// 🖼️ Get image via backend proxy
  static String getImageUrl(String imageUrl) {
    return '$baseUrl/image?url=$imageUrl';
  }
}
