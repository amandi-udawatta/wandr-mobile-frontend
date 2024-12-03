import 'package:flutter/material.dart';
import 'package:wandr/theme/app_colors.dart';
import '../../components/primary_button.dart';
import 'main_shops_page.dart'; // Import MainShopsPage for navigation

class ServiceProfilePage extends StatefulWidget {
  final String serviceName;

  const ServiceProfilePage({Key? key, required this.serviceName}) : super(key: key);

  @override
  _ServiceProfilePageState createState() => _ServiceProfilePageState();
}

class _ServiceProfilePageState extends State<ServiceProfilePage> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    String fullText = "John, a passionate and ISA-certified surf instructor with over 10 years of experience teaching in Sri Lanka, has dedicated his life to sharing his love for surfing with others. He has taught hundreds of students of all ages and skill levels, helping them to develop their surfing abilities and ocean safety awareness. Whether you are a complete beginner or an advanced surfer looking to refine your technique, John's Surf Shack offers personalized lessons tailored to meet your needs. Join John in Arugam Bay for an unforgettable surfing experience!";

    List<String> words = fullText.split(' ');
    String firstPart = words.take(20).join(' ') + "... ";
    String secondPart = words.skip(20).join(' ');

    List<Map<String, String>> services = [
      {"title": "Beginner Surf Lessons", "description": "Learn the basics of surfing in a safe and controlled environment."},
      {"title": "Intermediate Surf Lessons", "description": "Improve your technique and tackle bigger waves."},
      {"title": "Advanced Surf Coaching", "description": "Refine your skills and take your surfing to the next level."},
      {"title": "Surfboard & Equipment Rentals", "description": "John offers a range of high-quality surfboards and equipment to suit all skill levels."},
    ];

    String location = "No.17, Beach Road, Arugam Bay";
    String langauges = "English, Sinhala";
    String website = "www.johnsurfshack.com";
    String contactus = "0778985678 / 0786543876";

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300.0,
            floating: false,
            pinned: true,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_new_outlined, size: 30, color: Colors.white,),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MainShopsPage()),
                );
              },
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    'assets/images/services/service-main-photos/1-johns-surf-shack.png',
                    fit: BoxFit.cover,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.black.withOpacity(0.6), Colors.transparent],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 16.0,
                    bottom: 16.0,
                    right: 16.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.serviceName,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4.0),
                        Row(
                          children: [
                            Icon(Icons.location_on, color: Colors.white, size: 16.0),
                            SizedBox(width: 4.0),
                            Text(
                              'Arugam Bay, Sri Lanka',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    right: 16.0,
                    bottom: 16.0,
                    child: Image.asset(
                      'assets/images/services/service-logos/1-logo-johns-surf-shack.png',
                      width: 60.0,
                      height: 60.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              color: Color(0xFF337102).withOpacity(0.1),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Text(
                      isExpanded ? fullText : firstPart,
                      style: TextStyle(fontSize: 16, color: Colors.black),
                      textAlign: TextAlign.justify,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          isExpanded = !isExpanded;
                        });
                      },
                      child: Row(
                        children: [
                          Text(
                            isExpanded ? 'Less' : 'More',
                            style: TextStyle(fontSize: 16, color: Kcolours.primary),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Services:",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 6),
                  for (var service in services) ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Transform.rotate(
                          angle: -0.5,
                          child: Icon(Icons.circle, size: 10, color: Kcolours.primary),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            "${service['title']}: ${service['description']}",
                            style: TextStyle(fontSize: 16, color: Colors.black),
                            textAlign: TextAlign.justify,
                            softWrap: true,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10), // Increased space between bullet points
                  ],
                  SizedBox(height: 12),
                  // Location Section
                  Row(
                    children: [
                      Text(
                        "Location: ",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Expanded(
                        child: Text(
                          location,
                          style: TextStyle(fontSize: 16, color: Colors.black),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  // Languages Section
                  Row(
                    children: [
                      Text(
                        "Languages: ",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Expanded(
                        child: Text(
                          langauges,
                          style: TextStyle(fontSize: 16, color: Colors.black),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  // Website Section
                  Row(
                    children: [
                      Text(
                        "Website: ",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Expanded(
                        child: Text(
                          website,
                          style: TextStyle(fontSize: 16, color: Kcolours.primary),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  // Contact Us Section
                  Row(
                    children: [
                      Text(
                        "Contact Us: ",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Expanded(
                        child: Text(
                          contactus,
                          style: TextStyle(fontSize: 16, color: Kcolours.black),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  PrimaryButton(
                    onTap: () {},
                    text: "Chat",
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
