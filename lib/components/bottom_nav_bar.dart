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
  int _selectedIndex = 2;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => TripScreen()),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BlogScreen()),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DashboardScreen()),
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MainShopsPage()),
        );
        break;
      case 4:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RewardsPage()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
          icon: Padding(
            padding: EdgeInsets.only(bottom: 8.0),
            child: Icon(Icons.directions_car_outlined, size: 30),
          ),
          label: 'My Trips',
        ),
        BottomNavigationBarItem(
          icon: Padding(
            padding: EdgeInsets.only(bottom: 8.0),
            child: Icon(Icons.edit_outlined, size: 30),
          ),
          label: 'Blogs',
        ),
        BottomNavigationBarItem(
          icon: Padding(
            padding: EdgeInsets.only(bottom: 8.0),
            child: Icon(Icons.home_outlined, size: 30),
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Padding(
            padding: EdgeInsets.only(bottom: 8.0),
            child: Icon(Icons.shopping_cart_outlined, size: 30),
          ),
          label: 'Shop',
        ),
        BottomNavigationBarItem(
          icon: Padding(
            padding: EdgeInsets.only(bottom: 8.0),
            child: Icon(Icons.emoji_events_outlined, size: 30),
          ),
          label: 'Rewards',
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Kcolours.blueShade2,
      unselectedItemColor: Colors.black,
      onTap: _onItemTapped,
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      elevation: 5,
    );
  }
}
