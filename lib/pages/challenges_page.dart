import 'package:flutter/material.dart';

import '../components/bottom_nav_bar.dart';

class ChallengesPage extends StatelessWidget {
  const ChallengesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavBar(),
      body: Center(child: Text('Challenges Page')),

    );
  }
}
