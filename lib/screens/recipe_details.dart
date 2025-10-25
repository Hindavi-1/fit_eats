import 'package:flutter/material.dart';
import '../utils/theme.dart';

class RecipeDetailScreen extends StatelessWidget {
  final Map<String, dynamic> recipe;

  const RecipeDetailScreen({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    final title = recipe['title'] ?? 'Unknown Recipe';
    final image = recipe['image'] ?? '';
    final calories =
        recipe['nutrition']?['nutrients']?.firstWhere(
                (n) => n['name'] == 'Calories',
            orElse: () => {'amount': 'N/A'})['amount'] ?? 'N/A';
    final instructions = recipe['instructions'] ?? 'No instructions available.';

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: recipe['id'].toString(),
              child: ClipRRect(
                borderRadius:
                const BorderRadius.vertical(bottom: Radius.circular(24)),
                child: Image.network(
                  image,
                  width: double.infinity,
                  height: 250,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) =>
                      Container(height: 250, color: Colors.grey[300]),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(title, style: Theme.of(context).textTheme.headlineMedium),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text("Calories: $calories kcal",
                  style: Theme.of(context).textTheme.bodyMedium),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text("Instructions",
                  style: Theme.of(context).textTheme.bodyLarge),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(instructions, style: const TextStyle(fontSize: 14)),
            ),
          ],
        ),
      ),
    );
  }
}
