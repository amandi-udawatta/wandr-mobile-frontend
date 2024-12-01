import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wandr/theme/app_colors.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GenerateTripRecs extends StatefulWidget {
  final int tripId;

  const GenerateTripRecs({Key? key, required this.tripId}) : super(key: key);

  @override
  _GenerateTripRecsState createState() => _GenerateTripRecsState();
}

class _GenerateTripRecsState extends State<GenerateTripRecs> {
  List<dynamic> recommendedPlaces = [];
  bool isLoading = true;
  bool hasError = false;

  @override
  void initState() {
    super.initState();
    fetchRecommendedPlaces();
  }

  /// Fetch recommended places from the backend
  Future<void> fetchRecommendedPlaces() async {
    try {
      final response = await http.get(
        Uri.parse(
            'http://localhost:8081/api/proxy/forward/trip/recommended-places/${widget.tripId}'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success']) {
          setState(() {
            recommendedPlaces = data['data'];
            isLoading = false;
          });
        } else {
          setState(() {
            hasError = true;
            isLoading = false;
          });
        }
      } else {
        setState(() {
          hasError = true;
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        hasError = true;
        isLoading = false;
      });
    }
  }

  /// Generate a widget for each card
  Widget _buildRecommendationCard(dynamic place) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: InkWell(
        onTap: () {
          // Handle card tap (e.g., navigate to place details page)
        },
        child: Row(
          children: [
            // Image Section
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                'http://localhost:8081/images/${place['image']}',
                height: 100,
                width: 100,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 100,
                    width: 100,
                    color: Colors.grey[300],
                    child: Icon(Icons.image, size: 50, color: Colors.grey[600]),
                  );
                },
              ),
            ),

            // Info Section
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      place['name'],
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Kcolours.black,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      place['address'],
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: Kcolours.greyShade1,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.star, size: 16, color: Colors.orange),
                        const SizedBox(width: 4),
                        Text(
                          "${place['rating'].toStringAsFixed(1)}",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: Kcolours.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Your Recommendations",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            color: Kcolours.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Kcolours.black),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator(color: Kcolours.primary))
          : hasError
          ? Center(
        child: Text(
          "Failed to load recommendations. Please try again.",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w500,
            fontSize: 16,
            color: Colors.red,
          ),
        ),
      )
          : recommendedPlaces.isEmpty
          ? Center(
        child: Text(
          "No recommendations available for this trip.",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w500,
            fontSize: 16,
            color: Kcolours.greyShade1,
          ),
        ),
      )
          : ListView.builder(
        itemCount: recommendedPlaces.length,
        itemBuilder: (context, index) {
          return _buildRecommendationCard(recommendedPlaces[index]);
        },
      ),
    );
  }
}