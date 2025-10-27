import 'package:flutter/material.dart';
import 'tabs/home_tab.dart';
import '../../utils/theme.dart';
import 'tabs/profile_tab.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;

  final List<Widget> _tabs = [
    const HomeTab(),
    Center(child: Text('Favorites Tab', style: TextStyle(fontSize: 24))),
    Center(child: Text('Meal Plan Tab', style: TextStyle(fontSize: 24))),
    Center(child: Text('Profile Tab', style: TextStyle(fontSize: 24))),
    
  ];

  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _slideAnimation = Tween<Offset>(begin: const Offset(0, 0.1), end: Offset.zero)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _controller.reset();
      _controller.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SlideTransition(
        position: _slideAnimation,
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: _tabs[_selectedIndex],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home), tooltip: "Home", label: ""),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), tooltip: "Favorites", label: ""),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today), tooltip: "Meal Plan", label: ""),
          BottomNavigationBarItem(
              icon: Icon(Icons.person), tooltip: "Profile", label: ""),
        ],
      ),
    );
  }
}
