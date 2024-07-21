import 'package:flutter/material.dart';
import 'package:wandr/pages/dashboard_page.dart';
import 'package:wandr/theme/app_colors.dart';
import '../../components/bottom_nav_bar.dart';
import '../../components/custom_carousel.dart';
import '../../components/service_slider.dart';
import '../../components/recommended_services_vertical_list.dart';

class MainShopsPage extends StatelessWidget {
  const MainShopsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock data for shop categories - replace this with your actual data fetching logic
    final shopCategoryNames = [
      'Handicrafts',
      'Souvenirs',
      'Local Cuisine',
      'Travel Essentials',
      'Clothing',
    ];
    final shopImagePaths = [
      'assets/images/shop-categories/category-handicrafts.png',
      'assets/images/shop-categories/category-souvenirs.png',
      'assets/images/shop-categories/category-localcuisine.png',
      'assets/images/shop-categories/category-travelessentials.png',
      'assets/images/shop-categories/category-clothing.png',
    ];

    // Mock data for service categories
    final serviceCategoryNames = [
      'Surfing',
      'Mountain Climbing',
      'Camping',
      'Accommodation',
      'Sightseeing',
    ];
    final serviceImagePaths = [
      'assets/images/service-categories/category-surfing.png',
      'assets/images/service-categories/category-mountainclimbing.png',
      'assets/images/service-categories/category-camping.png',
      'assets/images/service-categories/category-accommodation.png',
      'assets/images/service-categories/category-sightseeing.png',
    ];

    // Mock data for recommended items - replace this with your actual data fetching logic
    final recommendedItemNames = [
      'Handcrafted Wooden Elephant',
      'Handwoven Rattan Basket',
      'Gemstone Necklace',
      'Batik Print Scarf',
      'Sri Lankan Spices Set',
      'Hand-painted Wall Art',
    ];
    final recommendedItemImages = [
      'assets/images/shops/item-elephant.png',
      'assets/images/shops/item-basket.png',
      'assets/images/shops/item-necklace.png',
      'assets/images/shops/item-scarf.png',
      'assets/images/shops/item-spices.png',
      'assets/images/shops/item-wallart.png',
    ];
    final recommendedItemPrices = [
      'Rs.1,500.00',
      'Rs.2,300.00',
      'Rs.15,700.00',
      'Rs.3,450.00',
      'Rs.1,200.00',
      'Rs.16,450.00',
    ];
    final recommendedItemStores = [
      'by Elephant Craft Store',
      'by Rattan Wonders',
      'by Jewel Paradise',
      'by Batik Boutique',
      'by Spice Emporium',
      'by Artistic Expressions',
    ];

    // Mock data for recommended services - replace this with your actual data fetching logic
    final recommendedServiceNames = [
      'Surfing Academy',
      'Hot Air Balloons',
      'Adventure Park',
      'Atiken Spence Hotel',
      'Camping Tours',
      'Hike Tour Guiding',
    ];
    final recommendedServiceImages = [
      'assets/images/services/surfing-academy.png',
      'assets/images/services/hot-air-balloon.png',
      'assets/images/services/adventure-park.png',
      'assets/images/services/hotel.png',
      'assets/images/services/camping-tour.png',
      'assets/images/services/hikes.png',
    ];
    final recommendedServicePrices = [
      'Rs.1,500.00',
      'Rs.2,300.00',
      'Rs.15,700.00',
      'Rs.3,450.00',
      'Rs.1,200.00',
      'Rs.16,450.00',
    ];
    final recommendedServiceStores = [
      'by Surfing Academy',
      'by Balloon Adventures',
      'by Adventure Park',
      'by Atiken Spence',
      'by Camping Tours',
      'by Hike Tour Guides',
    ];

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_outlined, size: 30,),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const DashboardPage()),
              );
            },
          ),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.favorite_border, size: 30,)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.shopping_cart_outlined, size: 30,))
          ],
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        body: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 10),
              // Main Heading
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0),
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
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0),
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
                      padding: const EdgeInsets.all(20.0),
                      children: [
                        // Description
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            'Browse through a variety of local shops offering unique products, from handmade crafts to travel essentials. Support local businesses and find one-of-a-kind items to make your trip memorable.',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 15,
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Carousel Slider for Ads
                        const CustomCarousel(
                          imagePaths: [
                            'assets/advertisements/shops-ad-1.png',
                            'assets/advertisements/shops-ad-1.png',
                            'assets/advertisements/shops-ad-1.png',
                          ],
                        ),

                        const SizedBox(height: 20),

                        // Service Slider for Shops
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: ServiceSlider(
                            categoryNames: shopCategoryNames,
                            imagePaths: shopImagePaths,
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Recommended Items
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: RecommendedServicesVerticalList(
                            title: "Recommended Items",
                            itemNames: recommendedItemNames,
                            itemImages: recommendedItemImages,
                            itemPrices: recommendedItemPrices,
                            itemStores: recommendedItemStores,
                            isShop: true, // Indicate that these are shop items
                          ),
                        ),
                      ],
                    ),
                    // Content for Services Tab
                    ListView(
                      padding: const EdgeInsets.all(20.0),
                      children: [
                        // Description
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            'Find a variety of services to elevate your travel experience. From guided tours and transportation to wellness spas and adventure activities, discover local providers ready to make your trip unforgettable.',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 15,
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Carousel Slider for Ads
                        const CustomCarousel(
                          imagePaths: [
                            'assets/advertisements/shops-ad-1.png',
                            'assets/advertisements/shops-ad-1.png',
                            'assets/advertisements/shops-ad-1.png',
                          ],
                        ),

                        const SizedBox(height: 20),

                        // Service Slider for Services
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: ServiceSlider(
                            categoryNames: serviceCategoryNames,
                            imagePaths: serviceImagePaths,
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Recommended Services
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: RecommendedServicesVerticalList(
                            title: "Recommended Services",
                            itemNames: recommendedServiceNames,
                            itemImages: recommendedServiceImages,
                            itemPrices: recommendedServicePrices,
                            itemStores: recommendedServiceStores,
                            isShop: false, // Indicate that these are service items
                          ),
                        ),
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
