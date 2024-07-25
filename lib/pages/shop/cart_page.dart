import 'package:flutter/material.dart';
import 'package:wandr/pages/shop/main_shops_page.dart';
import 'package:wandr/theme/app_colors.dart';
import '../../components/bottom_nav_bar.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  // Mock data for cart items
  final List<Map<String, dynamic>> cartItems = [
    {
      "name": "Handcrafted Wooden Elephant",
      "store": "Elephant Craft Store",
      "price": 1500.00,
      "image": "assets/images/shops/item-elephant.png",
      "quantity": 1,
      "selected": false
    },
    {
      "name": "Handwoven Rattan Basket",
      "store": "Rattan Wonders",
      "price": 2300.00,
      "image": "assets/images/shops/item-basket.png",
      "quantity": 1,
      "selected": false
    },
    {
      "name": "Batik Print Scarf",
      "store": "Batik Boutique",
      "price": 3450.00,
      "image": "assets/images/shops/item-scarf.png",
      "quantity": 1,
      "selected": false
    },
    {
      "name": "Handwoven Baskets",
      "store": "Rattan Wonders",
      "price": 9400.00,
      "image": "assets/images/shops/item-handwoven-baskets.png",
      "quantity": 2,
      "selected": false
    }
  ];

  bool selectAll = false;
  bool deleteEnabled = false;

  void toggleSelectAll() {
    setState(() {
      selectAll = !selectAll;
      for (var item in cartItems) {
        item['selected'] = selectAll;
      }
      deleteEnabled = selectAll;
    });
  }

  void toggleSelection(int index) {
    setState(() {
      cartItems[index]['selected'] = !cartItems[index]['selected'];
      deleteEnabled = cartItems.any((item) => item['selected']);
      if (!cartItems[index]['selected']) {
        selectAll = false;
      } else if (cartItems.every((item) => item['selected'])) {
        selectAll = true;
      }
    });
  }

  void deleteSelectedItems() {
    setState(() {
      cartItems.removeWhere((item) => item['selected']);
      deleteEnabled = false;
      selectAll = false;
    });
  }

  void increaseQuantity(int index) {
    setState(() {
      cartItems[index]['quantity']++;
    });
  }

  void decreaseQuantity(int index) {
    setState(() {
      if (cartItems[index]['quantity'] > 1) {
        cartItems[index]['quantity']--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Kcolours.white,
      appBar: AppBar(
        backgroundColor: Kcolours.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_outlined, size: 30),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MainShopsPage()),
            );
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CartPage()),
              );
            },
            icon: const Icon(Icons.favorite_border, size: 30),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CartPage()),
              );
            },
            icon: const Icon(Icons.shopping_cart_outlined, size: 30),
          )
        ],
      ),
      bottomNavigationBar: BottomNavBar(),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: toggleSelectAll,
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: selectAll ? Kcolours.primary : Colors.grey,
                              width: 2,
                            ),
                            color: selectAll ? Kcolours.primary : Colors.white,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Icon(
                              Icons.check,
                              size: 20.0,
                              color: selectAll ? Colors.white : Colors.transparent,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        "All",
                        style: TextStyle(
                          color: Kcolours.primary,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.delete_outline_rounded,
                      color: deleteEnabled ? Colors.red : Colors.grey, size: 35,
                    ),
                    onPressed: deleteEnabled ? deleteSelectedItems : null,
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  final item = cartItems[index];
                  return Stack(
                    children: [
                      Container(
                        margin: const EdgeInsets.fromLTRB(50.0,5,30,5),
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: Kcolours.white,
                          borderRadius: BorderRadius.circular(15.0),
                          border: Border.all(
                            color: item['selected'] ? Kcolours.primary : Colors.grey.shade300,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),

                        // Item section
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(19,3,2,3),
                          child: Row(
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    Image.asset(
                                      item['image'],
                                      width: 80,
                                      height: 80,
                                      fit: BoxFit.cover,
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            item['name'],
                                            style: const TextStyle(
                                              fontSize: 18,
                                              color: Colors.black,
                                            ),
                                          ),
                                          Text(
                                            "by ${item['store']}",
                                            style: const TextStyle(
                                              fontSize: 14,
                                              color: Kcolours.greyShade1,
                                            ),
                                          ),
                                          Text(
                                            "Rs.${item['price'].toStringAsFixed(2)}",
                                            style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 50,
                        left: 10,
                        child: GestureDetector(
                          onTap: () => toggleSelection(index),
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: item['selected'] ? Kcolours.primary : Colors.grey,
                                width: 2,
                              ),
                              color: item['selected'] ? Kcolours.primary : Colors.white,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Icon(
                                Icons.check,
                                size: 20.0,
                                color: item['selected'] ? Colors.white : Colors.transparent,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 20,
                        right: 40,
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: item['quantity'] > 1
                                  ? () => decreaseQuantity(index)
                                  : null,
                              child: Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: item['quantity'] > 1 ? Kcolours.primary : Kcolours.brownShade1,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.remove,
                                  color: Colors.white,
                                  size: 15,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              '${item['quantity']}',
                              style: const TextStyle(
                                fontSize: 18,
                                color: Kcolours.black,
                              ),
                            ),
                            const SizedBox(width: 10),
                            GestureDetector(
                              onTap: () => increaseQuantity(index),
                              child: Container(
                                padding: const EdgeInsets.all(6),
                                decoration: const BoxDecoration(
                                  color: Kcolours.primary,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.add,
                                  color: Colors.white,
                                  size: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
