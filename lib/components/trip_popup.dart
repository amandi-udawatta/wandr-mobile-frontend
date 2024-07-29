import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wandr/theme/app_colors.dart';

class TripPopup extends StatefulWidget {
  final String backgroundImage;
  final List<String> created_trips;

  const TripPopup({
    Key? key,
    required this.backgroundImage,
    required this.created_trips,
  }) : super(key: key);

  @override
  _TripPopupState createState() => _TripPopupState();
}

class _TripPopupState extends State<TripPopup> {
  final TextEditingController _tripTitleController = TextEditingController();
  final Map<String, bool> _selectedTrips = {};

  @override
  void initState() {
    super.initState();
    widget.created_trips.forEach((trip) {
      _selectedTrips[trip] = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: IntrinsicHeight(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8, // Adjust width as needed
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Stack(
            children: [
              ColorFiltered(
                colorFilter: ColorFilter.mode(
                  Colors.white.withOpacity(0), // Adjust the opacity to control brightness
                  BlendMode.lighten,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(widget.backgroundImage),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
              Positioned.fill(
                child: Container(
                  color: Colors.black.withOpacity(0), // Slight overlay to make text more readable
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 16), // Space before the title
                    Text(
                      "Save trip to",
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Kcolours.brownShade4,
                      ),
                    ),
                    SizedBox(height: 10),
                    Flexible(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: widget.created_trips.map((created_trip) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 1.0), // Further reduced gap
                            child: Row(
                              children: [
                                Checkbox(
                                  value: _selectedTrips[created_trip],
                                  onChanged: (bool? value) {
                                    setState(() {
                                      _selectedTrips[created_trip] = value ?? false;
                                    });
                                  },
                                  activeColor: Kcolours.greenShade1, // Changed color to green
                                  visualDensity: VisualDensity.compact, // Reduced space around checkbox
                                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap, // Reduced tap target size
                                ),
                                Text(
                                  created_trip,
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    color: Kcolours.brownShade2,
                                  ),
                                ),
                              ],
                            ),
                          )).toList(),
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _tripTitleController,
                            decoration: InputDecoration(
                              hintText: "Enter trip title",
                              hintStyle: GoogleFonts.poppins(
                                color: Kcolours.brownShade2.withOpacity(0.5),
                              ),
                              border: InputBorder.none,
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black, width: 1.0),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black, width: 1.0),
                              ),
                            ),
                            style: GoogleFonts.poppins(
                              color: Kcolours.brownShade2,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.save, color: Kcolours.black),
                          onPressed: () {
                            // Implement save functionality
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                right: 0,  // Move to the right
                top: 0,    // Move up
                child: IconButton(
                  icon: Icon(Icons.close, color: Kcolours.black),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
