import 'package:flutter/material.dart';
import 'package:wandr/config.dart';

import 'package:wandr/components/primary_button.dart';
import 'package:wandr/components/secondary_button.dart';
import 'package:wandr/components/cust_textfield.dart';
import 'package:wandr/components/google_button.dart';
import 'package:wandr/pages/onboarding/onboarding_page.dart';
import 'package:wandr/pages/home/home_dashboard_screen.dart';
import 'package:wandr/theme/app_colors.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:wandr/utils.dart'; // Import the utils file for hashPassword

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> login(String role, String email, String password, BuildContext context) async {
    final url = Uri.parse('$baseUrl/login'); // Replace with your local IP
    final hashedPassword = hashPassword(password);

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'role': role,
        'email': email,
        'password': hashedPassword,
      }),
    );

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      if (responseBody['success']) {
        handleLoginResponse(responseBody, context);
      } else {
        // Display error message
        _showError(context, responseBody['message']);
      }
    } else {
      // Handle error
      print('Login request failed with status: ${response.statusCode}');
      _showError(context, 'Login request failed. Please try again.');
    }
  }

  void handleLoginResponse(
      Map<String, dynamic> responseBody, BuildContext context) {
    if (responseBody['success']) {
      final accessToken = responseBody['data']['accessToken'];
      final refreshToken = responseBody['data']['refreshToken'];
      loginUser(accessToken, refreshToken, context);
    } else {
      print('Login failed: ${responseBody['message']}');
      _showError(context, responseBody['message']);
    }
  }

  void loginUser(
      String accessToken, String refreshToken, BuildContext context) {
    // Save tokens to secure storage (not implemented here)
    // Navigate to the Dashboard page
    print('User logged in with access token: $accessToken');
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DashboardScreen(),
      ),
    );
  }

  void logUserIn() {}

  void _showError(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

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
              // Welcome back
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

              // Description
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 16.0), // Add horizontal padding
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

              // Email Address label
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

              // Email Address field
              CustTextfield(
                controller: emailController,
                obsecureText: false,
                borderRadius: 16.0,
              ),

              SizedBox(height: 25),

              // Password label
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

              // Password field
              CustTextfield(
                controller: passwordController,
                obsecureText: true,
                borderRadius: 16.0,
              ),

              // Remember Me checkbox

              SizedBox(height: 15),

              // Forgot Password?
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

              // Login Button
              PrimaryButton(
                onTap: () {
                  final email = emailController.text;
                  final password = passwordController.text;
                  final role = 'TRAVELLER';

                  login(role, email, password, context);
                },
                text: "Login",
              ),

              SizedBox(height: 15),

              // Create Account Button
              SecondaryButton(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OnboardingPage(),
                    ),
                  );
                },
                text: "Create Account",
              ),

              SizedBox(height: 20),

              // -----OR-----
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
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20),

              // Continue with Google
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
