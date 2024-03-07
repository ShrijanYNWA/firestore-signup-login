import 'package:firebase/view/login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditProfilePage extends StatefulWidget {
  final User? user;

  EditProfilePage({required this.user, Map<String, dynamic>? userData});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  String? _name;
  String? _email;
  String? _phoneNumber;
  final CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection('users');

  @override
  void initState() {
    super.initState();
    _name = widget.user?.displayName;
    _email = widget.user?.email;
    _phoneNumber = widget.user?.phoneNumber;
  }

  Future<void> _updateProfile() async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        await user.updateProfile(displayName: _name, /*photoURL: null*/);

        // Check if email is not null before updating
        if (_email != null) {
          await user.updateEmail(_email!);
        }

        // Handle phone number updates separately
        // Note: You need to implement a secure way of updating phone numbers
        // and obtain the verificationId and smsCode
        // String verificationId = 'your_verification_id';
        // String smsCode = 'your_sms_code';
        // PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
        //   verificationId: verificationId,
        //   smsCode: smsCode,
        // );
        // await user.updatePhoneNumber(phoneAuthCredential);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Profile updated successfully')),
        );
      } catch (e) {
        // Print the error message for better debugging
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
        // Delete user document in Firestore
        await _usersCollection.doc(user.uid).delete();

        // Delete the user account
        await user.delete();

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Profile deleted successfully')),
        );

        // Navigate to login page after successful deletion
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => LoginUi()), // Replace with your login page
          (route) => false,
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Center(
                child: CircleAvatar(
                  backgroundImage: NetworkImage(widget.user?.photoURL ?? ""),
                  radius: 75,
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                initialValue: _name,
                decoration: InputDecoration(labelText: 'Name'),
                onChanged: (value) => _name = value,
              ),
              SizedBox(height: 10),
              // TextFormField(
              //   initialValue: _email,
              //   decoration: InputDecoration(labelText: 'Email'),
              //   onChanged: (value) => _email = value,
              // ),
              SizedBox(height: 10),
              TextFormField(
                initialValue: _phoneNumber,
                decoration: InputDecoration(labelText: 'Phone Number'),
                onChanged: (value) => _phoneNumber = value,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _updateProfile();
                  }
                },
                child: Text('Update Profile'),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  _deleteProfile();
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                ),
                child: Text('Delete Profile'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}