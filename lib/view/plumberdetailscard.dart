import 'package:firebase/view/plumber.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../util/string_const.dart';

class PlumberDetailsCard extends StatelessWidget {
  final PlumberDetails plumberDetails;

  PlumberDetailsCard(this.plumberDetails);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // When the card is tapped, show complete details in a dialog
        _showDetailsDialog(context, plumberDetails);
      },
      child:Card(
        margin: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: CircleAvatar(
                backgroundColor: colorstr,
                // You can use an image provider for the plumber's picture
                 backgroundImage: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSDMrbabaGAWmEIwfvefFe-Wf9mYEDxeWv1Bc4QCmshjw&s"),
                child: Text('P'), // Placeholder text or image if no picture is available
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
                  
                ],
              ),
            ),
          ],
        ),
      ),

    );
  }
  // Function to show details in a dialog
void _showDetailsDialog(BuildContext context, PlumberDetails details) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Complete Details'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Name: ${details.name}'),
              Text('Location: ${details.location}'),
              Text("Rating:"),
              StarRating(
                starCount: 5,
                rating: details.rating.toInt(),
              ),
              Text('Contact: ${details.contact}'),
             // Text('Latitude: ${details.latitude}'),
             // Text('Longitude: ${details.longitude}'),
              Text('Distance: ${details.distance.toStringAsFixed(2)} km'),
              Text('Experience: ${details.experience} years'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
}