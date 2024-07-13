import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CustomCarousel extends StatelessWidget {
  final List<String> imagePaths;

  const CustomCarousel({Key? key, required this.imagePaths}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: CarouselSlider(
        options: CarouselOptions(
          height: 110.0,
          enlargeCenterPage: true,
          autoPlay: true,
          aspectRatio: 16 / 9,
          autoPlayCurve: Curves.fastOutSlowIn,
          enableInfiniteScroll: true,
          autoPlayAnimationDuration: Duration(milliseconds: 800),
          viewportFraction: 0.8,
        ),
        items: imagePaths.map((path) {
          return Builder(
            builder: (BuildContext context) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Image.asset(
                  path,
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width,
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }
}
