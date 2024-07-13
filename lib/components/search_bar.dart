import 'package:flutter/material.dart';


class SearchBar extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onChanged;

  const SearchBar({
    Key? key,
    required this.controller,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: BoxDecoration(
          color: Color(0xFFF3F8FE),
          borderRadius: BorderRadius.circular(24),
        ),
        child: TextField(
          controller: controller,
          onChanged: onChanged,
          style: TextStyle(color: Colors.black), // Ensure text color is visible
          decoration: InputDecoration(
            hintText: "Find places to visit",
            hintStyle: TextStyle(color: Colors.grey), // Set hint text color
            border: InputBorder.none,
            prefixIcon: Icon(Icons.search, color: Colors.black), // Set icon color
          ),
        ),
      ),
    );
  }
}
