import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:wandr/config.dart';
import 'chat_convo.dart'; // Import ChatConvoPage for navigation

class ChatListPage extends StatefulWidget {
  const ChatListPage({Key? key}) : super(key: key);

  @override
  _ChatListPageState createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  List<dynamic> businesses = []; // Store the list of businesses
  bool isLoading = true; // For loading indicator
  final storage = FlutterSecureStorage(); // Secure storage to retrieve the token
  String travellerId = ""; // To store travellerId after decoding the token

  @override
  void initState() {
    super.initState();
    fetchChattedBusinesses(); // Fetch chat data
  }

  Future<void> fetchChattedBusinesses() async {
    // Read the token from secure storage
    final token = await storage.read(key: 'accessToken');
    if (token == null) {
      _showError(context, 'Token not found. Please login again.');
      return;
    }

    try {
      // Decode the JWT token to extract the travellerId
      Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
      travellerId = decodedToken['id']; // Extract the `id` field as travellerId
      print("travellerId: $travellerId");
      final String apiUrl =
          '$baseUrl/forward/traveller/chatted-businesses/$travellerId';

      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': token, // Pass the token in the Authorization header
        },
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        if (responseData['success']) {
          setState(() {
            businesses = responseData['data']; // Assign the fetched businesses
            isLoading = false; // Stop loading
          });
        } else {
          _showError(context, responseData['message'] ??
              'Failed to fetch chatted businesses.');
        }
      } else {
        _showError(context, 'Failed to fetch chatted businesses. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching businesses: $e');
      _showError(context, 'Error fetching chatted businesses. Please try again later.');
    }
  }

  void _showError(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chats'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator()) // Show loading indicator
          : businesses.isEmpty
          ? Center(
        child: Text(
          "No businesses found.",
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      )
          : ListView.separated(
        itemCount: businesses.length,
        itemBuilder: (context, index) {
          final business = businesses[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.grey,
              backgroundImage: business['profileImage'] != null
                  ? NetworkImage(business['profileImage'])
                  : AssetImage('assets/images/sample_contact.png')
              as ImageProvider,
            ),
            title: Text(business['name']),
            subtitle: Text(business['email']),
            onTap: () {
              // Navigate to ChatConvoPage with the selected business
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ChatConvoPage(
                    contactName: business['name'],
                    businessId: business['businessId'],
                    travellerId: travellerId, // Pass the travellerId here
                  ),
                ),
              );
            },
          );
        },
        separatorBuilder: (context, index) {
          return Divider(color: Colors.grey.shade300);
        },
      ),
    );
  }
}
