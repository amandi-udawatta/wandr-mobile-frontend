import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final Function()? onTap;

  final String text;
  IconData? icon;


  PrimaryButton({super.key,
    required this.text,
    this.icon,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(15),
        margin: EdgeInsets.symmetric(horizontal: 30),
        decoration: BoxDecoration(
          color: Color(0xFF437B17),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: Colors.white,
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
