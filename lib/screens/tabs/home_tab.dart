
// screens/tabs/home_tab.dart
import 'package:flutter/material.dart';
import '../../widgets/curved_header.dart';
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
  String? errorMessage;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    loadRecipes();
  }

  Future<void> loadRecipes() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final data = await ApiService.fetchVegetarianRecipes(number: 8);
      if (data.isEmpty) {
        setState(() {
          errorMessage = "No recipes found. Try again later.";
          isLoading = false;
        });
        return;
      }

      setState(() {
        recipes = data;
        isLoading = false;
      });
      _controller.forward();
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = "Failed to load recipes. Please check your connection.";
      });
    }
  }

  Widget _buildRecipeCard(Map<String, dynamic> recipe, int index) {
    final animation = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(index * 0.1, 1.0, curve: Curves.easeOut),
      ),
    );

    final image = ApiService.getImageUrl(recipe['image'] ?? '');
    final title = recipe['title'] ?? 'Unknown Recipe';
    final calories = recipe['calories']?.toString() ?? 'N/A';
    final time = recipe['readyInMinutes']?.toString() ?? 'N/A';

    return SlideTransition(
      position: animation,
      child: FadeTransition(
        opacity: _controller,
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          clipBehavior: Clip.hardEdge,
          child: InkWell(
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
                Expanded(
                  flex: 3,
                  child: Image.network(
                    image,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      color: Colors.grey[300],
                      child: const Icon(Icons.image_not_supported),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("$calories kcal",
                                style: const TextStyle(fontSize: 12)),
                            Row(
                              children: [
                                const Icon(Icons.timer, size: 14),
                                const SizedBox(width: 2),
                                Text("$time min",
                                    style: const TextStyle(fontSize: 12)),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent() {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(errorMessage!, textAlign: TextAlign.center),
            const SizedBox(height: 8),
            ElevatedButton.icon(
              onPressed: loadRecipes,
              icon: const Icon(Icons.refresh),
              label: const Text("Retry"),
            ),
          ],
        ),
      );
    }
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: recipes.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 3 / 4.2,
      ),
      itemBuilder: (context, index) => _buildRecipeCard(recipes[index], index),
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
          const Text(
            "Recommended Recipes",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          _buildContent(),
        ],
      ),
    );
  }
}
