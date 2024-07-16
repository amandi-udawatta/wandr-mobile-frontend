import 'package:flutter/material.dart';

class ShopProfilePage extends StatelessWidget {
  final String itemName;

  const ShopProfilePage({Key? key, required this.itemName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(itemName),
      ),
      body: Center(
        child: Text(
          itemName,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
