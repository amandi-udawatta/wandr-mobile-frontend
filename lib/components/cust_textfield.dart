import 'package:flutter/material.dart';

class CustTextfield extends StatelessWidget {
  final controller;
  // final String hintText;
  final bool obsecureText;
  final double borderRadius;

  const CustTextfield({
    super.key,
    required this.controller,
    // required this.hintText,
    required this.obsecureText,
    this.borderRadius = 8.0,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.0),
      child: TextField(
        controller: controller,
        obscureText: obsecureText,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF437B17)),
              borderRadius: BorderRadius.circular(borderRadius),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF437B17)),
              borderRadius: BorderRadius.circular(borderRadius),
          ),
          // hintText: hintText,
        ),
      ),
    );
  }
}
