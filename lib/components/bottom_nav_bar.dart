import 'package:flutter/material.dart';
import 'package:wandr/pages/shop/main_shops_page.dart';
import 'package:wandr/pages/home/home_dashboard_screen.dart';
import 'package:wandr/pages/trip/trip_main.dart';
import 'package:wandr/pages/blogs/blogs_main.dart';
import 'package:wandr/pages/rewards/rewards_page.dart';
import 'package:wandr/theme/app_colors.dart';

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _currentIndex = 2; // Start with Dashboard selected

  // List of pages to switch between
  final List<Widget> _pages = [
    TripScreen(),     // Trip Page
    BlogScreen(),         // Blogs Page
    DashboardScreen(),     // Dashboard Page
    MainShopsPage(),    // Shops and Services Page
    RewardsPage(),     // Challenges Page
  ];

  // Method to handle tab switching
  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],  // Display the currently selected page
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex, // Keep track of selected tab
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black,
        onTap: _onTabTapped,  // Switch tabs when tapped
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_car_outlined, size: 30),
            label: 'My Trips',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.edit_outlined, size: 30),
            label: 'Blogs',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined, size: 30),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined, size: 30),
            label: 'Shop',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.emoji_events_outlined, size: 30),
            label: 'Rewards',
          ),
        ],
      ),
    );
  }
}
