//import 'package:firebase/view/plumber.dart';
//import 'package:firebase/view/plumberDetailsScreen.dart';
import 'package:firebase/view/plumber.dart';
import 'package:firebase/view/plumberDetailsScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../util/string_const.dart';

class PlumberDetailsCard extends StatelessWidget {
  
  final PlumberDetails plumberDetails;
  

  PlumberDetailsCard(this.plumberDetails);

  @override
  Widget build(BuildContext context) {
    Color statusColor = plumberDetails.available ? Colors.green : Colors.red;
    String statusText = plumberDetails.available ? 'Available' : 'Unavailable';
    return GestureDetector(
      onTap: () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => PlumberDetailsScreen(plumberDetails) ,));
      
      },
      child:Card(
        margin: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: CircleAvatar(
                backgroundColor: colorstr,
              
                 backgroundImage: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSDMrbabaGAWmEIwfvefFe-Wf9mYEDxeWv1Bc4QCmshjw&s"),
                child: Text('P'), 
              ),
              title: Text(plumberDetails.name),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                    
                      Text(' (${plumberDetails.profession} )', style: TextStyle(fontSize: 15),),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.location_on, color: Colors.blue),
                      Text(' ${plumberDetails.location}(${plumberDetails.distance.toStringAsFixed(2)} km)'),
                    ],
                  ),
                  Row(
                    children: [
                      Text("Rating:"),
                      StarRating(
                        starCount: 5,
                        rating: plumberDetails.rating.toInt(),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.phone, color: Colors.green),
                      Text(' ${plumberDetails.contact}'),
                    ],
                  ),
                 
                  Row(
                    children: [
                      Icon(Icons.timer, color: Colors.orange),
                      Text(' ${plumberDetails.experience} years'),
                    ],
                  ),
                   Text(
                    statusText,
                    style: TextStyle(color: statusColor, fontWeight: FontWeight.bold),
                  ),
                  
                ],
              ),
            ),
          ],
        ),
      ),

    );
  }
}