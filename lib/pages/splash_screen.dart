import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wandr/pages/login_page.dart';
import 'package:wandr/pages/profile/profile_main.dart';
import 'package:wandr/pages/signup/pref_activities_page.dart';

import 'package:wandr/pages/home/home_dashboard_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => DashboardScreen()), //LoginPage()  DashboardScreen()
      );
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
        image: AssetImage('assets/images/logo-image.png'),
      )),
    );
  }
}
