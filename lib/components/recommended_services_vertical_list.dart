import 'package:flutter/material.dart';
import 'package:wandr/theme/app_colors.dart';
import 'package:wandr/pages/shop/shop_profile_page.dart';
import 'package:wandr/pages/shop/service_profile_page.dart';

class RecommendedServicesVerticalList extends StatefulWidget {
  final String title;
  final List<String> itemNames;
  final List<String> itemImages;
  final List<String> itemPrices;
  final List<String> itemStores;
  final bool isShop; // Add a flag to determine if it's a shop or service

  const RecommendedServicesVerticalList({
    Key? key,
    required this.title,
    required this.itemNames,
    required this.itemImages,
    required this.itemPrices,
    required this.itemStores,
    this.isShop = false, // Default to false (service)
  }) : super(key: key);

  @override
  _RecommendedServicesVerticalListState createState() => _RecommendedServicesVerticalListState();
}

class _RecommendedServicesVerticalListState extends State<RecommendedServicesVerticalList> {
  late List<bool> likedItems;

  @override
  void initState() {
    super.initState();
    likedItems = List<bool>.filled(widget.itemNames.length, false);
  }

  void toggleFavorite(int index) {
    setState(() {
      likedItems[index] = !likedItems[index];
    });
  }

  void navigateToProfile(String name) {
    if (widget.isShop) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ShopProfilePage(itemName: name),
        ),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ServiceProfilePage(serviceName: name),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Kcolours.brownShade4,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/all_items'); // Ensure this route is defined
              },
              child: Text(
                'See All',
                style: TextStyle(
                  color: Kcolours.blueShade2,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10.0,
            childAspectRatio: 0.75,
          ),
          itemCount: widget.itemNames.length > 6 ? 6 : widget.itemNames.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => navigateToProfile(widget.itemNames[index]),
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      image: DecorationImage(
                        image: AssetImage(widget.itemImages[index]),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: GestureDetector(
                      onTap: () => toggleFavorite(index),
                      child: Container(
                        padding: EdgeInsets.all(6.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: Icon(
                          likedItems[index] ? Icons.favorite : Icons.favorite_border,
                          color: likedItems[index] ? Colors.red : Colors.black,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(15.0),
                          bottomRight: Radius.circular(15.0),
                        ),
                        gradient: LinearGradient(
                          colors: [
                            Colors.black.withOpacity(0.8),
                            Colors.black.withOpacity(0.0),
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                      ),
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.itemNames[index],
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            widget.itemStores[index],
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            widget.itemPrices[index],
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
