import 'dart:convert';
import 'dart:ffi';

import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:wandr/config.dart';
import 'package:wandr/pages/rewards/rewards_page.dart';
import 'package:wandr/pages/trip/finalized_trip_page.dart';
import 'package:wandr/pages/trip/generate_trip_recs.dart';
import 'package:wandr/pages/trip/get_recommendations_page.dart';
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
  final LatLng? startLocation; // Start location latitude and longitude
  final LatLng? endLocation; // End location latitude and longitude
  final int? orderedTime;
  final int? optimizedTime;
  final int? orderedDistance;
  final int? optimizedDistance;
  final int? estimatedOrderedTime;
  final int? estimatedOptimizedTime;

  const PendingTripPage({
    Key? key,
    required this.title,
    required this.createdOn,
    required this.tripPlaces,
    required this.tripId,
    this.routeType,
    this.startLocation,
    this.endLocation,
    this.orderedTime,
    this.optimizedTime,
    this.orderedDistance,
    this.optimizedDistance,
    this.estimatedOrderedTime,
    this.estimatedOptimizedTime,
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

  Set<Polyline> _polylines = {};



  @override
  void initState() {
    super.initState();
    // print("HELLOOOOOOO");
    // print('Trip Places Received: ${widget.tripPlaces}');
    _selectedOption = widget.routeType ?? 2;
    _startLocation = widget.startLocation;
    _endLocation = widget.endLocation;

    print('Trip Places received in PendingTripPage: ${widget.tripPlaces}');
    print('Estimated Time: $_time');
    print('Estimated Distance: $_distance');
    print('Estimated Total Time: $_estimatedTime');

    // Set values based on route type
    if (widget.routeType == 1) {
      // Optimized Route
      _time = widget.optimizedTime ?? 0;
      _distance = widget.optimizedDistance ?? 0;
      _estimatedTime = widget.estimatedOptimizedTime ?? 0;
    } else if (widget.routeType == 2) {
      // Custom Route
      _time = widget.orderedTime ?? 0;
      _distance = widget.orderedDistance ?? 0;
      _estimatedTime = widget.estimatedOrderedTime ?? 0;
    }

    // Pre-fill text controllers
    if (_startLocation != null) {
      _getPlaceDescription(_startLocation!).then((description) {
        if (description != null) {
          setState(() {
            _startLocationController.text = description;
          });
        }
      });
    }

    if (_endLocation != null) {
      _getPlaceDescription(_endLocation!).then((description) {
        if (description != null) {
          setState(() {
            _endLocationController.text = description;
          });
        }
      });
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fitMarkersToMap();
      _fetchDetailedRoute();
    });
  }
  Future<void> _fitMarkersToMap() async {
    if (widget.tripPlaces.isEmpty && _startLocation == null && _endLocation == null) return;

    LatLngBounds bounds;

    // Create a list of all locations (start, end, and destinations)
    List<LatLng> allLocations = [
      if (_startLocation != null) _startLocation!,
      if (_endLocation != null) _endLocation!,
      ...widget.tripPlaces
          .where((place) => place['latitude'] != null && place['longitude'] != null)
          .map((place) => LatLng(place['latitude'], place['longitude'])),
    ];

    if (allLocations.isEmpty) return;

    if (allLocations.length == 1) {
      bounds = LatLngBounds(
        southwest: allLocations.first,
        northeast: allLocations.first,
      );
    } else {
      bounds = LatLngBounds(
        southwest: LatLng(
          allLocations.map((loc) => loc.latitude).reduce((a, b) => a < b ? a : b),
          allLocations.map((loc) => loc.longitude).reduce((a, b) => a < b ? a : b),
        ),
        northeast: LatLng(
          allLocations.map((loc) => loc.latitude).reduce((a, b) => a > b ? a : b),
          allLocations.map((loc) => loc.longitude).reduce((a, b) => a > b ? a : b),
        ),
      );
    }

    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newLatLngBounds(bounds, 50));
  }

  Set<Marker> _buildMarkers() {
    Set<Marker> markers = {};

    // Add Start Location Marker
    if (_startLocation != null) {
      markers.add(Marker(
        markerId: MarkerId('start'),
        position: _startLocation!,
        infoWindow: InfoWindow(title: "Start Location"),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
      ));
    } else {
      print("Warning: Start location is null.");
    }

    // Add End Location Marker
    if (_endLocation != null) {
      markers.add(Marker(
        markerId: MarkerId('end'),
        position: _endLocation!,
        infoWindow: InfoWindow(title: "End Location"),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      ));
    } else {
      print("Warning: End location is null.");
    }

    // Add Destination Markers
    for (var place in widget.tripPlaces) {
      final double? lat = place['latitude'] as double?;
      final double? lng = place['longitude'] as double?;

      if (lat != null && lng != null) {
        final LatLng position = LatLng(lat, lng);
        markers.add(Marker(
          markerId: MarkerId('destination-${place['tripPlaceId']}'),
          position: position,
          infoWindow: InfoWindow(title: place['title']),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        ));
      } else {
        print("Warning: Skipping marker for place with missing latitude/longitude. Place: $place");
      }
    }

    return markers;
  }

  // void _generateRoute() {
  //   // Ensure locations are valid and in order
  //   final orderKey = widget.routeType == 1 ? 'optimizedOrder' : 'placeOrder';
  //   List<LatLng> routePoints = [
  //     if (_startLocation != null) _startLocation!,
  //     ...widget.tripPlaces
  //         .where((place) => place['latitude'] != null && place['longitude'] != null)
  //         .toList()
  //       ..sort((a, b) => (a[orderKey] ?? 0).compareTo(b[orderKey] ?? 0))
  //           .map((place) => LatLng(place['latitude'], place['longitude'])),
  //     if (_endLocation != null) _endLocation!,
  //   ];
  //
  //   // Create a polyline with the route points
  //   setState(() {
  //     _polylines = {
  //       Polyline(
  //         polylineId: const PolylineId('route'),
  //         points: routePoints,
  //         color: Colors.blue, // Polyline color
  //         width: 5, // Polyline width
  //       ),
  //     };
  //   });
  // }

  Future<void> _fetchDetailedRoute() async {
    if (_startLocation == null || _endLocation == null || widget.tripPlaces.isEmpty) return;

    // Use routeType to determine the sorting key
    final orderKey = _selectedOption == 1 ? 'optimizedOrder' : 'placeOrder';

    // Sort the tripPlaces based on the selected orderKey
    List<Map<String, dynamic>> sortedPlaces = widget.tripPlaces
        .cast<Map<String, dynamic>>()
        .toList()
      ..sort((a, b) => (a[orderKey] ?? 0).compareTo(b[orderKey] ?? 0));

    // Build the waypoints string
    String waypoints = sortedPlaces
        .where((place) => place['latitude'] != null && place['longitude'] != null)
        .map((place) => '${place['latitude']},${place['longitude']}')
        .join('|');

    // Construct the Google Directions API URL
    String url = 'https://maps.googleapis.com/maps/api/directions/json?'
        'origin=${_startLocation!.latitude},${_startLocation!.longitude}'
        '&destination=${_endLocation!.latitude},${_endLocation!.longitude}'
        '&waypoints=$waypoints'
        '&key=AIzaSyCkHD2HerXhpZkLcYALU2Cm6BuP2sxOAWY';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['routes'] != null && data['routes'].isNotEmpty) {
          String encodedPolyline = data['routes'][0]['overview_polyline']['points'];
          List<LatLng> points = _decodePolyline(encodedPolyline);

          // Update the polylines on the map
          setState(() {
            _polylines = {
              Polyline(
                polylineId: const PolylineId('detailed_route'),
                points: points,
                color: Colors.blueAccent,
                width: 3,
              ),
            };
          });
        } else {
          print("No routes found in the API response.");
        }
      } else {
        print("Failed to fetch route: ${response.body}");
      }
    } catch (e) {
      print("Error fetching route: $e");
    }
  }

  List<LatLng> _decodePolyline(String encoded) {
    List<LatLng> points = [];
    int index = 0, len = encoded.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int b, shift = 0, result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1F) << shift;
        shift += 5;
      } while (b >= 0x20);

      int dlat = (result & 1) != 0 ? ~(result >> 1) : (result >> 1);
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1F) << shift;
        shift += 5;
      } while (b >= 0x20);

      int dlng = (result & 1) != 0 ? ~(result >> 1) : (result >> 1);
      lng += dlng;

      points.add(LatLng(lat / 1E5, lng / 1E5));
    }

    print("Decoded ${points.length} points from polyline."); // Debugging log
    return points;
  }


  Future<String?> _getPlaceDescription(LatLng location) async {
    final url = 'https://maps.googleapis.com/maps/api/geocode/json?'
        'latlng=${location.latitude},${location.longitude}&key=AIzaSyCkHD2HerXhpZkLcYALU2Cm6BuP2sxOAWY';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['results'] != null && data['results'].isNotEmpty) {
          return data['results'][0]['formatted_address'];
        }
      }
    } catch (e) {
      print('Error fetching place description: $e');
    }
    return null;
  }

  List<Map<String, dynamic>> _getSortedTripPlaces() {
    if (widget.tripPlaces.isEmpty) {
      return [];
    }

    final orderKey = _selectedOption == 1 ? 'optimizedOrder' : 'placeOrder';

    return widget.tripPlaces
        .cast<Map<String, dynamic>>()
        .toList()
      ..sort((a, b) => (a[orderKey] ?? 0).compareTo(b[orderKey] ?? 0));
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
        final url = _selectedOption == 2
            ? Uri.parse('$baseUrl/forward/trip/reorder-route') // Custom Route
            : Uri.parse('$baseUrl/forward/trip/shortest-route'); // Optimized Route

        // Prepare the payload for the API request
        final payload = _selectedOption == 2
            ? {
          "tripId": widget.tripId,
          "startLat": _startLocation!.latitude,
          "startLng": _startLocation!.longitude,
          "endLat": _endLocation!.latitude,
          "endLng": _endLocation!.longitude,
          "placeList": widget.tripPlaces.map((place) {
            return {
              "tripPlaceId": place['tripPlaceId'],
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

        final response = await http.post(
          url,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': token,
          },
          body: jsonEncode(payload),
        );

        if (response.statusCode == 200) {
          final responseData = jsonDecode(response.body);

          if (responseData['success'] == true) {
            final data = responseData['data'];

            // Update trip metrics (time and distance)
            setState(() {
              _time = _selectedOption == 1 ? data['optimizedTime'] : data['orderedTime'];
              _distance = _selectedOption == 1 ? data['optimizedDistance'] : data['orderedDistance'];
              _estimatedTime = _selectedOption == 1
                  ? data['estimatedOptimizedTime']
                  : data['estimatedOrderedTime'];
            });

            // Optionally reorder trip places locally
            setState(() {
              final orderKey = _selectedOption == 1 ? 'optimizedOrder' : 'placeOrder';
              widget.tripPlaces.sort((a, b) => (a[orderKey] ?? 0).compareTo(b[orderKey] ?? 0));
            });

            // Update map route
            await _fetchDetailedRoute();

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
  /// Helper function to format time in seconds to "days, hours, and minutes" or just "hours and minutes"
  String formatTime(int seconds) {
    final int days = seconds ~/ 86400; // Calculate days
    final int hours = (seconds % 86400) ~/ 3600; // Remaining hours after removing days
    final int minutes = (seconds % 3600) ~/ 60; // Remaining minutes after removing hours

    if (days > 0) {
      // Display in "X days Y hours Z minutes"
      return '${days}d ${hours}h ${minutes}m';
    } else {
      // Display in "X hours Y minutes"
      return '${hours}h ${minutes}m';
    }
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
                      value: _selectedOption,
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

                        // Refresh the map based on the new routeType
                        await _fetchDetailedRoute();

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
              // Inside ReorderableListView
              ReorderableListView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                onReorder: (oldIndex, newIndex) {
                  if (!_isReorderEnabled) return;

                  setState(() {
                    if (newIndex > oldIndex) newIndex -= 1;
                    final item = widget.tripPlaces.removeAt(oldIndex);
                    widget.tripPlaces.insert(newIndex, item);

                    // Update the order values in the tripPlaces
                    for (int i = 0; i < widget.tripPlaces.length; i++) {
                      widget.tripPlaces[i]['placeOrder'] = i + 1;
                    }

                    _fetchDetailedRoute(); // Update the map after reordering
                  });
                },
                children: _getSortedTripPlaces().map((destination) {
                  final orderKey = _selectedOption == 1 ? 'optimizedOrder' : 'placeOrder'; // Use the selected route type
                  return Card(
                    key: ValueKey(destination[orderKey]),
                    color: Colors.grey[200],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading: Icon(
                        Icons.menu,
                        color: _isReorderEnabled ? Kcolours.black : Colors.grey,
                      ),
                      title: Text(destination['title'] ?? 'No Title'),
                      trailing: _isReorderEnabled
                          ? IconButton(
                        icon: Icon(Icons.delete_outline, color: Colors.red),
                        onPressed: () {
                          setState(() {
                            widget.tripPlaces.remove(destination);
                          });
                        },
                      )
                          : null, // Hide delete button for Optimized Route
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
                          backgroundColor: Kcolours.white, // Background color
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.add, size: 18),
                          ],
                      ),
                    ),
                    )],
                ),
              ),

          Padding(
                padding: commonPadding,
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => GetRecommendationsPage(
                          //       tripId: widget.tripId,
                          //     ),
                          //   ),
                          // );
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
                            _time != null && _time! > 0 ? formatTime(_time!) : "N/A",
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
                            _estimatedTime != null && _estimatedTime! > 0
                                ? formatTime(_estimatedTime!)
                                : "N/A",
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
                            _distance != null && _distance! > 0
                                ? formatDistance(_distance!)
                                : "N/A",
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
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      child: AbsorbPointer(
                        absorbing: false,
                        child: GoogleMap(
                          onMapCreated: (GoogleMapController controller) {
                            _controller.complete(controller);
                          },
                          initialCameraPosition: CameraPosition(
                            target: _startLocation ?? LatLng(0, 0),
                            zoom: 10,
                          ),
                          markers: _buildMarkers(),
                          polylines: _polylines, // Dynamically updated polylines
                          mapType: MapType.normal,
                          scrollGesturesEnabled: true,
                          zoomGesturesEnabled: true,
                          tiltGesturesEnabled: true,
                          rotateGesturesEnabled: true,
                        ),

                      ),
                    ),
                  )

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
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => RewardsPage(),
                          //   ),
                          // );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Kcolours.primary, // Background color
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: Text(
                          'Start Trip',
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
