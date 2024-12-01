import 'dart:convert';
import 'dart:ffi';

import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:wandr/config.dart';
import 'package:wandr/pages/rewards/rewards_page.dart';
import 'package:wandr/pages/trip/generate_trip_recs.dart';
import 'package:wandr/pages/trip/trip_main.dart';
import 'package:wandr/theme/app_colors.dart';
import '../../components/bottom_nav_bar.dart';
import 'package:wandr/components/places_card1.dart';
import 'package:wandr/components/trip_recommended_item.dart';
import 'package:wandr/components/trip_recommended_service.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async'; // Needed for the Completer
import 'package:google_places_flutter/google_places_flutter.dart';

import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';



class PendingTripPage extends StatefulWidget {
  final String title;
  final String createdOn;
  final List<dynamic> tripPlaces;
  final int tripId;
  final int? routeType;

  const PendingTripPage({
    Key? key,
    required this.title,
    required this.createdOn,
    required this.tripPlaces,
    required this.tripId,
    this.routeType,
  }) : super(key: key);

  @override
  _PendingTripPageState createState() => _PendingTripPageState();
}

class _PendingTripPageState extends State<PendingTripPage> {
  final FlutterSecureStorage _storage = FlutterSecureStorage();
  bool _isConfirmEnabled() {
    return _startLocation != null && _endLocation != null && widget.tripPlaces.isNotEmpty;
  }

  final Completer<GoogleMapController> _controller = Completer();

  // Estimated Details from the API response
  int? _time; // Selected time based on routeType
  int? _estimatedTime; // Selected estimated time
  int? _distance; // Selected distance based on routeType

  final List<Map<String, dynamic>> _sampleLocations = [
    {
      'id': 1,
      'name': 'Sigiriya Lion Rock',
      'latitude': 7.957113000000000,
      'longitude': 80.760257000000000,
    },
    {
      'id': 2,
      'name': 'Temple of the Sacred Tooth Relic',
      'latitude': 7.293609000000000,
      'longitude': 80.641325000000000,
    },
    {
      'id': 3,
      'name': 'Pasikuda Beach',
      'latitude': 8.569559000000000,
      'longitude': 81.213307000000000,
    },
  ];

  // Variables to store estimated time and distance
  String _totalDistance = "N/A";

  // Example function to simulate updating estimates
  // void _updateEstimates() {
  //   // Simulate fetching estimates (replace this with real calculations/API response)
  //   setState(() {
  //     _estimatedTime = "2 hrs 30 mins"; // Replace with real estimate
  //     _totalDistance = "120 km"; // Replace with real distance
  //   });
  // }

  // Dropdown selection state
  int? _selectedOption; // 1 = Custom Route, 2 = Optimized Route
  bool get _isReorderEnabled => _selectedOption == 2;
  final List<Map<String, dynamic>> _dropdownOptions = [
    {"id": 1, "name": "Optimized Route (Shortest Path)"},
    {"id": 2, "name": "Custom Route (Your Selection)"},
  ];

  // Controllers for start and end location autocomplete
  final TextEditingController _startLocationController = TextEditingController();
  final TextEditingController _endLocationController = TextEditingController();

  // Selected latitude and longitude for start and end locations
  LatLng? _startLocation;
  LatLng? _endLocation;


  @override
  void initState() {
    super.initState();
    // print("HELLOOOOOOO");
    // print('Trip Places Received: ${widget.tripPlaces}');
    _selectedOption = widget.routeType ?? 2;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fitMarkersToMap();
    });
  }
  Future<void> _fitMarkersToMap() async {
    if (_sampleLocations.isEmpty) return;

    LatLngBounds bounds;
    if (_sampleLocations.length == 1) {
      // Only one marker
      final LatLng singleMarker = LatLng(
        _sampleLocations.first['latitude'],
        _sampleLocations.first['longitude'],
      );
      bounds = LatLngBounds(
        southwest: singleMarker,
        northeast: singleMarker,
      );
    } else {
      // Multiple markers: calculate bounds
      bounds = LatLngBounds(
        southwest: LatLng(
          _sampleLocations.map((place) => place['latitude']).reduce((a, b) => a < b ? a : b),
          _sampleLocations.map((place) => place['longitude']).reduce((a, b) => a < b ? a : b),
        ),
        northeast: LatLng(
          _sampleLocations.map((place) => place['latitude']).reduce((a, b) => a > b ? a : b),
          _sampleLocations.map((place) => place['longitude']).reduce((a, b) => a > b ? a : b),
        ),
      );
    }

    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newLatLngBounds(bounds, 50));
  }

  Future<void> _onConfirmDestinations() async {
    if (_selectedOption == null || _startLocation == null || _endLocation == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all required fields.")),
      );
      return;
    }

    try {
      String? token = await _storage.read(key: 'accessToken');
      if (token != null) {
        Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
        final userId = decodedToken['id'];
        final url = _selectedOption == 2
            ? Uri.parse('$baseUrl/forward/trip/reorder-route') // Custom Route
            : Uri.parse('$baseUrl/forward/trip/shortest-route'); // Optimized Route


        final payload = _selectedOption == 2
            ? {
          "tripId": widget.tripId,
          "startLat": _startLocation!.latitude,
          "startLng": _startLocation!.longitude,
          "endLat": _endLocation!.latitude,
          "endLng": _endLocation!.longitude,
          "placeList": widget.tripPlaces.map((place) {
            return {
              "tripPlaceId": place['tripPlaceId'], // Ensure this is populated
              "order": place['placeOrder'],
            };
          }).toList(),
        }
            : {
          "tripId": widget.tripId,
          "startLat": _startLocation!.latitude,
          "startLng": _startLocation!.longitude,
          "endLat": _endLocation!.latitude,
          "endLng": _endLocation!.longitude,
        };

        // print("The payload is: $payload");

        final response = await http.post(
          url,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': token,},
          body: jsonEncode(payload),
        );

        // print("the POST request is: $url");
        // print("Payload sent to server: ${jsonEncode(payload)}");
        // print("Response status code: ${response.statusCode}");
        print("Raw response body: ${response.body}");

        if (response.statusCode == 200) {
          final responseData = jsonDecode(response.body);

          // Check if the response indicates success
          if (responseData['success'] == true) {
            final data = responseData['data'];

            setState(() {
              if (_selectedOption == 1) {
                // Optimized Route
                _time = int.tryParse(data['optimizedTime'].toString());
                _estimatedTime = int.tryParse(data['estimatedOptimizedTime'].toString());
                _distance = int.tryParse(data['optimizedDistance'].toString());
              } else if (_selectedOption == 2) {
                // Custom Route
                _time = int.tryParse(data['orderedTime'].toString());
                _estimatedTime = int.tryParse(data['estimatedOrderedTime'].toString());
                _distance = int.tryParse(data['orderedDistance'].toString());
              }
            });

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Route confirmed successfully!")),
            );
          } else {
            throw Exception("Failed: ${responseData['message']}");
          }
        } else {
          throw Exception("API Error: ${response.statusCode}");
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${e.toString()}")),
      );
    }
  }

  /// Helper function to format time in seconds to "hours and minutes"
  String formatTime(int seconds) {
    final hours = seconds ~/ 3600;
    final minutes = (seconds % 3600) ~/ 60;
    return '${hours}h ${minutes}m';
  }

  /// Helper function to format distance in meters to "kilometers"
  String formatDistance(int meters) {
    final km = meters / 1000;
    return '${km.toStringAsFixed(2)} km';
  }


  // ADD MORE FUNCTIONS HERE

  @override
  Widget build(BuildContext context) {
    // print('Trip Places in PendingTripPage: ${widget.tripPlaces}');
    // Define a common padding value
    const EdgeInsets commonPadding = EdgeInsets.symmetric(horizontal: 10.0);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_outlined,
            size: 30,
          ),
          onPressed: () {
            Navigator.pop(context); // Use pop to go back to the previous screen
          },
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.title, style: TextStyle(color: Kcolours.black)),
            Text(
              widget.createdOn,
              style: TextStyle(
                fontSize: 12,
                color: Kcolours.greyShade1,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: commonPadding,
                child: Text(
                  "Select Your Route",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Kcolours.primary,
                  ),
                ),
              ),
              Padding(
                padding: commonPadding,
                child: Text(
                  "Choose an option to calculate the estimated time for your trip",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: commonPadding,
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                    border: Border.all(color: Kcolours.primary, width: 1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<int>(
                      isExpanded: true,
                      value: _selectedOption, // Dynamically set the value
                      hint: Text("Select an option"),
                      items: _dropdownOptions.map((option) {
                        return DropdownMenuItem<int>(
                          value: option['id'],
                          child: Text(option['name']),
                        );
                      }).toList(),
                      onChanged: (value) async {
                        if (value == null) return;

                        setState(() {
                          _selectedOption = value;
                        });

                        if (value == 1) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Reordering is disabled for Optimized Route."),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ),
              ),

              SizedBox(height: 25),

              Padding(
                padding: commonPadding,
                child: Text(
                  "Your Current Destination List",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Kcolours.primary,
                  ),
                ),
              ),
              Padding(
                padding: commonPadding,
                child: Text(
                  "Drag the places to adjust the order",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                  ),
                ),
              ),
              SizedBox(height: 10),
              // Destinations list
              ReorderableListView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                onReorder: (oldIndex, newIndex) {
                  if (!_isReorderEnabled) return; // Do nothing if reordering is disabled

                  setState(() {
                    if (newIndex > oldIndex) newIndex -= 1;
                    final item = widget.tripPlaces.removeAt(oldIndex);
                    widget.tripPlaces.insert(newIndex, item);

                    // Update the order values in the tripPlaces
                    for (int i = 0; i < widget.tripPlaces.length; i++) {
                      widget.tripPlaces[i]['placeOrder'] = i + 1;
                    }
                  });
                },
                children: widget.tripPlaces.map((destination) {
                  return Card(
                    key: ValueKey(destination['placeOrder']),
                    color: Colors.grey[200],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading: Icon(Icons.menu, color: Kcolours.black),
                      title: Text(destination['title'] ?? 'No Title'),
                      trailing: IconButton(
                        icon: Icon(Icons.delete_outline, color: Colors.red),
                        onPressed: () {
                          setState(() {
                            widget.tripPlaces.remove(destination);
                          });
                        },
                      ),
                    ),
                  );
                }).toList(),
              ),


              SizedBox(height: 16),

              Padding(
                padding: commonPadding,
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RewardsPage(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Kcolours.primary, // Background color
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: Text(
                          'Generate My Recommendations',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 16),


              Padding(
                padding: commonPadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Start Location Input
                    Text(
                      "Where are you going to start your trip from?",
                      textAlign: TextAlign.left,
                      style: TextStyle(color: Colors.grey, fontSize: 15),
                    ),
                    Stack(
                      children: [
                        GooglePlaceAutoCompleteTextField(
                          textEditingController: _startLocationController,
                          googleAPIKey: "AIzaSyCkHD2HerXhpZkLcYALU2Cm6BuP2sxOAWY",
                          inputDecoration: InputDecoration(
                            hintText: "Enter Start Location",
                            hintStyle: TextStyle(color: Colors.grey[600]),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Kcolours.primary, width: 1.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Kcolours.primary, width: 1.0),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 16.0,
                              vertical: 14.0,
                            ),
                          ),
                          debounceTime: 800,
                          countries: const ["lk", "us"],
                          isLatLngRequired: true,
                          itemClick: (prediction) async {
                            if (prediction != null && prediction.placeId != null) {
                              try {
                                var response = await http.get(
                                  Uri.parse(
                                    'https://maps.googleapis.com/maps/api/place/details/json?place_id=${prediction.placeId}&key=AIzaSyCkHD2HerXhpZkLcYALU2Cm6BuP2sxOAWY',
                                  ),
                                );
                                if (response.statusCode == 200) {
                                  var result = jsonDecode(response.body);
                                  var location = result['result']['geometry']['location'];
                                  setState(() {
                                    _startLocation = LatLng(location['lat'], location['lng']);
                                    _startLocationController.text =
                                        prediction.description ?? "Unknown Place";
                                  });
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text("Failed to fetch start location details.")),
                                  );
                                }
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("Error retrieving start location.")),
                                );
                              }
                            }
                          },
                        ),
                        Positioned(
                          right: 0,
                          top: 0,
                          child: IconButton(
                            icon: Icon(Icons.clear, color: Colors.red),
                            onPressed: () {
                              setState(() {
                                _startLocation = null;
                                _startLocationController.clear();
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),

              // End Location Input
              Padding(
                padding: commonPadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Where do you want to end your trip?",
                      textAlign: TextAlign.left,
                      style: TextStyle(color: Colors.grey, fontSize: 15),
                    ),
                    Stack(
                      children: [
                        GooglePlaceAutoCompleteTextField(
                          textEditingController: _endLocationController,
                          googleAPIKey: "AIzaSyCkHD2HerXhpZkLcYALU2Cm6BuP2sxOAWY",
                          inputDecoration: InputDecoration(
                            hintText: "Enter End Location",
                            hintStyle: TextStyle(color: Colors.grey[600]),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Kcolours.primary, width: 1.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Kcolours.primary, width: 1.0),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 16.0,
                              vertical: 14.0,
                            ),
                          ),
                          debounceTime: 800,
                          countries: const ["lk", "us"],
                          isLatLngRequired: true,
                          itemClick: (prediction) async {
                            if (prediction != null && prediction.placeId != null) {
                              try {
                                var response = await http.get(
                                  Uri.parse(
                                    'https://maps.googleapis.com/maps/api/place/details/json?place_id=${prediction.placeId}&key=AIzaSyCkHD2HerXhpZkLcYALU2Cm6BuP2sxOAWY',
                                  ),
                                );
                                if (response.statusCode == 200) {
                                  var result = jsonDecode(response.body);
                                  var location = result['result']['geometry']['location'];
                                  setState(() {
                                    _endLocation = LatLng(location['lat'], location['lng']);
                                    _endLocationController.text =
                                        prediction.description ?? "Unknown Place";
                                  });
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text("Failed to fetch end location details.")),
                                  );
                                }
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("Error retrieving end location.")),
                                );
                              }
                            }
                          },
                        ),
                        Positioned(
                          right: 0,
                          top: 0,
                          child: IconButton(
                            icon: Icon(Icons.clear, color: Colors.red),
                            onPressed: () {
                              setState(() {
                                _endLocation = null;
                                _endLocationController.clear();
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),



              SizedBox(height: 16),

              Padding(
                padding: commonPadding,
                child: Text(
                  "Add the start and end locations and click here to confirm your destination details and generate your estimated trip details",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                  ),
                ),
              ),

              SizedBox(height: 10),

              // Confirm Destinations Button
              Padding(
                padding: commonPadding,
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        // onPressed: _isConfirmEnabled()
                        //     ? () {
                        //   ScaffoldMessenger.of(context).showSnackBar(
                        //     SnackBar(content: Text("Destinations confirmed!")),
                        //   );
                        // }
                        //     : null,
                        onPressed: _selectedOption != null && _startLocation != null && _endLocation != null
                            ? _onConfirmDestinations
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _isConfirmEnabled()
                              ? Kcolours.primary
                              : Colors.grey[400],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: Text(
                          'Confirm Destinations',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),


              SizedBox(height: 15),

              // Estimated Details Section
              Padding(
                padding: commonPadding,
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Kcolours.primary, width: 1),
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Estimated Details",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: Kcolours.primary,
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Time:",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: Kcolours.brownShade4,
                            ),
                          ),
                          Text(
                            _time != null ? formatTime(_time!) : "N/A",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: Kcolours.black,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Estimated Time:",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: Kcolours.brownShade4,
                            ),
                          ),
                          Text(
                            _estimatedTime != null ? formatTime(_estimatedTime!) : "N/A",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: Kcolours.black,
                            ),
                          ),
                        ],
                      ),

                  SizedBox(height: 8),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Distance:",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: Kcolours.brownShade4,
                        ),
                      ),
                      Text(
                        _distance != null ? formatDistance(_distance!) : "N/A",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: Kcolours.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
              ),




              SizedBox(height: 15),

              // GOOGLE MAPS
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Container(
                  height: 500,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Kcolours.white,
                      width: 1,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: GoogleMap(
                      onMapCreated: (GoogleMapController controller) {
                        _controller.complete(controller);
                      },
                      initialCameraPosition: CameraPosition(
                        target: LatLng(
                          _sampleLocations.first['latitude'],
                          _sampleLocations.first['longitude'],
                        ),
                        zoom: 10, // Default zoom level
                      ),
                      markers: _sampleLocations.map((place) {
                        return Marker(
                          markerId: MarkerId(place['id'].toString()),
                          position: LatLng(place['latitude'], place['longitude']),
                          infoWindow: InfoWindow(
                            title: place['name'],
                          ),
                        );
                      }).toSet(),
                      mapType: MapType.normal,
                      scrollGesturesEnabled: true,
                      zoomGesturesEnabled: true,
                      tiltGesturesEnabled: true,
                      rotateGesturesEnabled: true,
                    ),
                  ),
                ),
              ),


              SizedBox(height: 15),

              // Recommended services based on your preferences
              Padding(
                padding: commonPadding,
                child: Text(
                  "Recommended shops and services to enhance your trip",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Kcolours.brownShade4,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: commonPadding,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      ServiceCard(
                        title: "Cane Laundry Basket",
                        store: "Rattan Wonders",
                        rating: 3.1,
                        image: "assets/images/shops/item-cane-laundry-basket.png",
                      ),
                      SizedBox(width: 16),
                      ServiceCard(
                        title: "Handwoven Baskets",
                        store: "Rattan Wonders",
                        rating: 3.1,
                        image: "assets/images/shops/item-handwoven-baskets.png",
                      ),
                      SizedBox(width: 16),
                      ServiceCard(
                        title: "Rattan Round Serving Tray",
                        store: "Rattan Wonders",
                        rating: 3.1,
                        image: "assets/images/shops/item-rattan-round-serving-tray.png",
                      ),
                      SizedBox(width: 16),
                      ServiceCard(
                        title: "Shopping Basket",
                        store: "Rattan Wonders",
                        rating: 3.1,
                        image: "assets/images/shops/item-shopping-basket.png",
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 15),

              Padding(
                padding: commonPadding,
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          // Handle Finalize Trip action here
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Kcolours.primary, // Background color
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: Text(
                          'Finalize Trip',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
