import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PlumberDetails {
  final String name;
  final String location;
  final double rating;
  final String contact;

  PlumberDetails({
    required this.name,
    required this.location,
    required this.rating,
    required this.contact,
  });

  factory PlumberDetails.fromMap(Map<String, dynamic> map) {
    try {
      return PlumberDetails(
        name: map['name'] ?? '',
        location: map['location'] ?? '',
        rating: (map['rating'] as num?)?.toDouble() ?? 0.0,
        contact: map['contact'] ?? '',
      );
    } catch (e) {
      print('Error creating PlumberDetails: $e');
      throw e;
    }
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
      child: Card(
        margin: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text(plumberDetails.name),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Location: ${plumberDetails.location}'),
                  Text('Rating: ${plumberDetails.rating}'),
                  Text('Contact: ${plumberDetails.contact}'),
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
              Text('Rating: ${details.rating}'),
              Text('Contact: ${details.contact}'),
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
      ),
    );
  }
}

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Plumber Details'),
//         ),
//         body: Center(
//           child: ElevatedButton(
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => PlumberDetailsPage()),
//               );
//             },
//             child: Text('Show Plumber Details'),
//           ),
//         ),
//       ),
//     );
//   }
// }
