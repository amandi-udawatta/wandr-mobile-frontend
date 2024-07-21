import 'package:flutter/material.dart';
import 'package:wandr/theme/app_colors.dart';
import 'main_shops_page.dart'; // Import MainShopsPage for navigation

class ShopProfilePage extends StatefulWidget {
  final String itemName;

  const ShopProfilePage({Key? key, required this.itemName}) : super(key: key);

  @override
  _ShopProfilePageState createState() => _ShopProfilePageState();
}

class _ShopProfilePageState extends State<ShopProfilePage> {
  bool isExpanded = false;
  int quantity = 1; // Initial quantity

  @override
  Widget build(BuildContext context) {
    // Mock data for item (replace with actual data fetching logic)
    Map<String, String> itemData = {
      "imagePath": "assets/images/shops/item-basket.png",
      "price": "Rs.2,300.00",
      "name": "Handwoven Rattan Basket",
      "storeName": "Rattan Wonders",
      "description":
      "This beautifully handwoven rattan basket is the perfect blend of functionality and style. Crafted by skilled artisans, it offers a durable and eco-friendly solution for your storage needs. Whether used for organizing household items, displaying fruits, or as a decorative piece, this basket adds a touch of natural elegance to any space. Read More...",
      "storeLogoPath": "assets/images/shops/shop-logos/handwoven-basket.png"
    };

    // Mock data for delivery information (replace with actual data fetching logic)
    Map<String, String> deliveryData = {
      "dateDuration": "Mon 30 April - Wed 2 May",
      "price": "Rs. 250.00",
      "address": "No.54, Prime Apartments, Colombo 4"
    };

    // Mock data for other products from same shop (replace with actual data fetching logic)
    List<Map<String, String>> otherProducts = [
      {
        "imagePath": "assets/images/shops/item-cane-laundry-basket.png",
        "price": "Rs.3,300.00",
        "name": "Cane Laundry Basket",
        "storeName": "Rattan Wonders"
      },
      {
        "imagePath": "assets/images/shops/item-handwoven-baskets.png",
        "price": "Rs.4,700.00",
        "name": "Handwoven Baskets",
        "storeName": "Rattan Wonders"
      },
      {
        "imagePath": "assets/images/shops/item-rattan-round-serving-tray.png",
        "price": "Rs.2,460.00",
        "name": "Rattan Round Serving Tray",
        "storeName": "Rattan Wonders"
      }
    ];

    // Mock data for similar products (replace with actual data fetching logic)
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

    String fullDescription = itemData["description"]!;
    List<String> words = fullDescription.split(' ');
    String firstPart = words.take(20).join(' ') + "... ";
    String secondPart = words.skip(20).join(' ');

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
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.favorite_border, size: 30, color: Colors.white),
              ),
              IconButton(
                onPressed: () {},
                icon: Stack(
                  children: [
                    const Icon(Icons.shopping_cart_outlined, size: 30, color: Colors.white),
                    Positioned(
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(1),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 12,
                          minHeight: 12,
                        ),
                        child: const Text(
                          '3',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 8,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    itemData["imagePath"]!,
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
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              itemData["price"]!,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              itemData["name"]!,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "by ${itemData["storeName"]!}",
                              style: const TextStyle(
                                fontSize: 16,
                                color: Kcolours.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Kcolours.brownShade1, width: 2),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: Image.asset(
                          itemData["storeLogoPath"]!,
                          width: 60,
                          height: 60,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    isExpanded ? fullDescription : firstPart,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Kcolours.brownShade2,
                    ),
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
                          style: const TextStyle(fontSize: 16, color: Kcolours.primary),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: quantity > 1
                            ? () {
                          setState(() {
                            quantity--;
                          });
                        }
                            : null,
                        child: Container(
                          padding: EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: quantity > 1 ? Kcolours.primary : Kcolours.brownShade1,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.remove,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        '$quantity',
                        style: TextStyle(
                          fontSize: 18,
                          color: Kcolours.black,
                        ),
                      ),
                      SizedBox(width: 10),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            quantity++;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Kcolours.primary,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Spacer(),
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Kcolours.primary, // Button background color
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          // Navigate to the chat page
                        },
                        icon: Icon(Icons.chat_bubble_outline, color: Kcolours.whiteAlternative),
                        label: Text(
                          "Chat",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Delivery Section
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Kcolours.primary.withOpacity(0.4)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.card_giftcard_outlined,
                              size: 30,
                              color: Kcolours.brownShade4,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              "Delivery",
                              style: TextStyle(
                                fontSize: 20,
                                color: Kcolours.brownShade4,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              deliveryData["dateDuration"]!,
                              style: TextStyle(
                                fontSize: 20,
                                color: Kcolours.brownShade4,
                              ),
                            ),
                            Text(
                              deliveryData["price"]!,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Kcolours.brownShade3,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Address : ${deliveryData["address"]!}",
                          style: TextStyle(
                            fontSize: 15,
                            color: Kcolours.brownShade3,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Products from the same shop section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Products from same shop',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Kcolours.brownShade4,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Navigate to the 'See All' page
                        },
                        child: const Text(
                          'See All',
                          style: TextStyle(
                            color: Kcolours.blueShade2,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Container(
                    height: 250,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: otherProducts.length,
                      itemBuilder: (context, index) {
                        final product = otherProducts[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ShopProfilePage(itemName: product["name"]!),
                              ),
                            );
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 10.0),
                            width: 180,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(
                                image: AssetImage(product["imagePath"]!),
                                fit: BoxFit.cover,
                                colorFilter: ColorFilter.mode(
                                  Colors.black.withOpacity(0.2),
                                  BlendMode.darken,
                                ),
                              ),
                            ),
                            child: Stack(
                              children: [
                                Positioned(
                                  top: 10,
                                  right: 10,
                                  child: Icon(
                                    Icons.favorite_border,
                                    color: Colors.white,
                                  ),
                                ),
                                Positioned(
                                  bottom: 10,
                                  left: 10,
                                  right: 10,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        product["name"]!,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        "by ${product["storeName"]!}",
                                        style: TextStyle(
                                          color: Colors.white70,
                                          fontSize: 12,
                                        ),
                                      ),
                                      Text(
                                        product["price"]!,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Similar Products section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Similar Products',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Kcolours.brownShade4,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Navigate to the 'See All' page
                        },
                        child: const Text(
                          'See All',
                          style: TextStyle(
                            color: Kcolours.blueShade2,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Container(
                    height: 250,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: similarProducts.length,
                      itemBuilder: (context, index) {
                        final product = similarProducts[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ShopProfilePage(itemName: product["name"]!),
                              ),
                            );
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 10.0),
                            width: 180,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(
                                image: AssetImage(product["imagePath"]!),
                                fit: BoxFit.cover,
                                colorFilter: ColorFilter.mode(
                                  Colors.black.withOpacity(0.2),
                                  BlendMode.darken,
                                ),
                              ),
                            ),
                            child: Stack(
                              children: [
                                Positioned(
                                  top: 10,
                                  right: 10,
                                  child: Icon(
                                    Icons.favorite_border,
                                    color: Colors.white,
                                  ),
                                ),
                                Positioned(
                                  bottom: 10,
                                  left: 10,
                                  right: 10,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        product["name"]!,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        "by ${product["storeName"]!}",
                                        style: TextStyle(
                                          color: Colors.white70,
                                          fontSize: 12,
                                        ),
                                      ),
                                      Text(
                                        product["price"]!,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
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
