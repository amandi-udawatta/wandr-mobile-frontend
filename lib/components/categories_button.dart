import 'package:flutter/material.dart';

class CategoriesButton extends StatelessWidget {
  final String title;
  final String image;
  final VoidCallback onPressed;
  final bool isSelected;

  const CategoriesButton({
    Key? key,
    required this.title,
    required this.image,
    required this.onPressed,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160, // Adjust width according to your design
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12), // Rounded corners
        border: Border.all(
          color: isSelected ? Colors.blue : Colors.grey[300]!, // Highlighted color when selected
          width: 1, // Border width
        ),
      ),
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
              child: Image.asset(
                image,
                width: 80, // Adjust image size as needed
                height: 80, // Adjust image size as needed
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
