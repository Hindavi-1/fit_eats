import 'package:flutter/material.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  final List<Map<String, String>> favorites = const [
    {
      "name": "Paneer Salad",
      "image":
      "https://images.unsplash.com/photo-1606755962770-42d254fbe1b3?fit=crop&w=800&q=80"
    },
    {
      "name": "Protein Smoothie",
      "image":
      "https://images.unsplash.com/photo-1584270354949-9d6a14a4c4d3?fit=crop&w=800&q=80"
    },
    {
      "name": "Veg Wrap",
      "image":
      "https://images.unsplash.com/photo-1617196032524-6261b87a0b57?fit=crop&w=800&q=80"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorites"),
        backgroundColor: const Color(0xFF27AE60),
      ),
      body: favorites.isEmpty
          ? const Center(
        child: Text(
          "No favorites yet!",
          style: TextStyle(fontSize: 18, color: Colors.black54),
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: favorites.length,
        itemBuilder: (context, index) {
          final item = favorites[index];
          return Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16)),
            elevation: 4,
            margin: const EdgeInsets.only(bottom: 16),
            child: ListTile(
              contentPadding: const EdgeInsets.all(12),
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  item["image"]!,
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ),
              title: Text(
                item["name"]!,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 16),
              ),
              trailing: IconButton(
                icon: const Icon(Icons.delete_outline, color: Colors.red),
                onPressed: () {
                  // TODO: Implement remove favorite logic
                },
              ),
              onTap: () {
                // TODO: Navigate to RecipeDetailScreen
              },
            ),
          );
        },
      ),
    );
  }
}
