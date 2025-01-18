import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditProfilePage extends StatefulWidget {
  final String? username;

  const EditProfilePage({super.key, this.username});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _usernameController.text = widget.username ?? '';
  }

  Future<void> _updateProfile() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      try {
        final docRef = FirebaseFirestore.instance.collection('users').doc(user.uid);
        final docSnapshot = await docRef.get();

        if (docSnapshot.exists) {
          // Update the username if the document exists
          await docRef.update({
            'username': _usernameController.text.trim(),
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Profile updated successfully!')),
          );
        } else {
          // Create the document if it does not exist
          await docRef.set({
            'username': _usernameController.text.trim(),
            'quizzes': {}, // Initialize with empty quizzes or default data
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Profile created successfully!')),
          );
        }
        Navigator.pop(context, true); // Pass 'true' to indicate success
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error updating profile: $e')),
        );
      }
    }

    // Update password if provided
    if (_passwordController.text.isNotEmpty) {
      try {
        await user?.updatePassword(_passwordController.text.trim());
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Password updated successfully!')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error updating password: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Username Field
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                labelText: 'Username',
                labelStyle: TextStyle(color: Colors.white), // Label color
              ),
              style: const TextStyle(color: Colors.white), // Input text color
            ),
            const SizedBox(height: 20),
            // Password Field
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'New Password',
                labelStyle: TextStyle(color: Colors.white), // Label color
              ),
              style: const TextStyle(color: Colors.white), // Input text color
            ),
            const SizedBox(height: 30),
            // Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, false); // Pass 'false' for no changes
                  },
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: _updateProfile,
                  child: const Text('Save'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
