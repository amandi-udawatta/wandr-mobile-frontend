import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:google_fonts/google_fonts.dart';
import 'package:wandr/components/blog_default_photo.dart';

class BlogWritingPage extends StatefulWidget {
  final String title;

  const BlogWritingPage({Key? key, required this.title}) : super(key: key);

  @override
  _BlogWritingPageState createState() => _BlogWritingPageState();
}

class _BlogWritingPageState extends State<BlogWritingPage> {
  late quill.QuillController _controller;
  List<Map<String, dynamic>> destinations = [
    {
      'name': 'Destination 1',
      'description': 'This is a description for Destination 1',
    },
    {
      'name': 'Destination 2',
      'description': 'This is a description for Destination 2',
    },
    {
      'name': 'Destination 3',
      'description': 'This is a description for Destination 3',
    },
  ];

  @override
  void initState() {
    super.initState();
    _controller = quill.QuillController.basic();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _saveContent(int index) {
    final doc = _controller.document.toDelta();
    print("Saved Content for ${destinations[index]['name']}: ${doc.toJson()}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Write About ${widget.title}",
          style: GoogleFonts.poppins(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              final doc = _controller.document.toDelta();
              print("Saved Content: ${doc.toJson()}");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlogDefaultPhoto(title: widget.title),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 5),
                  
                  // Loop through each destination and add an editor for it
                  for (int i = 0; i < destinations.length; i++) ...[
                    ExpansionTile(
                      title: Text(
                        destinations[i]['name'],
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              quill.QuillSimpleToolbar(
                                controller: _controller,
                                configurations:
                                    const quill.QuillSimpleToolbarConfigurations(),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                height: 200, // Adjust height for the editor
                                child: quill.QuillEditor.basic(
                                  controller: _controller,
                                  configurations:
                                      const quill.QuillEditorConfigurations(),
                                ),
                              ),
                              const SizedBox(height: 16),

                              // Save button for each editor
                              ElevatedButton(
                                onPressed: () => _saveContent(i),
                                child: const Text('Save Description'),
                              ),
                              const SizedBox(height: 16),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
