import 'package:flutter/material.dart';

class ChatConvoPage extends StatefulWidget {
  final String contactName;

  const ChatConvoPage({Key? key, required this.contactName}) : super(key: key);

  @override
  _ChatConvoPageState createState() => _ChatConvoPageState();
}

class _ChatConvoPageState extends State<ChatConvoPage> {
  TextEditingController _controller = TextEditingController();
  List<Map<String, String>> messages = [
    {"sender": "Me", "message": "Hello, how are you?"},
    {"sender": "Perara Wooden Store", "message": "I'm good, thanks! How about you?"},
    {"sender": "Me", "message": "I'm doing well, just wanted to check in."},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.contactName), // Display the contact name in the app bar
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Align(
                    alignment: messages[index]["sender"] == "Me"
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      margin: EdgeInsets.symmetric(vertical: 5.0),
                      decoration: BoxDecoration(
                        color: messages[index]["sender"] == "Me"
                            ? Color.fromARGB(255, 20, 100, 37)
                            : Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Text(
                        messages[index]["message"]!,
                        style: TextStyle(
                          color: messages[index]["sender"] == "Me"
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey.shade200,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    if (_controller.text.isNotEmpty) {
                      setState(() {
                        messages.add({
                          "sender": "Me",
                          "message": _controller.text,
                        });
                        _controller.clear();
                      });
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
