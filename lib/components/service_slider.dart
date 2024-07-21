import 'package:flutter/material.dart';
import 'package:wandr/theme/app_colors.dart';

class ServiceSlider extends StatelessWidget {
  final List<String> categoryNames;
  final List<String> imagePaths;

  const ServiceSlider({super.key, required this.categoryNames, required this.imagePaths});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Categories',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Kcolours.brownShade4
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/all_shops'); // Put the correct link
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
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categoryNames.length > 5 ? 5 : categoryNames.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10.0),
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(imagePaths[index]),
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    categoryNames[index],
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
