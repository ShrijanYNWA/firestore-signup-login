import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'editprofile.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Map<String, dynamic>? userData;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      try {
        if (user.providerData.isNotEmpty && user.providerData[0].providerId == 'google.com') {
          // If the user signed in with Google, use Google provider data
          userData = {
            'name': user.displayName ?? 'N/A',
            'email': user.email ?? 'N/A',
            'contact': 'N/A', // Add Google-specific data as needed
            'address': 'N/A', // Add Google-specific data as needed
            'photoUrl': user.photoURL ?? '', // Set photoUrl for both Google and email/password login
          };

          // Store Google user data in Firestore
          await FirebaseFirestore.instance.collection('users').doc(user.uid).set(userData!);
        } else {
          // If the user signed in with email/password, fetch data from Firestore
          DocumentSnapshot<Map<String, dynamic>> snapshot =
              await FirebaseFirestore.instance.collection('users').doc(user.uid).get();

          if (snapshot.exists) {
            userData = snapshot.data();
            // Ensure that the 'photoUrl' field is set, even if it's empty
            userData!['photoUrl'] ??= '';
          }
        }

        setState(() {});
      } catch (error) {
        print('Error fetching user profile data: $error');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (user != null)
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 50.0),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(user.photoURL ?? ""),
                    radius: 75,
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Center(child: Text("Profile Details", style: TextStyle(fontSize: 30))),
            ),
            SizedBox(height: 20),
            buildProfileField("Name:", userData?['name'] ?? 'N/A'),
            buildProfileField("Email:", userData?['email'] ?? 'N/A'),
            buildProfileField("Phone:", userData?['contact'] ?? 'N/A'),
            buildProfileField("Address:", userData?['address'] ?? 'N/A'),

            
            ElevatedButton(
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditProfilePage(user: user),
                  ),
                ).then((_) {
                  // Update user data after returning from the EditProfilePage
                  fetchUserData();
                });
              },
              child: Text('Edit Profile'),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildProfileField(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(value, style: TextStyle(fontSize: 20)),
            ),
            foregroundDecoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.circular(10),
            ),
            width: MediaQuery.of(context).size.width * 0.95,
            height: MediaQuery.of(context).size.height * 0.055,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(width: 1),
              color: Colors.white30,
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
