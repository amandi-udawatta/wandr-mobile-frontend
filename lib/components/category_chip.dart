import 'package:flutter/material.dart';

class CategoryChip extends StatelessWidget {
  final String categoryName;

  const CategoryChip({Key? key, required this.categoryName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Mapping the category name to the corresponding image file name
    final Map<String, String> categoryImages = {
      'Hiking': 'hiking.png',
      'Surfing': 'surfing.png',
      'Scuba Diving': 'scuba-diving.png',
      'Wildlife Safari': 'wildlife-safari.png',
      'Bird Watching': 'bird-watching.png',
      'Cultural Tours': 'cultural-tours.png',
      'Historical Tours': 'historical-tours.png',
      'Temple Visits': 'temple-visits.png',
      'Waterfall Visits': 'waterfall-visits.png',
      'Whale Watching': 'whale-watching.png',
      'Fishing': 'fishing.png',
      'Camping': 'camping.png',
      'Rock Climbing': 'rock-climbing.png',
      'Cycling': 'cycling.png',
      'Kayaking': 'kayaking.png',
      'Canoeing': 'canoeing.png',
      'Boating': 'boating.png',
      'Hot Air Ballooning': 'hot-air-ballooning.png',
      'Tea Plantation Tours': 'tea-plantation-tours.png',
      'Elephant Rides': 'elephant-rides.png',
      'Village Tours': 'village-tours.png',
      'Food Tours': 'food-tours.png',
      'Trekking': 'trekking.png',
      'Photography': 'photography.png',
      'Caving': 'caving.png',
    };

    final imagePath = 'assets/images/categories/${categoryImages[categoryName]}';

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.green),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            backgroundColor: Colors.transparent,
            backgroundImage: AssetImage(imagePath),
            radius: 12,
          ),
          SizedBox(width: 8),
          Text(
            categoryName,
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
