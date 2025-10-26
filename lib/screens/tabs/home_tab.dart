// import 'package:flutter/material.dart';
// import 'package:shimmer/shimmer.dart';
// import '../../widgets/curved_header.dart';
// import '../../services/api_service.dart';
// import '../recipe_details.dart';
//
// class HomeTab extends StatefulWidget {
//   const HomeTab({super.key});
//
//   @override
//   State<HomeTab> createState() => _HomeTabState();
// }
//
// class _HomeTabState extends State<HomeTab> with SingleTickerProviderStateMixin {
//   List<Map<String, dynamic>> recipes = [];
//   bool isLoading = true;
//   late AnimationController _controller;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller =
//         AnimationController(vsync: this, duration: const Duration(milliseconds: 300));
//     _controller.forward();
//     loadRecipes();
//   }
//
//   Future<void> loadRecipes({bool showLoader = true}) async {
//     if (showLoader) setState(() => isLoading = true);
//
//     try {
//       final data = await ApiService.fetchVegetarianRecipes(number: 10);
//       setState(() {
//         recipes = data;
//         isLoading = false;
//       });
//     } catch (e) {
//       setState(() {
//         isLoading = false;
//       });
//       debugPrint('Error fetching recipes: $e');
//     }
//   }
//
//   Widget _buildRecipeCard(Map<String, dynamic> recipe) {
//     return SlideTransition(
//       position: Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero)
//           .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut)),
//       child: FadeTransition(
//         opacity: _controller,
//         child: Card(
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//           elevation: 4,
//           shadowColor: Colors.black26,
//           child: InkWell(
//             borderRadius: BorderRadius.circular(16),
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (_) => RecipeDetailScreen(recipe: recipe),
//                 ),
//               );
//             },
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Hero(
//                   tag: recipe['id'].toString(),
//                   child: ClipRRect(
//                     borderRadius:
//                     const BorderRadius.vertical(top: Radius.circular(16)),
//                     child: Image.network(
//                       recipe['image'] ?? '',
//                       height: 120,
//                       width: double.infinity,
//                       fit: BoxFit.cover,
//                       loadingBuilder: (context, child, progress) {
//                         if (progress == null) return child;
//                         return Shimmer.fromColors(
//                           baseColor: Colors.grey.shade300,
//                           highlightColor: Colors.grey.shade100,
//                           child: Container(
//                             height: 120,
//                             width: double.infinity,
//                             color: Colors.grey[300],
//                           ),
//                         );
//                       },
//                       errorBuilder: (_, __, ___) => Container(
//                         height: 120,
//                         color: Colors.grey[300],
//                         child: const Icon(Icons.broken_image,
//                             size: 40, color: Colors.grey),
//                       ),
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Text(
//                     recipe['title'] ?? 'Unknown',
//                     maxLines: 2,
//                     overflow: TextOverflow.ellipsis,
//                     style: Theme.of(context).textTheme.titleMedium?.copyWith(
//                       fontWeight: FontWeight.w600,
//                     ),
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
//   @override
//   Widget build(BuildContext context) {
//     return RefreshIndicator(
//       color: const Color(0xFF27AE60),
//       backgroundColor: Colors.white,
//       strokeWidth: 3,
//       onRefresh: () async {
//         await loadRecipes(showLoader: false);
//       },
//       child: SingleChildScrollView(
//         physics: const AlwaysScrollableScrollPhysics(), // enables swipe-down refresh
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const CurvedHeader(),
//             const SizedBox(height: 16),
//             const Text(
//               "Recommended Recipes",
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 12),
//             isLoading
//                 ? const Center(child: CircularProgressIndicator())
//                 : GridView.builder(
//               shrinkWrap: true,
//               physics: const NeverScrollableScrollPhysics(),
//               itemCount: recipes.length,
//               gridDelegate:
//               const SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2,
//                   crossAxisSpacing: 12,
//                   mainAxisSpacing: 12,
//                   childAspectRatio: 3 / 4),
//               itemBuilder: (context, index) =>
//                   _buildRecipeCard(recipes[index]),
//             ),
//             const SizedBox(height: 24),
//           ],
//         ),
//       ),
//     );
//   }
// }
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
      final data = await ApiService.fetchVegetarianRecipes();
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

    final imageUrl = ApiService.imageUrl(recipe['image'] ?? '');

    return SlideTransition(
      position: animation,
      child: FadeTransition(
        opacity: _controller,
        child: Card(
          elevation: 4,
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
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                    child: Image.network(
                      imageUrl,
                      height: 120,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) =>
                          Image.asset('assets/placeholder.png', height: 120, fit: BoxFit.cover),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    recipe['title'] ?? 'Unknown Recipe',
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
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
    if (isLoading) return const Center(child: CircularProgressIndicator());
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
        childAspectRatio: 3 / 4,
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

