import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../util/string_const.dart';
import 'editprofile.dart';

class ProfilePage extends StatelessWidget {
  Future<void> _updateProfileInFirebase(User user) async {
    try {
      await saveUserProfileToFirebase(
        user.uid,
        user.displayName ?? 'N/A',
        user.email ?? 'N/A',
        user.photoURL ?? '',
      );
    } catch (error) {
      print('Error updating user profile in Firebase: $error');
    }
  }

  Future<void> saveUserProfileToFirebase(
    String userId, String displayName, String email, String photoURL) async {
    try {
      final CollectionReference<Map<String, dynamic>> usersCollection =
          FirebaseFirestore.instance.collection('users');

      await usersCollection.doc(userId).set({
        'displayName': displayName,
        'email': email,
        'photoURL': photoURL,
        // Add other profile details as needed
      });
    } catch (error) {
      print('Error saving user profile to Firebase: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorstr,
        title: Text(
          "Profile",
          style: TextStyle(color: Colors.white, fontSize: 30),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (user != null)
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 50.0),
                  child: 
                  
                  CircleAvatar(
  backgroundImage: NetworkImage(user.photoURL ?? ""),
  radius: 75,
 // onBackgroundImageError: (exception, stackTrace) {
   // print("Error loading image: $exception");
    // return Icon(Icons.error); // Placeholder or error indicator
  //},
),
                ),
              ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Center(child: Text("Profile Details", style: TextStyle(fontSize: 30))),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text("Name:", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("${user?.displayName ?? 'N/A'}", style: TextStyle(fontSize: 20)),
              ),
              foregroundDecoration: BoxDecoration(color: Colors.black12, borderRadius: BorderRadius.circular(10)),
              width: MediaQuery.of(context).size.width * 0.95,
              height: MediaQuery.of(context).size.height * 0.055,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), border: Border.all(width: 1), color: Colors.white30),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text("Email:", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("${user?.email ?? 'N/A'}", style: TextStyle(fontSize: 20)),
              ),
              foregroundDecoration: BoxDecoration(color: Colors.black12, borderRadius: BorderRadius.circular(10)),
              width: MediaQuery.of(context).size.width * 0.95,
              height: MediaQuery.of(context).size.height * 0.055,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), border: Border.all(width: 1), color: Colors.white30),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text("Phone :", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("${user?.phoneNumber ?? "Not set"}", style: TextStyle(fontSize: 20)),
              ),
              foregroundDecoration: BoxDecoration(color: Colors.black12, borderRadius: BorderRadius.circular(10)),
              width: MediaQuery.of(context).size.width * 0.95,
              height: MediaQuery.of(context).size.height * 0.055,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), border: Border.all(width: 1), color: Colors.white30),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditProfilePage(user: FirebaseAuth.instance.currentUser!),
                  ),
                ).then((_) {
                  User? updatedUser = FirebaseAuth.instance.currentUser;
                  if (updatedUser != null) {
                    _updateProfileInFirebase(updatedUser);
                  }
                });
              },
              child: Text('Edit Profile'),
            ),
          ],
        ),
      ),
    );
  }
}
