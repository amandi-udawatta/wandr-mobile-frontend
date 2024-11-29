import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:wandr/components/bottom_nav_bar.dart';
import 'package:wandr/theme/app_colors.dart';
import 'package:wandr/components/places_card1.dart';
import 'package:wandr/components/description_card.dart';
import 'package:wandr/components/categories_button.dart';
import 'package:wandr/components/activity_card.dart';
import 'package:wandr/components/blog_card.dart';
import 'package:wandr/components/primary_button.dart';
import '../../config.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DestinationProfileGmap extends StatefulWidget {
  const DestinationProfileGmap({super.key});

  @override
  State<DestinationProfileGmap> createState() => _DestinationProfileGmapState();
}

class _DestinationProfileGmapState extends State<DestinationProfileGmap> {
  late GoogleMapController mapController;

  final LatLng _center = const LatLng(7.957113000000000, 80.760257000000000);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 11.0,
        ),
      ),

    );
  }
}