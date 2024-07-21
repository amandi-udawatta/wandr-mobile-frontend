import 'package:flutter/material.dart';
import 'package:wandr/pages/rewards/rewards_page.dart';
import 'package:wandr/theme/app_colors.dart';
import '../../components/bottom_nav_bar.dart';

class NewChallengesPage extends StatelessWidget {
  const NewChallengesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_outlined, size: 30,),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const RewardsPage()),
            );
          },
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
      body: SafeArea(
        child: Center(
          child: ListView(
            children: [
            ],
          ),
        ),
      ),
    );
  }
}
