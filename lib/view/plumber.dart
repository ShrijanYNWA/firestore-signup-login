import 'package:firebase/util/string_const.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PlumberDetails {
  final String name;
  final String location;
  final int rating;
  final int contact;
  final double latitude;
  final double longitude;
  final double distance; // New field for distance
  final int experience; // New field for experience

  PlumberDetails({
    required this.name,
    required this.location,
    required this.rating,
    required this.contact,
    required this.latitude,
    required this.longitude,
    required this.distance,
    required this.experience,
  });

  factory PlumberDetails.fromMap(Map<String, dynamic> map) {
    try {
      return PlumberDetails(
        name: map['name'] ?? '',
        location: map['location'] ?? '',
        rating: (map['rating']) ?? 5,
        contact: map['contact'] ?? '',
        latitude: (map['latitude'] as num?)?.toDouble() ?? 0.0,
        longitude: (map['longitude'] as num?)?.toDouble() ?? 0.0,
        distance: (map['distance'] as num?)?.toDouble() ?? 0.0,
        experience: (map['experience']) ?? 0,
      );
    } catch (e) {
      print('Error creating PlumberDetails: $e');
      throw e;
    }
  }
}

class StarRating extends StatelessWidget {
  final int starCount;
  final int rating;

  StarRating({required this.starCount, required this.rating});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        starCount,
        (index) {
          return Icon(
            index < rating ? Icons.star : Icons.star_border,
            color: colorstr,
          );
        },
      ),
    );
  }
}


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

class PlumberDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorstr,
        title: Text('Plumber Details'),
      ),
      body: StreamBuilder<QuerySnapshot>(
  stream: FirebaseFirestore.instance.collection("plumber").snapshots(),
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return Center(child: CircularProgressIndicator());
    }

    if (snapshot.hasError) {
      return Center(child: Text('Error: ${snapshot.error}'));
    }

    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
      return Center(child: Text('No plumber details found in Firestore.'));
    }

    // Add this line to see the document count
    print('Document Count: ${snapshot.data!.docs.length}');

    return ListView.builder(
      itemCount: snapshot.data!.docs.length,
      itemBuilder: (context, index) {
        try {
          Map<String, dynamic> data = snapshot.data!.docs[index].data() as Map<String, dynamic>;
          print("Data for index $index: $data");
          PlumberDetails plumberDetails = PlumberDetails.fromMap(data);
          return PlumberDetailsCard(plumberDetails);
        } catch (e) {
          print("Error processing data for index $index: $e");
          return Container(); // Skip invalid data
        }
      },
    );
  },
)

    );
  }
}
