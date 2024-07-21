import 'package:flutter/material.dart';
import 'package:wandr/theme/app_colors.dart'; // Ensure this has your grey color definitions

class HomeProfile extends StatelessWidget {
  final String image;
  final String text;

  const HomeProfile({
    Key? key,
    required this.image,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 50, // Adjust size as needed
          height: 50, // Adjust size as needed
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage(image),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(width: 12), // Space between image and text
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 17,
              color: Kcolours.greyShade1, // Ensure Kcolours has the correct grey color
            ),
          ),
        ),
        Icon(
          Icons.notifications,
          color: Kcolours.greyShade1, // Ensure Kcolours has the correct grey color
          size: 24, // Adjust size as needed
        ),
      ],
    );
  }
}
