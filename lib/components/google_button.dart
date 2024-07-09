import 'package:flutter/material.dart';

class GoogleButton extends StatelessWidget {
  final Function()? onTap;

  const GoogleButton({super.key, required this.onTap});

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
            color: Colors.black12, // Set the border color to black
            width: 1.5, // Set the border width (you can adjust this)
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/brands/google.png',
              height: 24, // Adjust the height to fit your needs
            ),
            SizedBox(width: 10), // Add some space between the image and text
            Text(
              'Continue with Google',
              style: TextStyle(
                color: Colors.black,
                fontSize: 17,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
