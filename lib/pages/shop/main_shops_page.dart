import 'package:flutter/material.dart';
import 'package:wandr/pages/dashboard_page.dart';
import 'package:wandr/theme/app_colors.dart';
import '../../components/bottom_nav_bar.dart';
import '../../components/custom_carousel.dart'; // Import the CustomCarousel component
import '../../components/service_slider.dart'; // Import the ServiceSlider component

class MainShopsPage extends StatelessWidget {
  const MainShopsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock data - replace this with your actual data fetching logic
    final categoryNames = [
      'Handicrafts',
      'Souvenirs',
      'Local Cuisine',
      'Travel Essentials',
      'Clothing',
    ];
    final imagePaths = [
      'assets/shop-categories/category-handicrafts.png',
      'assets/shop-categories/category-souvenirs.png',
      'assets/shop-categories/category-localcuisine.png',
      'assets/shop-categories/category-travelessentials.png',
      'assets/shop-categories/category-clothing.png',
    ];

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new_outlined, size: 30,),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DashboardPage()),
              );
            },
          ),
          actions: [
            IconButton(onPressed: () {}, icon: Icon(Icons.favorite_border, size: 30,)),
            IconButton(onPressed: () {}, icon: Icon(Icons.shopping_cart_outlined, size: 30,))
          ],
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        body: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 10),
              // Main Heading
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Text(
                  'Discover Local Treasures',
                  textAlign: TextAlign.center, // Center the text
                  style: TextStyle(
                    color: Kcolours.primary,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins-Bold',
                  ),
                ),
              ),

              // Tab Bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: TabBar(
                  labelColor: Kcolours.primary,
                  unselectedLabelColor: Colors.grey,
                  labelStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  unselectedLabelStyle: TextStyle(fontSize: 16),
                  indicator: UnderlineTabIndicator(
                    borderSide: BorderSide(width: 4.0, color: Kcolours.primary),
                    insets: EdgeInsets.symmetric(horizontal: 90.0),
                  ),
                  tabs: [
                    Tab(text: 'Shops'),
                    Tab(text: 'Services'),
                  ],
                ),
              ),

              // Tab Bar View
              Expanded(
                child: TabBarView(
                  children: [
                    // Content for Shops Tab
                    ListView(
                      padding: EdgeInsets.all(20.0), // Add padding to ListView
                      children: [
                        // Description text below the Tab Bar
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0), // Add horizontal padding
                          child: Text(
                            'Browse through a variety of local shops offering unique products, from handmade crafts to travel essentials. Support local businesses and find one-of-a-kind items to make your trip memorable.',
                            textAlign: TextAlign.left, // Align the text to the left
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 15,
                            ),
                          ),
                        ),

                        SizedBox(height: 20), // Add some spacing

                        // Carousel Slider Component
                        CustomCarousel(
                          imagePaths: [
                            'assets/advertisements/shops-ad-1.png',
                            'assets/advertisements/shops-ad-1.png',
                            'assets/advertisements/shops-ad-1.png',
                          ],
                        ),

                        SizedBox(height: 20), // Add some spacing

                        // Service Slider Component
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: ServiceSlider(
                            categoryNames: categoryNames,
                            imagePaths: imagePaths,
                          ),
                        ),

                        // Add more shop content here
                      ],
                    ),
                    // Content for Services Tab
                    ListView(
                      padding: EdgeInsets.all(20.0), // Add padding to ListView
                      children: [
                        // Add your services content here
                        Text('Services content goes here'),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavBar(),
      ),
    );
  }
}
