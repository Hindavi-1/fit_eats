// import 'package:flutter/material.dart';
//
// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           "One Fit Diet",
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//         backgroundColor: const Color(0xFF27AE60),
//         centerTitle: true,
//       ),
//       body: Container(
//         width: double.infinity,
//         height: double.infinity,
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Color(0xFF27AE60), Color(0xFF1ABC9C)],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//         ),
//         child: SafeArea(
//           child: SingleChildScrollView(
//             padding: const EdgeInsets.all(20.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Text(
//                   "Welcome Back!",
//                   style: TextStyle(
//                     fontSize: 28,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//                 const Text(
//                   "Track your meals, calories, and progress easily.",
//                   style: TextStyle(
//                     fontSize: 16,
//                     color: Colors.white70,
//                   ),
//                 ),
//                 const SizedBox(height: 24),
//
//                 // Quick Action Cards
//                 GridView.count(
//                   crossAxisCount: 2,
//                   shrinkWrap: true,
//                   mainAxisSpacing: 16,
//                   crossAxisSpacing: 16,
//                   physics: const NeverScrollableScrollPhysics(),
//                   children: [
//                     _buildFeatureCard(
//                       icon: Icons.restaurant_menu,
//                       title: "Diet Plan",
//                       onTap: () {
//                         // TODO: Navigate to Diet Plan screen
//                       },
//                     ),
//                     _buildFeatureCard(
//                       icon: Icons.local_fire_department,
//                       title: "Track Calories",
//                       onTap: () {
//                         // TODO: Navigate to Calorie Tracker screen
//                       },
//                     ),
//                     _buildFeatureCard(
//                       icon: Icons.favorite,
//                       title: "Favorites",
//                       onTap: () {
//                         // TODO: Navigate to Favorites screen
//                       },
//                     ),
//                     _buildFeatureCard(
//                       icon: Icons.settings,
//                       title: "Settings",
//                       onTap: () {
//                         // TODO: Navigate to Settings screen
//                       },
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 30),
//
//                 // Example motivational card
//                 Container(
//                   padding: const EdgeInsets.all(20),
//                   decoration: BoxDecoration(
//                     color: Colors.white.withOpacity(0.2),
//                     borderRadius: BorderRadius.circular(16),
//                   ),
//                   child: Row(
//                     children: const [
//                       Icon(
//                         Icons.health_and_safety,
//                         size: 40,
//                         color: Colors.white,
//                       ),
//                       SizedBox(width: 16),
//                       Expanded(
//                         child: Text(
//                           "Remember: Consistency is key! Stick to your diet and track daily.",
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 16,
//                           ),
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   // Reusable feature card widget
//   Widget _buildFeatureCard(
//       {required IconData icon, required String title, required VoidCallback onTap}) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         decoration: BoxDecoration(
//           gradient: const LinearGradient(
//             colors: [Color(0xFF27AE60), Color(0xFF1ABC9C)],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//           borderRadius: BorderRadius.circular(16),
//           boxShadow: const [
//             BoxShadow(
//               color: Colors.black26,
//               blurRadius: 4,
//               offset: Offset(2, 4),
//             ),
//           ],
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(icon, size: 48, color: Colors.white),
//             const SizedBox(height: 12),
//             Text(
//               title,
//               style: const TextStyle(
//                 color: Colors.white,
//                 fontSize: 16,
//                 fontWeight: FontWeight.bold,
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import '../utils/theme.dart';
import 'favorites_screen.dart';
import 'meal_plan_screen.dart';
import 'recipe_details.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screens = [
      const DashboardView(),
      const FavoritesScreen(),
      const MealPlanScreen(),
    ];

    final titles = ["Home", "Favorites", "Meal Plan"];

    return Scaffold(
      appBar: AppBar(
        title: Text(titles[_selectedIndex]),
        centerTitle: true,
        backgroundColor: AppColors.primaryGreen,
        elevation: 2,
      ),
      body: screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: Colors.white,
        selectedItemColor: AppColors.primaryGreen,
        unselectedItemColor: AppColors.lightGray,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            activeIcon: Icon(Icons.favorite),
            label: "Favorites",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: "Meal Plan",
          ),
        ],
      ),
    );
  }
}

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Welcome to FitEats 🍃",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryGreen,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            "Your personalized diet & fitness companion.",
            style: TextStyle(fontSize: 16, color: AppColors.darkText),
          ),
          const SizedBox(height: 24),

          // Daily summary card
          Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppColors.primaryGreen, AppColors.tealAccent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Today's Summary",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "1200 kcal consumed",
                      style: TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
                Icon(Icons.fitness_center, color: Colors.white, size: 40),
              ],
            ),
          ),

          const SizedBox(height: 24),
          const Text(
            "Featured Recipes 🍲",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: AppColors.darkText,
            ),
          ),
          const SizedBox(height: 12),

          // Recipe cards
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            children: [
              _buildRecipeCard(
                context,
                "Avocado Salad",
                "250 kcal",
                "https://images.unsplash.com/photo-1551218808-94e220e084d2",
              ),
              _buildRecipeCard(
                context,
                "Oat Smoothie",
                "180 kcal",
                "https://images.unsplash.com/photo-1504674900247-0877df9cc836",
              ),
              _buildRecipeCard(
                context,
                "Grilled Chicken",
                "320 kcal",
                "https://images.unsplash.com/photo-1604908177522-040618e0d36a",
              ),
              _buildRecipeCard(
                context,
                "Fruit Bowl",
                "210 kcal",
                "https://images.unsplash.com/photo-1570197788417-0e82375c9371",
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRecipeCard(
      BuildContext context, String title, String calories, String imageUrl) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RecipeDetailsScreen(recipeName: title),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
            image: NetworkImage(imageUrl),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.25),
              BlendMode.darken,
            ),
          ),
        ),
        alignment: Alignment.bottomLeft,
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              calories,
              style: const TextStyle(color: Colors.white70, fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }
}
