import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'planetdetail_page.dart';
import '../data/planet_data.dart'; // Import the list of Planet objects

class ARPage extends StatefulWidget {
  const ARPage({super.key});

  @override
  State<ARPage> createState() => _ARPageState();
}

class _ARPageState extends State<ARPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      automaticallyImplyLeading: false, // Removes the back button
        title: const Text('Solar Spark AR'),
      ),
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'assets/scene/material_emissive.png', // Replace with your background image path
              fit: BoxFit.cover, // Ensure the image covers the entire background
            ),
          ),
          // Main content
          Column(
            children: [
              Expanded(
                child: CarouselSlider.builder(
                  itemCount: planets.length, // Use the `planets` list from `planet_data.dart`
                  options: CarouselOptions(
                    height: 300,
                    enlargeCenterPage: true,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 3),
                  ),
                  itemBuilder: (context, index, realIndex) {
                    final planet = planets[index];
                    return GestureDetector(
                      onTap: () {
                        // Navigate to expanded view
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PlanetDetailPage(planet: planet), // Pass the Planet object
                          ),
                        );
                      },
                      child: Column(
                        children: [
                          Text(
                            planet.name.toUpperCase(), // Access the planet's name
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white, // Make text visible on background
                            ),
                          ),
                          SizedBox(
                            height: 200,
                            width: 200,
                            child: Image.asset(planet.imagePath), // Use the planet's image path
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
