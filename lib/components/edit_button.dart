import 'package:flutter/material.dart';

class EditButton extends StatelessWidget {
  final Function()? onTap;
  final IconData? icon;

  const EditButton({
    Key? key,
    this.icon,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40, // Adjust container size as needed
        height: 40, // Adjust container size as needed
        decoration: BoxDecoration(
          color: Color(0xFF437B17),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Center(
          child: Icon(
            Icons.edit,
            color: Colors.white,
            size: 24, // Adjust icon size as needed
          ),
        ),
      ),
    );
  }
}
