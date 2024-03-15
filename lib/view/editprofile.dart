import 'package:firebase/util/string_const.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'login.dart';
import 'profile.dart';

class EditProfilePage extends StatefulWidget {
  final User? user;
  final Map<String, dynamic>? userData;

  EditProfilePage({required this.user, this.userData});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();

  String? _name;
  String? _email;
  String? _contact;
  String? _address;

  final CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection('users');

  @override
  void initState() {
    super.initState();
    _name = widget.user?.displayName;
    _email = widget.user?.email;
    _contact = widget.user?.phoneNumber;
    _address = widget.userData != null ? widget.userData!['address'] as String? ?? '' : '';
  }

  Future<void> _updateProfile() async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        await user.updateProfile(displayName: _name);

        if (_email != null) {
          await user.updateEmail(_email!);
        }

        await _usersCollection.doc(user.uid).update({
          'name': _name,
          'email': _email,
          'contact': _contact,
          'address': _address,
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Profile updated successfully')),
        );

        Navigator.pop(
          context,
          MaterialPageRoute(builder: (context) => ProfilePage()), // Pass user here
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error updating profile: $e')),
        );
      }
    }
  }

  Future<void> _deleteProfile() async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        await _usersCollection.doc(user.uid).delete();
        await user.delete();

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Profile deleted successfully')),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginUi()),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error deleting profile: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
        backgroundColor:colorstr,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundImage: user?.photoURL != null &&
                            user!.photoURL!.isNotEmpty
                        ? NetworkImage(user.photoURL!)
                        : NetworkImage(
                            'https://t3.ftcdn.net/jpg/02/43/12/34/360_F_243123463_zTooub557xEWABDLk0jJklDyLSGl2jrr.jpg'), // Provide a placeholder image URL
                    radius: 75,
                ),
                SizedBox(height: 20),
                buildProfileField("Name", _name, (value) => _name = value),
                buildProfileField("Email", _email, (value) => _email = value),
                buildProfileField("Contact", _contact, (value) => _contact = value),
                buildProfileField("Address", _address, (value) => _address = value),
                SizedBox(height: 20),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _updateProfile();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        primary:colorstr,
                      ),
                      child: Text('Update Profile',style: TextStyle(color: Colors.white),),
                    ),
                    Spacer(),
ElevatedButton(
                  onPressed: () {
                    _deleteProfile();
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                    onPrimary: Colors.white
                  ),
                  child: Text('Delete Profile'),
                ),

                  ],
                ),
                SizedBox(height: 10),
                
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildProfileField(String label, String? value, ValueChanged<String?> onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        initialValue: value,
        onChanged: onChanged,
        style: TextStyle(fontSize: 18),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(fontSize: 16, color:colorstr),
          border: OutlineInputBorder(
            borderSide: BorderSide(color:colorstr),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color:colorstr, width: 2),
          ),
        ),
      ),
    );
  }
}
