import 'package:flutter/material.dart';
import 'package:wandr/components/bottom_nav_bar.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Dashboard")),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
