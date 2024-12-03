import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wandr/components/places_card1.dart';
import 'package:wandr/config.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class GetRecommendationsPage extends StatefulWidget {
  final int tripId; // Trip ID passed from PendingTripPage

  const GetRecommendationsPage({Key? key, required this.tripId}) : super(key: key);

  @override
  State<GetRecommendationsPage> createState() => _GetRecommendationsPageState();
}

class _GetRecommendationsPageState extends State<GetRecommendationsPage> {
  late Future<List<Map<String, dynamic>>> _recommendations; // Future to fetch recommendations
  // static const String baseUrl = 'http://localhost:8081/api/proxy/forward';

  // Fetch recommended places data from API
  Future<List<Map<String, dynamic>>> fetchRecommendations() async {
    print(widget.tripId);
    final url = Uri.parse('$baseUrl/forward/trip/recommended-places/${widget.tripId}');
    print("URL is: $url");

    try {
      final response = await http.get(url);
      print("THE RESPONSE IS: $response");
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData['success']) {
          final List<dynamic> data = responseData['data'];
          print("Response Data is: $data");
          return data.map<Map<String, dynamic>>((place) {
            // Construct the full image URL for the PlacesCard1
            final imageUrl = place['image'] != null
                ? 'http://68.183.94.54:5080/places/${place['image']}'
                : null;

            return {
              'id': place['id'],
              'name': place['name'],
              'description': place['description'],
              'latitude': place['latitude'],
              'longitude': place['longitude'],
              'address': place['address'],
              'image': imageUrl,
              'categories': place['categories'] ?? [],
              'activities': place['activities'] ?? [],
              'liked': place['liked'] ?? false,
              'rating': place['rating'] ?? 0,
            };
          }).toList();
        } else {
          throw Exception(responseData['message']);
        }
      } else {
        throw Exception('Failed to fetch recommendations. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching recommendations: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _recommendations = fetchRecommendations();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trip Recommendations'),
        backgroundColor: Colors.white,
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _recommendations,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('No recommendations available.'),
            );
          } else {
            final recommendations = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Number of columns
                  childAspectRatio: 0.75, // Aspect ratio for card sizing
                  crossAxisSpacing: 16, // Space between columns
                  mainAxisSpacing: 16, // Space between rows
                ),
                itemCount: recommendations.length,
                itemBuilder: (context, index) {
                  final place = recommendations[index];
                  return PlacesCard1(
                    title: place['name'],
                    location: place['address'],
                    image: place['image'],
                    isLiked: place['liked'],
                    onTap: () {
                      // Add navigation logic to view place details, if needed
                      print('Tapped on: ${place['name']}');
                    },
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
