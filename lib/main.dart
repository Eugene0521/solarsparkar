import 'package:flutter/material.dart';
import 'package:solarsparkar/pages/homescreen.dart';
import 'package:solarsparkar/pages/topics_page.dart';
import 'package:solarsparkar/pages/quiz_page.dart';
import 'package:solarsparkar/pages/profilepage.dart';
import 'package:solarsparkar/pages/ar.dart';
import 'package:solarsparkar/pages/leaderboard.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ARSolar App',
      theme: ThemeData(
        fontFamily: 'Sniglet',
        primarySwatch: Colors.deepPurple,
        scaffoldBackgroundColor: const Color(0xFF2B223E), // Global background color
        visualDensity: VisualDensity.adaptivePlatformDensity,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF2B223E), // AppBar background color
          titleTextStyle: TextStyle(
            color: Colors.white, // Title text color
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: IconThemeData(
            color: Colors.white, // Icon color
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(), // Initial screen before login
    );
  }
}

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  _NavigationScreenState createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int _currentIndex = 2; // Default to 'ProfilePage'

  // Pages for the navigation bar
  final List<Widget> _pages = [
    const TopicsPage(),
    const QuizPage(),
    const ProfilePage(),
    const ARPage(),
    const Leaderboard(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex], // Display the selected page
      bottomNavigationBar: CurvedNavigationBar(
        index: _currentIndex,
        backgroundColor: Colors.transparent,
        color: const Color.fromARGB(255, 232, 109, 61),
        buttonBackgroundColor: Colors.white,
        height: 60,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 600),
        items: const <Widget>[
          Icon(Icons.star, size: 30),
          Icon(Icons.quiz, size: 30),
          Icon(Icons.person, size: 30),
          Icon(Icons.public, size: 30),
          Icon(Icons.leaderboard, size: 30),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
