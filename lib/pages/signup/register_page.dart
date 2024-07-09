import 'package:flutter/material.dart';
import 'package:wandr/components/primary_button.dart';
import 'package:wandr/components/secondary_button.dart';
import 'package:wandr/components/cust_textfield.dart';
import 'package:wandr/components/google_button.dart';
import 'package:wandr/pages/signup/pref_destinations_page.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

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

              //   Description
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0), // Add horizontal padding
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

              //   Name label
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
                controller: emailController,
                obsecureText: false,
                borderRadius: 16.0,
              ),

              SizedBox(height: 25),

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

              SizedBox(height: 25),

              //   Password label
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

              //   Password field
              CustTextfield(
                controller: passwordController,
                obsecureText: true,
                borderRadius: 16.0,
              ),


              SizedBox(height: 95),


              //   Login Button
              PrimaryButton(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context){
                            return PrefDestinationsPage();
                          }
                      )
                  );
                },
                text: "Register",
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

              SizedBox(height: 20),

              // Don't have an account?
              Row(
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
            ],
          ),
        ),
      ),
    );
  }
}
