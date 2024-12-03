import 'package:flutter/material.dart';
import 'package:wandr/theme/app_colors.dart';
import 'package:wandr/pages/shop/categories_filter.dart'; // Import the CategoryFilterPage
import 'categories_button.dart';

class ServiceSlider extends StatefulWidget {
  final List<String> categoryNames;

  const ServiceSlider({
    Key? key,
    required this.categoryNames,
  }) : super(key: key);

  @override
  _ServiceSliderState createState() => _ServiceSliderState();
}

class _ServiceSliderState extends State<ServiceSlider> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: widget.categoryNames.length,
        itemBuilder: (context, index) {
          final isSelected = _selectedIndex == index;
          return CategoriesButton(
            title: widget.categoryNames[index],
            onPressed: () {
              setState(() {
                _selectedIndex = index;
              });
              // Navigate to the CategoryFilterPage and pass the selected category
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CategoryFilterPage(
                    selectedCategory: widget.categoryNames[index], // Pass selected category
                  ),
                ),
              );
            },
            isSelected: isSelected,
            image: null, // No image needed
          );
        },
        separatorBuilder: (context, index) => const SizedBox(width: 8),
      ),
    );
  }
}
