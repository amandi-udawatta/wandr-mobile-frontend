import 'package:flutter/material.dart';
import 'package:wandr/components/primary_button.dart';
import 'package:wandr/pages/signup/pref_activities_page.dart';

class PrefDestinationsPage extends StatelessWidget {
  const PrefDestinationsPage({super.key});

  // log user in
  void logUserIn() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100], // BACKGROUND COLOR
      body: SafeArea(
        child: Center(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 50),
              //   Welcome back
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Text(
                  'Pick Your Favorite Destinations',
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
                  'Tell us about your preferred places to visit. This will help us tailor your travel recommendations to match your interests.',
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
              //     Container(
              //       height: 30,
              //       width: 30,
              //       color: Colors.green,
              //     )
              //   ],
              // ),

              SizedBox(height: 15),

              SizedBox(height: 150),

              //   Login Button
              PrimaryButton(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context){
                            return PrefActivitiesPage();
                          }
                      )
                  );
                },
                text: "Proceed",
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