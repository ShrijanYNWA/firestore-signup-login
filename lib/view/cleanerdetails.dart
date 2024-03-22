import 'package:firebase/util/string_const.dart';
import 'package:firebase/view/plumber.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'PlumberDetailsCard.dart';

class MechanicDetails extends StatefulWidget {
  @override
  _MechanicDetailsState createState() => _MechanicDetailsState();
}
class _MechanicDetailsState extends State<MechanicDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorstr,
        foregroundColor: Colors.white,
        title: Text("Mechanic Details", ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
             
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
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

                    // Create a list to store carpenter details
                    List<PlumberDetails> MechanicDetailsList = [];

                    // Iterate through the documents and add carpenter details to the list
                    snapshot.data!.docs.forEach((doc) {
                      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
                      PlumberDetails plumberDetails = PlumberDetails.fromMap(data);

                      // Check if the profession is "carpenter"
                      if (plumberDetails.profession.toLowerCase() == "mechanics") {
                        MechanicDetailsList.add(plumberDetails);
                      }
                    });

                    // Sort carpenter details by distance (smallest distance first)
                    MechanicDetailsList.sort((a, b) => a.distance.compareTo(b.distance));

                    return ListView.builder(
                      itemCount: MechanicDetailsList.length,
                      itemBuilder: (context, index) {
                        PlumberDetails plumberDetails = MechanicDetailsList[index];
                        return PlumberDetailsCard(plumberDetails);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  } 
}

