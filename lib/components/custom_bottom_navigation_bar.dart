import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const CustomBottomNavigationBar({
    required this.selectedIndex,
    required this.onItemTapped,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      fixedColor: Color(0xFF176FF2),
      currentIndex: selectedIndex,
      unselectedItemColor: Colors.black38,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.car_rental), label: ""),
        BottomNavigationBarItem(icon: Icon(Icons.book), label: ""),
        BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: ""),
        BottomNavigationBarItem(icon: Icon(Icons.shop), label: ""),
        BottomNavigationBarItem(icon: Icon(Icons.wallet_giftcard_rounded), label: ""),
      ],
      onTap: onItemTapped,
    );
  }
}
