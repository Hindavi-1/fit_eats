import 'package:flutter/material.dart';
import '../../widgets/curved_header.dart';
import '../../utils/theme.dart';
import '../../services/api_service.dart';
import '../recipe_details.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> with SingleTickerProviderStateMixin {
  List<Map<String, dynamic>> recipes = [];
  bool isLoading = true;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 300));
    _controller.forward();
    loadRecipes();
  }

  Future<void> loadRecipes() async {
    try {
      final data = await ApiService.fetchVegetarianRecipes(number: 10);
      setState(() {
        recipes = data;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error fetching recipes: $e');
    }
  }

  Widget _buildRecipeCard(Map<String, dynamic> recipe) {
    return SlideTransition(
      position: Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero)
          .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut)),
      child: FadeTransition(
        opacity: _controller,
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => RecipeDetailScreen(recipe: recipe),
                ),
              );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(
                  tag: recipe['id'].toString(),
                  child: ClipRRect(
                    borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(16)),
                    child: Image.network(
                      recipe['image'] ?? '',
                      height: 100,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) =>
                          Container(height: 100, color: Colors.grey[300]),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    recipe['title'] ?? 'Unknown',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CurvedHeader(),
          const SizedBox(height: 16),
          const Text("Recommended Recipes",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: recipes.length,
            gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 3 / 4),
            itemBuilder: (context, index) =>
                _buildRecipeCard(recipes[index]),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
