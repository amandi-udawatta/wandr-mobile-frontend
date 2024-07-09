import 'package:flutter/material.dart';
import 'package:wandr/pages/dashboard_page.dart';
import '../../components/bottom_nav_bar.dart';

class MainShopsPage extends StatelessWidget {
  const MainShopsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   leading: IconButton(
      //     icon: Icon(Icons.arrow_back_ios_new_outlined),
      //     onPressed: () {
      //       Navigator.push(
      //         context,
      //         MaterialPageRoute(builder: (context) => DashboardPage()),
      //       );
      //     },
      //   ),
      //   backgroundColor: Colors.white,
      //   elevation: 0,
      //   iconTheme: IconThemeData(color: Colors.black), // Change the color of the back icon
      // ),
      bottomNavigationBar: BottomNavBar(),
      body: Center(child: Text('Shops Page')),
    );
  }
}
