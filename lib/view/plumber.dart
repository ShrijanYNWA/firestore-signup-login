import 'package:firebase/util/string_const.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'PlumberDetailsCard.dart';

class PlumberDetails {
  final String name;
  final String location;
  final int rating;
  final int contact;
  final double latitude;
  final double longitude;
  final double distance; // New field for distance
  final int experience;
  final String profession;// New field for experience

  PlumberDetails({
    required this.name,
    required this.location,
    required this.rating,
    required this.contact,
    required this.latitude,
    required this.longitude,
    required this.distance,
    required this.experience,
    required this.profession,
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
        profession: (map['profession']) ?? '',

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




class PlumberDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorstr,
        title: Text('All Available Service Provider',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
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
