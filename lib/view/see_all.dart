import 'package:firebase/util/string_const.dart';
import 'package:firebase/view/plumber.dart';
import 'package:flutter/material.dart';

class SeeAll extends StatelessWidget {
  const SeeAll({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
appBar: AppBar(
  title: Text("Categories",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 28)),
  backgroundColor: colorstr,

),
body: Stack(
  children: [
    Container(
      color: colorstr,
     // height:
    ),
    GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => PlumberDetailsPage(),)),
      child: Container(
                    padding: EdgeInsets.only(top: 15),
                    // 4th categories wala
                    height:height(0.5, context),
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
                                Column(
                                  children: [
                                    CircleAvatar(
                                        backgroundColor:
                                            Colors.lightGreen[200],
                                        radius: 50,
                                        child: Image.asset("asset/images/plumber.png",
                                                                                      fit: BoxFit.cover,
                                          height: 50,
                                          width: 50,
                                        )),
                                    Text("Plumber",style: TextStyle(color: colorstr,fontWeight: FontWeight.w500))
                                  ],
                                ),
                                Column(
                                  children: [
                                    CircleAvatar(
                                        backgroundColor:
                                            Colors.lightGreen[200],
                                        radius: 50,
                                        child: Image.asset("asset/images/painter.png",
                                          fit: BoxFit.cover,
                                          height: 50,
                                          width: 50,
                                        )),
                                    Text("Painter",style: TextStyle(color: colorstr,fontWeight: FontWeight.w500))
                                  ],
                                ),
                                Column(
                                  children: [
                                    CircleAvatar(
                                        backgroundColor:
                                            Colors.lightGreen[200],
                                        radius: 50,
                                        child: Image.asset("asset/images/carpenter.png",
                                          fit: BoxFit.cover,
                                          height: 50,
                                          width: 50,
                                        )),
                                    Text("Carpenter",style: TextStyle(color: colorstr,fontWeight: FontWeight.w500))
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: height(0.015, context),),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    CircleAvatar(
                                        backgroundColor:
                                            Colors.lightGreen[200],
                                        radius: 50,
                                        child: Image.asset("asset/images/watertank.png",
                                          fit: BoxFit.cover,
                                          height: 50,
                                          width: 50,
                                        )),
                                    Text("Water tanker",style: TextStyle(color: colorstr,fontWeight: FontWeight.w500),)
                                  ],
                                ),
                                Column(
                                  children: [
                                    CircleAvatar(
                                        backgroundColor:
                                            Colors.lightGreen[200],
                                        radius: 50,
                                        child: Image.asset("asset/images/mechanic.png",
                                         
                                          fit: BoxFit.cover,
                                          height: 50,
                                          width: 50,
                                        )),
                                    Text("Mechanics",style: TextStyle(color: colorstr,fontWeight: FontWeight.w500))
                                  ],
                                ),
                                Column(
                                  children: [
                                    CircleAvatar(
                                        backgroundColor:
                                            Colors.lightGreen[200],
                                        radius: 50,
                                        child: Image.asset("asset/images/cleaning.png",
                                          fit: BoxFit.cover,
                                          height: 50,
                                          width: 50,
                                        )),
                                    Text("Cleaning",style: TextStyle(color: colorstr,fontWeight: FontWeight.w500))
                                  ],
                                ),
                                
                              ],
                            ),
                            SizedBox(height: height(0.015, context),),
                            Row(
                              children: [
                               Column(
                                 children: [
                                   CircleAvatar(
                                       backgroundColor:
                                           Colors.lightGreen[200],
                                       radius: 50,
                                       child: Image.asset("asset/images/painter.png",
                                         fit: BoxFit.cover,
                                         height: 50,
                                         width: 50,
                                       )),
                                   Text("Painter",style: TextStyle(color: colorstr,fontWeight: FontWeight.w500))
                                 ],
                               ),
                                 Padding(
                                   padding: const EdgeInsets.only(left:50),
                                   child: GestureDetector(
                                    child: Column(
                                      children: [
                                        Align(
                                          child: CircleAvatar(
                                              backgroundColor:
                                                  Colors.lightGreen[200],
                                              radius: 50,
                                              child: Image.asset("asset/images/photographyicon.png",
                                                fit: BoxFit.cover,
                                                height: 50,
                                                width: 50,
                                              )),
                                        ),
                                        Text("Photography",style: TextStyle(color: colorstr,fontWeight: FontWeight.w500))
                                      ],
                                    ),
                                    onTap: () {
                                      
                                    },
                                    
                                                               ),
                                 ),
    
                                
                          
                            ],)
                          ],
                        ),
                      )
                    ]),
                  ),
    ),
  ],
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