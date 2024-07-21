import 'package:flutter/material.dart';
import 'package:wandr/components/bottom_nav_bar.dart';
import 'package:wandr/components/description_card2.dart';
import 'package:wandr/components/edit_button.dart';
import 'package:wandr/components/journal_text.dart';

class JournalScreen extends StatelessWidget {
  final String title;
  final String createdOn;
  final String image;

  const JournalScreen({
    Key? key,
    required this.title,
    required this.createdOn,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  DescriptionCard2(
                    title: title,
                    image: image,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 12, bottom: 6),
                      child: EditButton(
                        onTap: () {
                          // Add functionality for the EditButton here
                        },
                      ),
                    ),
                  ),
                ],
              ),
              JournalText(
                title: 'Kandy to Arugam Bay: A Coastal Escape',
                text: 'The crisp mountain air of Kandy lingers on my skin as I bid farewell to the Temple of the Tooth and embark on my journey to the sun-kissed shores of Arugam Bay. A scenic train ride awaits, snaking its way through the verdant hills of Sri Lanka.',
              ),
              JournalText(
                title: 'Dambulla',
                text: 'Our first stop is the majestic Dambulla Cave Temple. Stepping into these ancient caverns adorned with vibrant frescoes, I feel transported back centuries. The sheer scale of the Buddha statues and intricate paintings leave me awestruck. As the afternoon sun bathes the surrounding landscape in a golden glow, I capture the moment in my journal.',
                image: 'assets/images/trip/Journal1.png',
              ),
              JournalText(
                title: 'Sigiriya',
                text: 'Refreshed and invigorated, we head towards Sigiriya, the legendary Lion Rock. The climb is a challenge, but the panoramic views from the summit are simply breathtaking. Gazing across the sprawling landscape dotted with ancient reservoirs, I can almost visualize the grandeur of the kingdom that once thrived here.',
                image: 'assets/images/trip/Journal2.png',
              ),
              JournalText(
                title: 'Habarana',
                text: 'The next leg of our journey takes us to Habarana, a haven for wildlife enthusiasts. We embark on a thrilling jeep safari through Minneriya National Park, spotting herds of majestic elephants, playful monkeys swinging through the trees, and a myriad of colorful birds. The raw beauty of the wilderness leaves me feeling humbled and grateful for the natural world.',
                image: 'assets/images/trip/Journal3.png',
              ),
              JournalText(
                title: 'Batticaloa',
                text: 'As we travel further east, Batticaloa unfolds its unique charm. The Dutch Fort, a historic landmark, stands as a testament to the region\'s rich past. Wandering through vibrant markets and exploring colorful Hindu temples, I experience a delightful blend of cultures and traditions. The aroma of spices and exotic fruits fills the air, a sensory feast that I capture in my journal with a few sketches.',
              ),
              JournalText(
                title: 'Arugam Bay',
                text: 'Finally, the journey reaches its culmination. Arugam Bay welcomes me with open arms – a surfer\'s paradise with endless stretches of golden sand and turquoise waves. The laid-back atmosphere and breathtaking beauty instantly captivate me. As the sun dips below the horizon, casting fiery hues across the sky, I know this is a place where memories are made and stories are written. This is just the beginning of my adventure in Arugam Bay. Stay tuned for more entries as I explore the hidden coves, learn to surf the waves, and delve deeper into the local culture!',
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavBar(),
      ),
    );
  }
}
