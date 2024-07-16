import 'package:flutter/material.dart';
import 'package:wandr/pages/shop/main_shops_page.dart';

class ServiceProfilePage extends StatelessWidget {
  final String serviceName;

  const ServiceProfilePage({Key? key, required this.serviceName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_outlined, size: 30,),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MainShopsPage()),
            );
          },
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Center(
        child: Text(
          serviceName,
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
