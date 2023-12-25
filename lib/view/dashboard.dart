import 'package:firebase/util/string_const.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
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
                              child: Icon(
                                FontAwesomeIcons.homeUser,
                                color: colorstr,
                                size: 25,
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
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 25),
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
                                    Text("Shrijan",
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
                      width: width(1, context),
                      height: height(0.20, context),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(40),
                          child: Image.network(
                              "https://img.freepik.com/free-vector/abstract-fluid-neon-color-3d-effect-sale-background-banner-design-multipurpose_1340-16635.jpg?w=1380&t=st=1703429609~exp=1703430209~hmac=347cddb952d5aa74caf1b52cb4229a4aec34d5034283f31d5d42aa751e5f5512",
                              fit: BoxFit.cover)),
                    ),
                    SizedBox(
                      height: height(0.04, context),
                    ),
                    Container(
                      //3rd search wala
                      child: TextField(
                        cursorColor: colorstr,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.lime[50],
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.transparent, width: 3),
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
                      height: height(0.04, context),
                    ),
                    Container( // 4th categories wala
                    
                      decoration: BoxDecoration(
                      color: Colors.white,
                        
                        border:Border.all(color: Colors.transparent),borderRadius: BorderRadius.circular(10),),
                      child: Column(children: [
                        Padding(
                          padding: const EdgeInsets.only(left:8.0,right: 8),
                          child: Row(
                            children: [
                              Text("Categories",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: colorstr),), Spacer(),
                          InkWell(child: Text("See All",style: TextStyle(color: colorstr)
                          )
                          ),
                                              
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left:8.0,right: 8),
                          child: Column(
                            children: [
                              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                Column(
                                  children: [
                                    InkWell(onTap: () {
                                      
                                    },child: CircleAvatar(
                                      backgroundColor:  Colors.lightGreen[200],
                                    
                                      radius: 50,
                                      child: Image.network("https://cdn-icons-png.flaticon.com/128/10021/10021597.png?uid=R132046538&ga=GA1.1.127695204.1693306270&semt=ais",fit: BoxFit.cover,height: 50,width: 50,)
                                      )
                                      ),
                                      TextButton(onPressed: () {
                                        
                                      }, child: Text("Plumber"))
                                  ],
                                ),
                                  Column(
                                    children: [
                                      InkWell(onTap: () {
                                      
                                },child: CircleAvatar(
                                      backgroundColor:  Colors.lightGreen[200],
                                
                                      radius: 50,
                                      child: Image.network("https://cdn-icons-png.flaticon.com/128/10039/10039556.png?uid=R132046538&ga=GA1.1.127695204.1693306270&semt=ais",fit: BoxFit.cover,height: 50,width: 50,)
                                      )
                                      ),
                                       TextButton(onPressed: () {
                                        
                                      }, child: Text("Painter"))
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      InkWell(onTap: () {
                                      
                                },child: CircleAvatar(
                                      backgroundColor:  Colors.lightGreen[200],
                                
                                      radius: 50,
                                      child: Image.network("https://cdn-icons-png.flaticon.com/128/4445/4445605.png?uid=R132046538&ga=GA1.1.127695204.1693306270&semt=ais",fit: BoxFit.cover,height: 50,width: 50,)
                                      )
                                      ),
                                       TextButton(onPressed: () {
                                        
                                      }, child: Text("Carpenter"))
                                    ],
                                  ),
                              ],
                              ),
                              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                Column(
                                  children: [
                                    InkWell(onTap: () {
                                      
                                    },child: CircleAvatar(
                                      backgroundColor:  Colors.lightGreen[200],
                                    
                                      radius: 50,
                                      child: Image.network("https://cdn-icons-png.flaticon.com/128/9359/9359295.png?uid=R132046538&ga=GA1.1.127695204.1693306270&semt=ais",fit: BoxFit.cover,height: 60,width: 55,)
                                      )
                                      ),
                                      TextButton(onPressed: () {
                                        
                                      }, child: Text("Water tanker"))
                                  ],
                                ),
                                  Column(
                                    children: [
                                      InkWell(onTap: () {
                                      
                                },child: CircleAvatar(
                                      backgroundColor:  Colors.lightGreen[200],
                                
                                      radius: 50,
                                      child: Image.network("https://cdn-icons-png.flaticon.com/128/9817/9817792.png?uid=R132046538&ga=GA1.1.127695204.1693306270&semt=ais",fit: BoxFit.cover,height: 50,width: 50,)
                                      )
                                      ),
                                       TextButton(onPressed: () {
                                        
                                      }, child: Text("Mechanics"))
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      InkWell(onTap: () {
                                      
                                },child: CircleAvatar(
                                      backgroundColor:  Colors.lightGreen[200],
                                
                                      radius: 50,
                                      child: Image.network("https://cdn-icons-png.flaticon.com/128/2800/2800410.png?uid=R132046538&ga=GA1.1.127695204.1693306270&semt=ais",fit: BoxFit.cover,height: 50,width: 50,)
                                      )
                                      ),
                                       TextButton(onPressed: () {
                                        
                                      }, child: Text("Cleaning"))
                                    ],
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
        ),
      ),
    );
  }

  height(value, context) {
    return MediaQuery.of(context).size.height * value;
  }

  width(value, context) {
    return MediaQuery.of(context).size.width * value;
  }
}
