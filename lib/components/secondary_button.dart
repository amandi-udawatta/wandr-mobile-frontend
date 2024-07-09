import 'package:flutter/material.dart';
import 'package:wandr/pages/signup/register_page.dart';

class SecondaryButton extends StatelessWidget {
  final Function()? onTap;

  final String text;

  const SecondaryButton({
    super.key,
    required this.text,
    required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(15),
        margin: EdgeInsets.symmetric(horizontal: 30),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Color(0xFF437B17), // Set the border color to black
            width: 1.5, // Set the border width (you can adjust this)
          ),
        ),
        child: Center(
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: Color(0xFF437B17),
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
