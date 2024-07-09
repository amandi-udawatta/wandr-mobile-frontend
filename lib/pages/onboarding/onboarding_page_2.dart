import 'package:flutter/material.dart';

class OnboardingPage2 extends StatelessWidget {
  const OnboardingPage2({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/Onboarding-2.png'),
            fit: BoxFit.cover,
          )
      ),
      child: Center(
          child: Column(
            children: const [
              SizedBox(height: 400),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0),
                child: Text(
                  'Navigate Like a Pro',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 45,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              SizedBox(height: 10),

              //   Description
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0), // Add horizontal padding
                child: Text(
                  'Enjoy the most efficient and enjoyable routes. Navigate with ease and make the most of your travel time with our smart routing.',
                  textAlign: TextAlign.left, // Center the text
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),

            ],
          )
      ),
    );
  }
}
