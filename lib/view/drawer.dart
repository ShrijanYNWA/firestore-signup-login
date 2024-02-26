import 'package:firebase/util/string_const.dart';
import 'package:firebase/view/navbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class Mydrawer extends StatefulWidget {
  Mydrawer({super.key});

  @override
  State<Mydrawer> createState() => _MydrawerState();
}

class _MydrawerState extends State<Mydrawer> {
  User? user;

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
  }

  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(user?.photoURL ?? ""),
                    radius: 50,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Welcome, ${user?.displayName ?? 'Guest'}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.home,size: 23,),
              title: Text("Home"),
              onTap: () => Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Navbar(),
                  ),
                  (route) => false),
            ),
            ListTile(
              leading: Icon(
                FontAwesomeIcons.circleExclamation,
                size: 20,
              ),
              title: Text("About Us"),
              //   onTap: () =>
              //   Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => ,), (route) => false),
            ),
            ListTile(
  leading: Icon(Icons.phone,size: 20,),
  title: Text('Contact Us'),
  onTap: () {
        launch('tel:+9779860899605');
                Navigator.pop(context); // Close the drawer

  },
),
            ListTile(
              leading: Icon(
                FontAwesomeIcons.signOutAlt,
                size: 20,
              ),
              title: Text('Logout'),
              onTap: () {
                FirebaseAuth.instance.signOut();
                Navigator.pop(context);
              },
            ),
          ],
        ),
      );
    
  }
 
}
