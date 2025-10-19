import 'package:flutter/material.dart';

class MealPlanScreen extends StatelessWidget {
  const MealPlanScreen({super.key});

  final List<Map<String, String>> meals = const [
    {"day": "Monday", "meal": "Oats + Banana + Milk"},
    {"day": "Tuesday", "meal": "Soybean Curry + Roti"},
    {"day": "Wednesday", "meal": "Besan Chilla + Salad"},
    {"day": "Thursday", "meal": "Paneer Curry + Rice"},
    {"day": "Friday", "meal": "Sprouts Salad + Roti"},
    {"day": "Saturday", "meal": "Protein Smoothie + Muesli"},
    {"day": "Sunday", "meal": "Veg Wrap + Milkshake"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Meal Plan"),
        backgroundColor: const Color(0xFF27AE60),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: meals.length,
        itemBuilder: (context, index) {
          final meal = meals[index];
          return Card(
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 5,
            margin: const EdgeInsets.only(bottom: 16),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              title: Text(
                meal["day"]!,
                style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                meal["meal"]!,
                style: const TextStyle(fontSize: 16, color: Colors.black87),
              ),
              leading: const Icon(Icons.restaurant_menu, color: Color(0xFF27AE60)),
            ),
          );
        },
      ),
    );
  }
}
