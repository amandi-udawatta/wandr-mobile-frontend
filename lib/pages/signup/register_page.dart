import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';
import 'package:wandr/components/primary_button.dart';
import 'package:wandr/components/secondary_button.dart';
import 'package:wandr/components/cust_textfield.dart';
import 'package:wandr/components/google_button.dart';
import 'package:wandr/pages/signup/pref_destinations_page.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:wandr/theme/app_colors.dart';
import 'package:wandr/utils.dart'; // Import the utils file for hashPassword

class RegisterPage extends StatefulWidget {
  RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  String? selectedCountry;
  String? otherCountry;

  final _formKey = GlobalKey<FormState>();

  Future<void> signup(String name, String role, String email, String password, String country, BuildContext context) async {
    final url = Uri.parse('http://192.168.1.10:8081/api/proxy/signup');
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

  void _showCountryPicker(BuildContext context) {
    showCountryPicker(
      context: context,
      showPhoneCode: false, // optional. Shows phone code before the country name.
      onSelect: (Country country) {
        setState(() {
          selectedCountry = country.name;
          otherCountry = null;
        });
      },
      countryListTheme: CountryListThemeData(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
        inputDecoration: InputDecoration(
          labelText: 'Search',
          hintText: 'Start typing to search',
          prefixIcon: Icon(Icons.search),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Kcolours.primary,
            ),
            borderRadius: BorderRadius.circular(20.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Kcolours.primary,
            ),
            borderRadius: BorderRadius.circular(20.0),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Kcolours.primary,
            ),
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Kcolours.whiteAlternative, // BACKGROUND COLOR
      body: SafeArea(
        child: Center(
          child: Form(
            key: _formKey,
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
                      color: Kcolours.primary,
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
                      color: Kcolours.greyShade1,
                      fontSize: 15,
                    ),
                  ),
                ),

                SizedBox(height: 30),

                // Name label
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: const Text(
                    'Your Name',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Kcolours.primary,
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
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
                      color: Kcolours.primary,
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email address';
                    }
                    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                    if (!emailRegex.hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
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
                      color: Kcolours.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),

                // Country dropdown
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () => _showCountryPicker(context),
                        child: InputDecorator(
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Kcolours.primary),
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Kcolours.primary),
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            hintText: selectedCountry ?? 'Select your country',
                          ),
                          child: Text(selectedCountry ?? 'Select your country'),
                        ),
                      ),
                    ],
                  ),
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
                      color: Kcolours.primary,
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
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
                      color: Kcolours.primary,
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your password';
                    }
                    if (value != passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),

                SizedBox(height: 45),

                // Register Button
                PrimaryButton(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      final name = nameController.text;
                      final email = emailController.text;
                      final password = passwordController.text;
                      final confirmPassword = confirmPasswordController.text;
                      final role = 'TRAVELLER';
                      final country = selectedCountry == 'Other' ? otherCountry! : selectedCountry!;

                      if (password == confirmPassword) {
                        signup(name, role, email, password, country, context);
                      } else {
                        _showError(context, 'Passwords do not match');
                      }
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
                            color: Kcolours.primary,
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
                            color: Kcolours.greyShade1,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      Text(
                        'Login',
                        style: TextStyle(
                          color: Kcolours.primary,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 20)
              ],
            ),
          ),
        ),
      ),
    );
  }
}