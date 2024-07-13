import 'package:flutter/material.dart';
import 'package:wandr/components/primary_button.dart';
import 'package:wandr/pages/home/home_search_screen.dart';

import '../../components/bottom_nav_bar.dart';

class PrefActivitiesPage extends StatelessWidget {
  const PrefActivitiesPage({super.key});

  // log user in
  void logUserIn() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100], // BACKGROUND COLOR
      body: SafeArea(
        child: Center(
          child: ListView(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 50),
              //   Welcome back
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Text(
                  'Pick Your Favorite Activities in Sri Lanka',
                  style: TextStyle(
                    color: Color(0xFF437B17),
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins-Bold',
                  ),
                ),
              ),

              //   Description
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0), // Add horizontal padding
                child: Text(
                  'Let us know what activities you love to do during your travels. This will help us tailor your recommendations to match your interests.',
                  textAlign: TextAlign.left, // Center the text
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                  ),
                ),
              ),

              SizedBox(height: 50),

              //   Text
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: const Text(
                  'Select all that apply',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 20,
                  ),
                ),
              ),


              SizedBox(height: 25),

              // grid selection
              // GridView.count(
              //   crossAxisCount: 3,
              //   children: [
              //     Padding(
              //       padding: const EdgeInsets.all(8.0),
              //       child: Container(
              //         height: 10,
              //         width: 10,
              //         color: Colors.green,
              //       ),
              //     )
              //   ],
              // ),

              //   Login Button
              PrimaryButton(
                text: "Proceed",
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context){
                            return SearchScreen();
                          }
                      )
                  );
                },
              ),

              SizedBox(height: 20),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0), // Add horizontal padding
                child: Text(
                  '(Your preferences can be updated anytime in your profile settings)',
                  textAlign: TextAlign.left, // Center the text
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}