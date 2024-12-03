import 'package:wandr/theme/app_colors.dart'; // Ensure this has the primary color defined
import 'package:flutter/material.dart';
import 'chat_convo.dart'; // Import the ChatConvoPage

class ChatListPage extends StatelessWidget {
  const ChatListPage({Key? key}) : super(key: key);

  // Mark the contacts list as const since it doesn't change at runtime
  final List<String> contacts = const [
    "Perara Wooden Store",
    "Amandi Cloths",
    "Samudi Bathik",
    "Dinu Coco",
    "Sri Lanka Furniture",
    "Ravi Electronics",
    "Lanka Travels",
    "Nimali Shoes",
    "Madhavi Bakery",
    "Dhanush Textiles"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chats'),
      ),
      body: ListView.separated(
        itemCount: contacts.length, // Use the length of the contacts list
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: Kcolours.greenShade2, // Set the background color of the avatar
              backgroundImage: AssetImage('assets/images/sample_contact.png'), // Replace with actual contact images if available
            ),
            title: Text(contacts[index]), // Use the contact name from the list
            subtitle: Text('Last message preview here...'), // Replace with actual last message
            onTap: () {
              // Navigate to the ChatConvoPage with the selected contact name
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ChatConvoPage(contactName: contacts[index]),
                ),
              );
            },
          );
        },
        separatorBuilder: (context, index) {
          return Divider(
            color: Colors.grey.shade300, // Thin grey line
            height: 1, // Height of the divider
            thickness: 1, // Thickness of the divider line
          );
        },
      ),
    );
  }
}
