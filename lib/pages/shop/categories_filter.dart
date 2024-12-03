import 'package:flutter/material.dart';
import 'package:wandr/theme/app_colors.dart';

class CategoryFilterPage extends StatelessWidget {
  final String selectedCategory;

  const CategoryFilterPage({Key? key, required this.selectedCategory})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_outlined),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0), // Add space to the left
              child: Text(
                'Categories',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Kcolours.brownShade4,
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Display selected category
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                selectedCategory, 
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Kcolours.primary, // Adjust color as needed
                ),
              ),
            ),
            // You can add more content based on the selected category here
          ],
        ),
      ),
    );
  }
}
