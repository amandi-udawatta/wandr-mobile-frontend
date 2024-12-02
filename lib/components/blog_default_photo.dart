import 'dart:io'; // Import for using File
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart'; // For picking an image

class BlogDefaultPhoto extends StatefulWidget {
  final String title;

  const BlogDefaultPhoto({Key? key, required this.title}) : super(key: key);

  @override
  _BlogDefaultPhotoState createState() => _BlogDefaultPhotoState();
}

class _BlogDefaultPhotoState extends State<BlogDefaultPhoto> {
  String _imagePath = 'assets/images/blogs/default.jpg'; // Default image path in assets

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imagePath = pickedFile.path; // Update the image path from the file system
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 3,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: _imagePath.startsWith('assets/')
              ? AssetImage(_imagePath) as ImageProvider // Use AssetImage for assets
              : FileImage(File(_imagePath)), // Use FileImage for file system path
          fit: BoxFit.cover,
          opacity: 0.9,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            bottom: 10,
            left: 20,
            child: Text(
              widget.title,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                fontSize: 24,
                color: Colors.white,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Positioned(
            bottom: 10,
            right: 10,
            child: FloatingActionButton(
              onPressed: _pickImage,
              backgroundColor: Colors.white,
              child: const Icon(
                Icons.photo_library,
                color: Color(0xFF437B17),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
