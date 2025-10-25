import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../utils/theme.dart';

class CurvedHeader extends StatefulWidget {
  const CurvedHeader({super.key});

  @override
  State<CurvedHeader> createState() => _CurvedHeaderState();
}

class _CurvedHeaderState extends State<CurvedHeader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  String username = "User";

  @override
  void initState() {
    super.initState();

    // Firebase username
    final user = FirebaseAuth.instance.currentUser;
    username = user?.displayName ??
        user?.email?.split('@')[0] ??
        'User';

    // Animation setup
    _controller =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 300));
    _slideAnimation = Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return ClipPath(
      clipper: WaveClipper(),
      child: Container(
        height: screenHeight * 0.25,
        decoration: const BoxDecoration(
          gradient: AppGradients.greenMint,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SlideTransition(
                  position: _slideAnimation,
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Good Morning, $username!',
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(color: Colors.white),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Here’s your healthy plan for today 🌞',
                          style: TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const CircleAvatar(
                radius: 24,
                backgroundColor: Colors.white24,
                child: Icon(Icons.person, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Custom wave clipper
class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 40);
    var firstControlPoint = Offset(size.width / 4, size.height);
    var firstEndPoint = Offset(size.width / 2, size.height - 40);
    var secondControlPoint = Offset(3 * size.width / 4, size.height - 80);
    var secondEndPoint = Offset(size.width, size.height - 40);

    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
