import 'package:flutter/material.dart';

class AddButton extends StatelessWidget {
  final Function()? onTap;
  final IconData? icon;

  const AddButton({
    Key? key,
    this.icon,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 60, // Adjust width as needed
        height: 60, // Adjust height as needed
        decoration: BoxDecoration(
          color: Color(0xFF437B17),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: Icon(
            Icons.add,
            color: Colors.white,
            size: 32, // Adjust icon size as needed
          ),
        ),
      ),
    );
  }
}
