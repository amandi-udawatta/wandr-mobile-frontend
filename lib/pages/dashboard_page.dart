import 'package:flutter/material.dart';
import 'package:wandr/components/bottom_nav_bar.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Dashboard")),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
