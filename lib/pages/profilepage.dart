import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'editprofile_page.dart';
import 'login_page.dart'; // Import your existing login page

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? _username;
  Map<String, dynamic>? _quizzes;

  final User? user = FirebaseAuth.instance.currentUser;

  final List<String> allQuizzes = [
    'Solar System Quiz (3rd Grade)',
    'Solar System Quiz (4th Grade)',
    'Solar System Quiz (6th Grade)',
    'Solar Eclipse (5th - 6th Grade)',
  ];

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    if (user != null) {
      try {
        final docRef = FirebaseFirestore.instance.collection('users').doc(user!.uid);
        final doc = await docRef.get();

        if (doc.exists) {
          setState(() {
            _username = doc.data()?['username'] ?? 'Unknown User';
            _quizzes = doc.data()?['quizzes'] as Map<String, dynamic>? ?? {};
          });
        } else {
          // If the document doesn't exist, create it with default values
          await docRef.set({
            'username': '',
            'quizzes': {},
          });
          setState(() {
            _username = '';
            _quizzes = {};
          });
        }
      } catch (e) {
        print('Error fetching user data: $e');
      }
    }
  }

  Future<void> _logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()), // Navigate to login page
      );
    } catch (e) {
      print('Error logging out: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error logging out: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        automaticallyImplyLeading: false, // Removes the back button
        actions: [
          TextButton(
            onPressed: _logout,
            child: const Text(
              'Logout',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      _username != null && _username!.isNotEmpty
                          ? _username!
                          : 'Please update your username',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // Changed username color to white
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      user?.email ?? 'No Email Provided',
                      style: const TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () async {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditProfilePage(
                              username: _username,
                            ),
                          ),
                        );
                        if (result == true) {
                          _loadUserData(); // Refresh username if updated
                        }
                      },
                      child: const Text('Edit My Profile'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Quizzes Progress',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFEC5B20), // Changed text color to 0xFFEC5B20
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: allQuizzes.length,
                itemBuilder: (context, index) {
                  final quizName = allQuizzes[index];
                  final quizData = _quizzes?[quizName];
                  final bool isCompleted = quizData != null && quizData['highestScore'] > 0;

                  return Card(
                    color: isCompleted ? Colors.green[100] : Colors.orange[100],
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      title: Text(
                        quizName,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        isCompleted
                            ? 'Highest Score: ${quizData['highestScore']} / ${quizData['totalQuestions']}'
                            : 'Status: Pending',
                        style: TextStyle(
                          color: isCompleted ? Colors.green : Colors.orange,
                        ),
                      ),
                      trailing: isCompleted
                          ? const Icon(Icons.check_circle, color: Colors.green)
                          : const Icon(Icons.hourglass_bottom, color: Colors.orange),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
