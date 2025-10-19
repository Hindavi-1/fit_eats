import 'package:flutter/material.dart';
import '../utils/theme.dart';

class RecipeDetailsScreen extends StatelessWidget {
  final String recipeName;

  const RecipeDetailsScreen({super.key, required this.recipeName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recipeName),
        centerTitle: true,
        backgroundColor: AppColors.primaryGreen,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Recipe Image Banner
            Container(
              height: 220,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    'https://images.unsplash.com/photo-1504674900247-0877df9cc836',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                color: Colors.black.withOpacity(0.3),
                alignment: Alignment.bottomLeft,
                padding: const EdgeInsets.all(16),
                child: Text(
                  recipeName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            // Nutrition Info
            Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.primaryGreen, AppColors.tealAccent],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                padding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    _NutritionItem(label: "Calories", value: "250 kcal"),
                    _NutritionItem(label: "Protein", value: "12 g"),
                    _NutritionItem(label: "Carbs", value: "30 g"),
                    _NutritionItem(label: "Fat", value: "8 g"),
                  ],
                ),
              ),
            ),

            // Ingredients
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Ingredients",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.darkText,
                ),
              ),
            ),
            const SizedBox(height: 8),
            _buildIngredientsList(),

            const SizedBox(height: 16),

            // Preparation Steps
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Preparation",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.darkText,
                ),
              ),
            ),
            const SizedBox(height: 8),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "1. Wash and chop all vegetables.\n"
                    "2. Mix them in a bowl with olive oil and spices.\n"
                    "3. Grill the chicken and add it on top.\n"
                    "4. Serve fresh with a drizzle of lemon juice.",
                style: TextStyle(fontSize: 16, color: AppColors.darkText),
              ),
            ),

            const SizedBox(height: 24),

            // Add to Favorites Button
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Added to Favorites! ❤️"),
                    ),
                  );
                },
                icon: const Icon(Icons.favorite_border),
                label: const Text(
                  "Add to Favorites",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.tealAccent,
                  padding:
                  const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildIngredientsList() {
    final ingredients = [
      "1 cup chopped spinach",
      "½ avocado",
      "100g grilled chicken",
      "1 tbsp olive oil",
      "Salt and pepper to taste",
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: ingredients
            .map(
              (item) => ListTile(
            leading: const Icon(Icons.check_circle_outline,
                color: AppColors.primaryGreen),
            title: Text(item,
                style: const TextStyle(color: AppColors.darkText)),
            contentPadding: EdgeInsets.zero,
          ),
        )
            .toList(),
      ),
    );
  }
}

class _NutritionItem extends StatelessWidget {
  final String label;
  final String value;

  const _NutritionItem({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(color: Colors.white70, fontSize: 13),
        ),
      ],
    );
  }
}
