import 'package:stomp_dart_client/stomp_dart_client.dart';
import 'package:flutter/material.dart';

class WebSocketService with ChangeNotifier {
  late StompClient stompClient;
  late StompFrame? frame;
  final String url = "ws://localhost:8080/ws"; // Adjust to your backend WebSocket URL

  bool isConnected = false;
  List<Map<String, String>> chatMessages = [];

  WebSocketService() {
    _initWebSocket();
  }

  void _initWebSocket() {
    stompClient = StompClient(
      config: StompConfig(
        url: url,
        onConnect: (_) {
          isConnected = true;
          print("Connected to WebSocket");
          // Subscribe to the chat messages topic
          stompClient.subscribe(
            destination: '/topic/messages', // Backend WebSocket topic
            callback: (frame) {
              final message = frame.body != null ? frame.body! : '';
              _handleMessage(message);
            },
          );
        },
        onDisconnect: (_) {
          isConnected = false;
          print("Disconnected from WebSocket");
        },
        onWebSocketError: (error) {
          print("WebSocket Error: $error");
        },
      ),
    );

    stompClient.activate();
  }

  // Send message to the backend
  void sendMessage(String message) {
    if (isConnected) {
      stompClient.send(
        destination: '/app/chat', // The backend endpoint for sending messages
        body: message,
      );
    } else {
      print('WebSocket not connected');
    }
  }

  // Handle incoming messages
  void _handleMessage(String message) {
    chatMessages.add({"sender": "Remote", "message": message});
    notifyListeners();
  }

  // Close connection when done
  void close() {
    stompClient.deactivate();
  }
}
