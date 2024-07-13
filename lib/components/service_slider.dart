import 'package:flutter/material.dart';

class ServiceSlider extends StatelessWidget {
  final List<String> categoryNames;
  final List<String> imagePaths;

  const ServiceSlider({Key? key, required this.categoryNames, required this.imagePaths}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Categories',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown[800]
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/all_shops'); // Make sure you have the route defined
              },
              child: Text(
                'See All',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Container(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categoryNames.length > 5 ? 5 : categoryNames.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10.0),
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
                  SizedBox(height: 5),
                  Text(
                    categoryNames[index],
                    style: TextStyle(
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
