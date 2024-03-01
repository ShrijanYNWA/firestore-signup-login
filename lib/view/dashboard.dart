import 'package:carousel_slider/carousel_slider.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase/util/string_const.dart';
import 'package:firebase/view/carousel.dart';
import 'package:firebase/view/carpenter.dart';
import 'package:firebase/view/drawer.dart';
import 'package:firebase/view/plumber.dart';
import 'package:firebase/view/profile.dart';
import 'package:firebase/view/see_all.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'mainUI.dart';

class Dashboard extends StatefulWidget {
  Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  User? user;
  final List<String> imageUrl = [
    "asset/images/15%discount.jpg",
    "asset/images/Carpenter1.jpeg",
    "asset/images/water.jpg",
    "asset/images/clean.jpg",
    "asset/images/photography.jpg",
  ];

//  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  // int _selectedPage = 0;
  // final List<Widget> _pageOptions = [
  //   Dashboard(),
  //   Profile(),
  //   MainUi(),
  // ];

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
  }

  Widget build(BuildContext context) {
    return Scaffold(
// //bottomNavigationBar:

//  navbar(),
appBar: AppBar(

),
drawer: Mydrawer(),
      body: SafeArea(
        child: ui(),
      ),
    );
  }

  height(value, context) {
    return MediaQuery.of(context).size.height * value;
  }

  width(value, context) {
    return MediaQuery.of(context).size.width * value;
  }

  Widget ui() {
    return Stack(
      children: [
        
        Container(
          
          height: height(1, context),
          width: width(1, context),
          decoration: BoxDecoration(color: colorstr),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15.0, right: 15),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  //1st part
                  height: height(0.11, context),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                          backgroundColor: Colors.white,
                          child: GestureDetector(onTap: () =>
                          // Open the drawer when the button is pressed
              Scaffold.of(context).openDrawer(),
                            child: Icon(
                              FontAwesomeIcons.homeUser,
                              color: colorstr,
                              size: 25,
                            ),
                          )),
                      SizedBox(
                        width: width(0.04, context),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Welcome,",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 25),
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.waving_hand_outlined,
                                  color: Colors.orange[400],
                                  size: 20,
                                ),
                                SizedBox(
                                  width: width(0.02, context),
                                ),
                                Text(
                                    "${user?.displayName ?? 'User'}", //welcome wala part

                                    style: TextStyle(
                                        fontSize: 15, color: Colors.white))
                              ],
                            )
                          ],
                        ),
                      ),
                      Spacer(),
                      CircleAvatar(
                          backgroundColor: Colors.white,
                          child: InkWell(
                            child: Icon(FontAwesomeIcons.bell,
                                size: 25, color: colorstr),
                            onTap: () {
                              print("hehe");
                            },
                          ))
                    ],
                  ),
                ),
                Container(
                  color: Colors.transparent,
                  width: width(1, context),
                  height: height(0.20, context),
                  child: carousel(context), // carousel ya call vaxa
                ),
                SizedBox(
                  height: height(0.035, context),
                ),
                Container(
                  //3rd search wala
                  child: TextField(
                    cursorColor: colorstr,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.lime[50],
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.transparent, width: 3),
                            borderRadius: BorderRadius.circular(20)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 2.5, color: Colors.transparent),
                            borderRadius: BorderRadius.circular(20)),
                        prefixIcon: Icon(
                          Icons.location_on_outlined,
                          color: colorstr,
                        ),
                        hintText: "All Service Available",
                        hintStyle:
                            TextStyle(fontSize: 20, color: Colors.black38),
                        suffixIcon: IconButton(
                            onPressed: () {
                              print(" search button is pressed");
                            },
                            icon: Icon(
                              FontAwesomeIcons.search,
                              color: colorstr,
                            ))),
                  ),
                ),
                SizedBox(
                  height: height(0.015, context),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 4, right: 4),
                  child: Row(
                    children: [
                      Text(
                        "Categories",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      Spacer(),
                      GestureDetector(
                        child: Text("See All",
                            style: TextStyle(color: Colors.white)),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SeeAll(),
                              ));
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 15),
                  // 4th categories wala
                  height: height(0.34, context),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.transparent),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                child: Column(
                                  children: [
                                    CircleAvatar(
                                        backgroundColor: Colors.lightGreen[200],
                                        radius: 50,
                                        child: Image.asset(
                                          "asset/images/plumber.png",
                                          fit: BoxFit.cover,
                                          height: 50,
                                          width: 50,
                                        )),
                                    Text("Plumber",
                                        style: TextStyle(
                                            color: colorstr,
                                            fontWeight: FontWeight.w500))
                                  ],
                                ),
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => PlumberDetailsPage(),));
                                },
                              ),
                              GestureDetector(
                                child: Column(
                                  children: [
                                    CircleAvatar(
                                        backgroundColor: Colors.lightGreen[200],
                                        radius: 50,
                                        child: Image.asset(
                                          "asset/images/painter.png",
                                          fit: BoxFit.cover,
                                          height: 50,
                                          width: 50,
                                        )),
                                    Text("Painter",
                                        style: TextStyle(
                                            color: colorstr,
                                            fontWeight: FontWeight.w500))
                                  ],
                                ),
                                onTap: () {},
                              ),
                              GestureDetector(
                                child: Column(
                                  children: [
                                    CircleAvatar(
                                        backgroundColor: Colors.lightGreen[200],
                                        radius: 50,
                                        child: Image.asset(
                                          "asset/images/carpenter.png",
                                          fit: BoxFit.cover,
                                          height: 50,
                                          width: 50,
                                        )),
                                    Text("Carpenter",
                                        style: TextStyle(
                                            color: colorstr,
                                            fontWeight: FontWeight.w500))
                                  ],
                                ),
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => CarpenterDetailsPage(),));

                                },
                              ),
                            ],
                          ),
                          SizedBox(
                            height: height(0.015, context),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                child: Column(
                                  children: [
                                    CircleAvatar(
                                        backgroundColor: Colors.lightGreen[200],
                                        radius: 50,
                                        child: Image.asset(
                                          "asset/images/watertank.png",
                                          fit: BoxFit.cover,
                                          height: 50,
                                          width: 50,
                                        )),
                                    Text(
                                      "Water tanker",
                                      style: TextStyle(
                                          color: colorstr,
                                          fontWeight: FontWeight.w500),
                                    )
                                  ],
                                ),
                                onTap: () {},
                              ),
                              GestureDetector(
                                child: Column(
                                  children: [
                                    CircleAvatar(
                                        backgroundColor: Colors.lightGreen[200],
                                        radius: 50,
                                        child: Image.asset(
                                          "asset/images/mechanic.png",
                                          fit: BoxFit.cover,
                                          height: 50,
                                          width: 50,
                                        )),
                                    Text("Mechanics",
                                        style: TextStyle(
                                            color: colorstr,
                                            fontWeight: FontWeight.w500))
                                  ],
                                ),
                                onTap: () {},
                              ),
                              GestureDetector(
                                child: Column(
                                  children: [
                                    CircleAvatar(
                                        backgroundColor: Colors.lightGreen[200],
                                        radius: 50,
                                        child: Image.asset(
                                          "asset/images/cleaning.png",
                                          fit: BoxFit.cover,
                                          height: 50,
                                          width: 50,
                                        )),
                                    Text("Cleaning",
                                        style: TextStyle(
                                            color: colorstr,
                                            fontWeight: FontWeight.w500))
                                  ],
                                ),
                                onTap: () {},
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ]),
                ),
                SizedBox(
                  height: height(0.001, context),
                ),
                Container(
                  height: height(0.2, context),
                  color: Colors.red,
                ),
                SizedBox(
                  height: height(0.001, context),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
//   navbar(){
//     return  CurvedNavigationBar(

//       index: _selectedPage,
//       key: _bottomNavigationKey,
//       items: <Widget>[
//         Icon(Icons.home, size: 30),
//         Icon(Icons.list, size: 30),
//         Icon(Icons.compare_arrows, size: 30),
//       ],
//       onTap: (index) {
//         setState(() {
//           _selectedPage = index;
//           });
//         },
//       );
//   }
//    Widget getCurrentPage() {
//     return _pageOptions[_selectedPage];
//   }
  Widget carousel(context) {
    return CarouselSlider(
      options: CarouselOptions(
        autoPlay: true,
        height: MediaQuery.of(context).size.height * 0.2,
        scrollDirection: Axis.horizontal,
        enlargeCenterPage: true,
        autoPlayCurve: Curves.fastLinearToSlowEaseIn,
        enableInfiniteScroll: true,
      ),
      items: imageUrl.map(
        (imageurls) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                width: MediaQuery.of(context).size.width,
                //  margin: EdgeInsets.symmetric(horizontal: 5.0),

                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Image.asset(
                    imageurls,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          );
        },
      ).toList(),
    );
  }
  Widget drawer(){
  return Drawer(
     child: ListView(
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
          child: Text(
            'Welcome, ${user?.displayName ?? 'Guest'}!',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
        ),
        ListTile(
          leading: Icon(Icons.exit_to_app),
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
