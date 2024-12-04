import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:wandr/config.dart';

class ChatConvoPage extends StatefulWidget {
  final String contactName;
  final int businessId;
  final String travellerId;

  const ChatConvoPage({
    Key? key,
    required this.contactName,
    required this.businessId,
    required this.travellerId,
  }) : super(key: key);

  @override
  _ChatConvoPageState createState() => _ChatConvoPageState();
}

class _ChatConvoPageState extends State<ChatConvoPage> {
  TextEditingController _controller = TextEditingController();
  List<Map<String, dynamic>> messages = []; // Store chat history
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchChatHistory();
  }

  Future<void> fetchChatHistory() async {
    final String apiUrl =
        '$baseUrl/forward/chat/history?senderId=${widget.travellerId}&receiverId=${widget.businessId}';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        if (responseData['success']) {
          setState(() {
            messages = List<Map<String, dynamic>>.from(responseData['data']
                .map((msg) => {
              "messageId": msg['messageId'],
              "sender": msg['senderId'] == int.parse(widget.travellerId)
                  ? "Me"
                  : widget.contactName,
              "message": msg['message'],
              "timestamp": msg['timestamp'],
            }));
            isLoading = false;
          });
        }
      } else {
        print('Failed to load chat history');
      }
    } catch (e) {
      print('Error fetching chat history: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.contactName),
      ),
      body: Column(
        children: [
          isLoading
              ? Center(child: CircularProgressIndicator())
              : Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                return ListTile(
                  title: Align(
                    alignment: message["sender"] == "Me"
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      margin: EdgeInsets.symmetric(vertical: 5.0),
                      decoration: BoxDecoration(
                        color: message["sender"] == "Me"
                            ? Colors.green
                            : Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Text(
                        message["message"],
                        style: TextStyle(
                          color: message["sender"] == "Me"
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    ),
                  ),
                  subtitle: Align(
                    alignment: message["sender"] == "Me"
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Text(
                      message["timestamp"], // Display timestamp
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.grey,
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
                          "timestamp": DateTime.now().toString(),
                        });
                        _controller.clear();
                      });
                      // TODO: Add API call to send the message to the backend
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
