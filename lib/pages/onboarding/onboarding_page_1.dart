import 'package:flutter/material.dart';

class OnboardingPage1 extends StatelessWidget {
  const OnboardingPage1({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/Onboarding-1.png'),
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
                  'Travel Tailored Just for You',
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
                  'Get tailored travel suggestions based on your preferences. Discover destinations and activities that you\'ll love.',
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
