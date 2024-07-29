import 'package:flutter/material.dart';
import 'package:wandr/pages/home/home_dashboard_screen.dart';
import 'package:wandr/pages/splash_screen.dart';
import 'package:wandr/pages/shop/main_shops_page.dart';
import 'package:wandr/pages/shop/shop_profile_page.dart';
import 'package:wandr/pages/shop/service_profile_page.dart';
import 'package:wandr/theme/app_colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        primaryColor: Kcolours.primary,
        fontFamily: 'Poppins',
      ),
      home: const SplashScreen(),
      routes: {
        '/dashboard': (context) => const DashboardScreen(),
        '/main_shops_page': (context) => const MainShopsPage(),
        // Other routes can be added here
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/shop_profile_page') {
          final args = settings.arguments as String;
          return MaterialPageRoute(
            builder: (context) {
              return ShopProfilePage(itemName: args);
            },
          );
        } else if (settings.name == '/service_profile_page') {
          final args = settings.arguments as String;
          return MaterialPageRoute(
            builder: (context) {
              return ServiceProfilePage(serviceName: args);
            },
          );
        }
        assert(false, 'Need to implement ${settings.name}');
        return null;
      },
    );
  }
}
