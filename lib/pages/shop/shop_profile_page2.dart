import 'package:flutter/material.dart';
import 'package:wandr/theme/app_colors.dart';
import '../../components/primary_button.dart';
import 'main_shops_page.dart'; // Import MainShopsPage for navigation
import 'package:wandr/pages/shop/shop_profile_page.dart';

class ShopProfilePage2 extends StatefulWidget {
  final String itemName;

  const ShopProfilePage2({Key? key, required this.itemName}) : super(key: key);

  @override
  _ShopProfilePage2State createState() => _ShopProfilePage2State();
}

class _ShopProfilePage2State extends State<ShopProfilePage2> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    String fullText =
        "Gem Haven is a dazzling destination for tourists seeking rare and exquisite gemstones. Located in vibrant tourist hotspots, Gem Haven offers a curated selection of ethically sourced gems, bespoke jewelry, and locally inspired accessories. Our shop is designed to be more than a store – it’s an exploration of natural beauty, craftsmanship, and cultural heritage. With a commitment to authenticity and artistry, Gem Haven invites visitors to discover treasures they can cherish forever.";

    List<String> words = fullText.split(' ');
    String firstPart = words.take(20).join(' ') + "... ";
    String secondPart = words.skip(20).join(' ');

    List<Map<String, String>> services = [
      {
        "title": "Gemstone Customization",
        "description": "Personalized jewelry creation services where customers select gemstones and designs to craft unique, one-of-a-kind pieces."
      },
      {
        "title": "Gem Identification Workshops",
        "description": "Interactive sessions where visitors learn to identify different gemstones, understand their origins, and discover their symbolic meanings."
      },
      {
        "title": "Gem Art Exhibits",
        "description": "Displays of rare and unique gemstones paired with storytelling about their history and cultural significance."
      },
    ];

    List<Map<String, String>> otherProducts = [
      {
        "imagePath": "assets/images/shops/item-cane-laundry-basket.png",
        "price": "Rs.3,300.00",
        "name": "Cane Laundry Basket",
        "storeName": "Gem Haven"
      },
      {
        "imagePath": "assets/images/shops/item-handwoven-baskets.png",
        "price": "Rs.4,700.00",
        "name": "Handwoven Baskets",
        "storeName": "Gem Haven"
      },
      {
        "imagePath": "assets/images/shops/item-rattan-round-serving-tray.png",
        "price": "Rs.2,460.00",
        "name": "Rattan Round Serving Tray",
        "storeName": "Gem Haven"
      }
    ];

    List<Map<String, String>> similarProducts = [
      {
        "imagePath": "assets/images/shops/item-shopping-basket.png",
        "price": "Rs.1,500.00",
        "name": "Shopping Basket",
        "storeName": "Perera and Daughters"
      },
      {
        "imagePath": "assets/images/shops/item-handmade-basket-decoration.png",
        "price": "Rs.3,400.00",
        "name": "Handmade Basket Decoration",
        "storeName": "Victors Decors"
      },
      {
        "imagePath": "assets/images/shops/item-willow-market-basket.png",
        "price": "Rs.5,460.00",
        "name": "Willow Market Basket",
        "storeName": "Super Crafts"
      }
    ];

    String location = "No 89, Pagoda, Gileemale, Sri Lanka";
    String languages = "English, Sinhala, Tamil";
    String website = "www.gemhaven.com";
    String contactUs = "0774441482";

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300.0,
            floating: false,
            pinned: true,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_new_outlined, size: 30, color: Colors.white),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MainShopsPage()),
                );
              },
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    'assets/images/shops/item-basket.png',
                    fit: BoxFit.cover,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.black.withOpacity(0.6), Colors.transparent],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 16.0,
                    bottom: 16.0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.itemName,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4.0),
                        Row(
                          children: [
                            Icon(Icons.location_on, color: Colors.white, size: 16.0),
                            SizedBox(width: 4.0),
                            Text(
                              'Gileemale, Sri Lanka',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
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
          ),
          SliverToBoxAdapter(
            child: Container(
              color: Color(0xFF337102).withOpacity(0.1),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Text(
                      isExpanded ? fullText : firstPart,
                      style: TextStyle(fontSize: 16, color: Colors.black),
                      textAlign: TextAlign.justify,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          isExpanded = !isExpanded;
                        });
                      },
                      child: Row(
                        children: [
                          Text(
                            isExpanded ? 'Less' : 'More',
                            style: TextStyle(fontSize: 16, color: Kcolours.primary),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Services:",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 6),
                  for (var service in services) ...[
                    Row(
                      children: [
                        Transform.rotate(
                          angle: -0.5,
                          child: Icon(Icons.circle, size: 10, color: Kcolours.primary),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            "${service['title']}: ${service['description']}",
                            style: TextStyle(fontSize: 16, color: Colors.black),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                  ],
                  SizedBox(height: 12),
                  Row(
                    children: [
                      Text(
                        "Location: ",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Expanded(
                        child: Text(
                          location,
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Row(
                    children: [
                      Text(
                        "Languages: ",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Expanded(
                        child: Text(
                          languages,
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Row(
                    children: [
                      Text(
                        "Website: ",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Expanded(
                        child: Text(
                          website,
                          style: TextStyle(fontSize: 16, color: Kcolours.primary),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Row(
                    children: [
                      Text(
                        "Contact Us: ",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Expanded(
                        child: Text(
                          contactUs,
                          style: TextStyle(fontSize: 16, color: Kcolours.black),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  PrimaryButton(
                    onTap: () {},
                    text: "Chat",
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Other Products:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    height: 350,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: otherProducts.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            // Navigate to ShopProfilePage when an item is tapped
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ShopProfilePage(
                                  itemName: otherProducts[index]['name']!,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            width: 230,
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Container(
                                  height: 200,
                                  width: 200,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(otherProducts[index]['imagePath']!),
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  otherProducts[index]['name']!,
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  otherProducts[index]['price']!,
                                  style: TextStyle(fontSize: 14, color: Colors.grey),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  otherProducts[index]['storeName']!,
                                  style: TextStyle(fontSize: 14, color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),

          // For Similar Products
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Similar Products:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    height: 350,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: similarProducts.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            // Navigate to ShopProfilePage when an item is tapped
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ShopProfilePage(
                                  itemName: similarProducts[index]['name']!,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            width: 230,
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Container(
                                  height: 200,
                                  width: 200,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(similarProducts[index]['imagePath']!),
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  similarProducts[index]['name']!,
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  similarProducts[index]['price']!,
                                  style: TextStyle(fontSize: 14, color: Colors.grey),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  similarProducts[index]['storeName']!,
                                  style: TextStyle(fontSize: 14, color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
