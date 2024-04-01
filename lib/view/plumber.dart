import 'package:firebase/util/string_const.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'PlumberDetailsCard.dart';

class PlumberDetails {
  final userId;
  final String name;
  final String location;
  final double rating;
  final int contact;
  final double latitude;
  final double longitude;
  final double distance; 
  final int experience;
  final String profession;
    final bool available; 
      double averageRating; // Update to allow modification

   // final double numRatings;

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
     required this.available,
   //  required this.numRatings,
required this.userId,
    required this.averageRating,

  });

  factory PlumberDetails.fromMap(Map<String, dynamic> map) {
    try {
      return PlumberDetails(
        name: map['name'] ?? '',
        location: map['location'] ?? '',
        rating: (map['rating'] as num?     )?.toDouble() ?? 5 ,
        contact: map['contact'] ?? '',
        latitude: (map['latitude'] as num?)?.toDouble() ?? 0.0,
        longitude: (map['longitude'] as num?)?.toDouble() ?? 0.0,
        distance: (map['distance'] as num?)?.toDouble() ?? 0.0,
        experience: (map['experience']) ?? 0,
        profession: (map['profession']) ?? '',
        available: (map['available']) ?? false,
      //  numRatings: (map['numRatings'] as num?)?.toDouble() ?? 0.0,
        userId:  (map['userId']) ?? 0,
              averageRating: 0, // Initialize averageRating

      
        

      );
    } catch (e) {
      print('Error creating PlumberDetails: $e');
      throw e;
    }
  }

}





class StarRating extends StatefulWidget {
  final int starCount;
  final double initialRating;
  final String userId;
  final Function(double) onRatingChanged;
  final double size;

  StarRating({
    required this.starCount,
    required this.initialRating,
    required this.userId,
    required this.onRatingChanged,
    this.size = 24.0,
  });

  @override
  _StarRatingState createState() => _StarRatingState();
}

class _StarRatingState extends State<StarRating> {
  late double _rating;

  @override
  void initState() {
    super.initState();
    _rating = widget.initialRating;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        widget.starCount,
        (index) {
          final starIndex = index + 1;
          return GestureDetector(
            onTap: () {
              setState(() {
                _rating = starIndex.toDouble();
              });
              widget.onRatingChanged(_rating.toDouble());
              _updateRatingInFirestore(_rating.toDouble());
            },
            child: Icon(
              starIndex <= _rating ? Icons.star : Icons.star_border,
              color: Colors.amber,
              size: widget.size,
            ),
          );
        },
      ),
    );
  }

 
 Future<void> _updateRatingInFirestore(double newRating) async {
  try {
    final plumberRef = FirebaseFirestore.instance.collection('plumber').doc(widget.userId);

    final plumberDoc = await plumberRef.get();
    if (plumberDoc.exists) {
      final currentRating = plumberDoc['rating'] ?? 0.0;
      final numRatings = plumberDoc['numRatings'] ?? 0.0;

      final updatedRating = (currentRating * numRatings + newRating) / (numRatings + 1);
      final updatedNumRatings = numRatings + 1;

      await plumberRef.update({
        'rating': updatedRating,
        'numRatings': updatedNumRatings,
      });
    } else {
      print('Plumber document not found for userId: ${widget.userId}');
    }
  } catch (e) {
    print('Error updating rating in Firestore: $e');
  }
 }}


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
