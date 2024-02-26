// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class UserProfile {
//   final String uid;
//   final String displayName;
//   final String email;
//   final String photoURL;

//   UserProfile({
//     required this.uid,
//     required this.displayName,
//     required this.email,
//     required this.photoURL,
//   });
// }

// class AuthService {
//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   Future<User?> signUpWithEmailAndPassword(String email, String password) async {
//     try {
//       UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
//         email: email,
//         password: password,
//       );

//       return userCredential.user;
//     } catch (e) {
//       print("Error during user signup: $e");
//       return null;
//     }
//   }

//   Future<User?> signInWithGoogle() async {
//     try {
//       final GoogleSignIn googleSignIn = GoogleSignIn();
//       final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

//       if (googleSignInAccount != null) {
//         final GoogleSignInAuthentication googleSignInAuthentication =
//             await googleSignInAccount.authentication;

//         final AuthCredential credential = GoogleAuthProvider.credential(
//           accessToken: googleSignInAuthentication.accessToken,
//           idToken: googleSignInAuthentication.idToken,
//         );

//         final UserCredential userCredential =
//             await _auth.signInWithCredential(credential);

//         return userCredential.user;
//       }

//       return null;
//     } catch (e) {
//       print("Error during Google Sign-In: $e");
//       return null;
//     }
//   }

//   Future<void> saveUserDataToFirestore(User? user) async {
//     if (user != null) {
//       try {
//         await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
//           'uid': user.uid,
//           'displayName': user.displayName,
//           'email': user.email,
//           'photoURL': user.photoURL,
//         });
//       } catch (e) {
//         print("Error saving user data to Firestore: $e");
//       }
//     }
//   }
// }

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: MyHomePage(),
//     );
//   }
// }

// class MyHomePage extends StatelessWidget {
//   final AuthService _authService = AuthService();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Flutter Firebase Auth Example'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ElevatedButton(
//               onPressed: () async {
//                 User? user = await _authService.signInWithGoogle();
//                 if (user != null) {
//                   await _authService.saveUserDataToFirestore(user);
//                   Navigator.pushReplacement(
//                     context,
//                     MaterialPageRoute(builder: (context) => ProfileScreen(user.uid)),
//                   );
//                 }
//               },
//               child: Text('Sign In with Google'),
//             ),
//             SizedBox(height: 20),
//             Text('OR'),
//             SizedBox(height: 20),
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 children: [
//                   TextField(
//                     controller: _emailController,
//                     decoration: InputDecoration(labelText: 'Email'),
//                   ),
//                   TextField(
//                     controller: _passwordController,
//                     decoration: InputDecoration(labelText: 'Password'),
//                     obscureText: true,
//                   ),
//                   SizedBox(height: 20),
//                   ElevatedButton(
//                     onPressed: () async {
//                       String email = _emailController.text;
//                       String password = _passwordController.text;

//                       User? user = await _authService.signUpWithEmailAndPassword(email, password);

//                       if (user != null) {
//                         await _authService.saveUserDataToFirestore(user);
//                         Navigator.pushReplacement(
//                           context,
//                           MaterialPageRoute(builder: (context) => ProfileScreen(user.uid)),
//                         );
//                       }
//                     },
//                     child: Text('Sign Up'),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class ProfileScreen extends StatelessWidget {
//   final String userId;

//   ProfileScreen(this.userId);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('User Profile'),
//       ),
//       body: FutureBuilder(
//         future: FirebaseFirestore.instance.collection('users').doc(userId).get(),
//         builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return CircularProgressIndicator();
//           }

//           if (snapshot.hasError) {
//             return Text('Error: ${snapshot.error}');
//           }

//           if (snapshot.hasData && snapshot.data!.exists) {
//             var userData = snapshot.data!.data() as Map<String, dynamic>;
//             return Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text('Name: ${userData['displayName']}'),
//                 Text('Email: ${userData['email']}'),
//                 Text('Profile Picture: ${userData['photoURL']}'),
//               ],
//             );
//           } else {
//             return Text('User not found');
//           }
//         },
//       ),
//     );
//   }
// }
