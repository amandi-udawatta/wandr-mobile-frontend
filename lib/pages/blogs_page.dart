import 'package:flutter/material.dart';

import '../components/bottom_nav_bar.dart';

class BlogsPage extends StatelessWidget {
  const BlogsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavBar(),
      body: Center(child: Text('Blogs Page')),

    );
  }
}
