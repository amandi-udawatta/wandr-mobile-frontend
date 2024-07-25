import 'package:flutter/material.dart';
import 'package:wandr/components/primary_button.dart';
import 'package:wandr/components/secondary_button.dart';
import 'package:wandr/components/cust_textfield.dart';
import 'package:wandr/components/google_button.dart';
import 'package:wandr/pages/signup/pref_destinations_page.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:wandr/utils.dart'; // Import the utils file for hashPassword

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final countryController = TextEditingController();

  Future<void> signup(String name, String role, String email, String password, String country, BuildContext context) async {
    final url = Uri.parse('http://10.22.163.155:8081/api/proxy/signup');
    final hashedPassword = hashPassword(password);

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'name': name,
        'role': role,
        'email': email,
        'password': hashedPassword,
        'country': country,
      }),
    );

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      if (responseBody['success']) {
        handleSignupResponse(responseBody, context);
      } else {
        // Display error message
        _showError(context, responseBody['data']['message']);
      }
    } else {
      // Handle error
      print('Signup request failed with status: ${response.statusCode}');
      _showError(context, 'Signup request failed. Please try again.');
    }
  }

  void handleSignupResponse(Map<String, dynamic> responseBody, BuildContext context) {
    if (responseBody['success']) {
      final accessToken = responseBody['data']['accessToken'];
      final refreshToken = responseBody['data']['refreshToken'];
      loginUser(accessToken, refreshToken, context);
    } else {
      print('Signup failed: ${responseBody['message']}');
      _showError(context, responseBody['message']);
    }
  }

  void loginUser(String accessToken, String refreshToken, BuildContext context) {
    // Save tokens to secure storage (not implemented here)
    // Navigate to the home screen or dashboard
    print('User logged in with access token: $accessToken');
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PrefDestinationsPage(),
      ),
    );
  }

  void logUserIn () {}

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
                  'Create Your Account',
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
                padding: EdgeInsets.symmetric(horizontal: 20.0), // Add horizontal padding
                child: Text(
                  'Join us to enhance your travel experience with personalized recommendations and real-time updates.',
                  textAlign: TextAlign.center, // Center the text
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                  ),
                ),
              ),

              SizedBox(height: 50),

              // Name label
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: const Text(
                  'Your Name',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Color(0xFF437B17),
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),

              // Your name field
              CustTextfield(
                controller: nameController,
                obsecureText: false,
                borderRadius: 16.0,
              ),

              SizedBox(height: 25),

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

              // Country label
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: const Text(
                  'Country',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Color(0xFF437B17),
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),

              // Country field
              CustTextfield(
                controller: countryController,
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

              SizedBox(height: 25),

              // Password Confirmation label
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: const Text(
                  'Password Confirmation',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Color(0xFF437B17),
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),

              // Password Confirmation field
              CustTextfield(
                controller: confirmPasswordController,
                obsecureText: true,
                borderRadius: 16.0,
              ),

              SizedBox(height: 95),

              // Register Button
              PrimaryButton(
                onTap: () {
                  final name = nameController.text;
                  final email = emailController.text;
                  final password = passwordController.text;
                  final confirmPassword = confirmPasswordController.text;
                  final role = 'TRAVELLER';
                  final country = countryController.text;

                  if (password == confirmPassword) {
                    signup(name, role, email, password, country, context);
                  } else {
                    _showError(context, 'Passwords do not match');
                  }
                },
                text: "Register",
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
                    )
                  ],
                ),
              ),

              SizedBox(height: 20),

              // Continue with Google
              GoogleButton(
                onTap: logUserIn,
              ),

              SizedBox(height: 20),

              // Don't have an account?
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 100.0),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0), // Add horizontal padding
                      child: Text(
                        'Already have an account?',
                        textAlign: TextAlign.center, // Center the text
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 15,
                        ),
                      ),
                    ),
                    Text(
                      'Login',
                      style: TextStyle(
                        color: Color(0xFF437B17),
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
