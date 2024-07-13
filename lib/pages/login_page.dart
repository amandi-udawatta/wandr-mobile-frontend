import 'package:flutter/material.dart';
import 'package:wandr/components/bottom_nav_bar.dart';
import 'package:wandr/components/primary_button.dart';
import 'package:wandr/components/secondary_button.dart';
import 'package:wandr/components/cust_textfield.dart';
import 'package:wandr/components/google_button.dart';
import 'package:wandr/pages/dashboard_page.dart';
import 'package:wandr/pages/onboarding/onboarding_page.dart';
import 'package:wandr/pages/signup/register_page.dart';
import 'package:wandr/theme/app_colors.dart';

// import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

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
                  'Welcome Back!',
                  textAlign: TextAlign.center, // Center the text
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
                padding: EdgeInsets.symmetric(horizontal: 16.0), // Add horizontal padding
                child: Text(
                  'Log in to access your personalized travel itineraries and enjoy seamless journey planning.',
                  textAlign: TextAlign.center, // Center the text
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                  ),
                ),
              ),

              SizedBox(height: 50),

              //   Email Address label
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: const Text(
                  'Email Address',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Color(0xFF437B17),
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),

              //   Email Address field
              CustTextfield(
                controller: emailController,
                obsecureText: false,
                borderRadius: 16.0,
              ),

              SizedBox(height: 25),

              //   Password label
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: const Text(
                  'Password',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Color(0xFF437B17),
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),

              //   Password field
              CustTextfield(
                controller: passwordController,
                obsecureText: true,
                borderRadius: 16.0,
              ),

              //   Remember Me checkbox

              SizedBox(height: 15),

              //   Forgot Password?
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: const Text(
                  'Forgot Password?',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Kcolours.primary,
                    fontSize: 15,
                  ),
                ),
              ),

              SizedBox(height: 150),

              //   Login Button
              PrimaryButton(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context){
                            return DashboardPage();
                          }
                      )
                  );
                },
                text: "Login",
              ),

              SizedBox(height: 15),

              //   Create Account Button
              SecondaryButton(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context){
                            return OnboardingPage();
                          }
                      )
                  );
                },
                text: "Create Account",
              ),

              SizedBox(height: 20),

              //   -----OR-----
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[500],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        'OR',
                        style: TextStyle(
                          color: Color(0xFF437B17),
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),

                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[500],
                      ),
                    )

                  ],
                ),
              ),

              SizedBox(height: 20),

              //   Continue with Google
              GoogleButton(
                onTap: logUserIn,
              ),
            ],
          ),
        ),
      ),
    );
  }
}