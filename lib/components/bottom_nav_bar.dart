import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:wandr/pages/shop/main_shops_page.dart';
import 'package:wandr/pages/trips_page.dart';
import 'package:wandr/pages/blogs_page.dart';
import 'package:wandr/pages/home/home_search_screen.dart';
import 'package:wandr/pages/challenges_page.dart';

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
          MaterialPageRoute(builder: (context) => TripsPage()),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BlogsPage()),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SearchScreen()),
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
          MaterialPageRoute(builder: (context) => ChallengesPage()),
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
      selectedItemColor: Color(0xFF009CD5), // Selected item color
      unselectedItemColor: Colors.black, // Unselected items color
      onTap: _onItemTapped,
      type: BottomNavigationBarType.fixed, // Ensure all items are shown
      backgroundColor: Colors.white, // Adjust background color as needed
      elevation: 5, // Add elevation if you want a shadow
    );
  }
}
