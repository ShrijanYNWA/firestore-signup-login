import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/provider/passwordvisibility.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../util/string_const.dart';
import '../view/plumber.dart';

class PlumberDetailsScreen extends StatefulWidget {
  final PlumberDetails plumberDetails;
  bool isPressed = false;
  
   TextEditingController? reviewController; // Define reviewController
  List<String> reviews = []; // Define the reviews list


  PlumberDetailsScreen(this.plumberDetails);

  @override
  State<PlumberDetailsScreen> createState() => _PlumberDetailsScreenState();
}

class _PlumberDetailsScreenState extends State<PlumberDetailsScreen> {
  bool isPressed = false;
    @override
  void initState() {
    super.initState();
      widget.reviewController = TextEditingController();

    widget.reviewController =
        TextEditingController(); // Initialize reviewController
  }


  @override
  Widget build(BuildContext context) {
    
    return Consumer<Passwordvisibility>(
      builder: (context, passwordvisibility, child) => Scaffold(
        appBar: AppBar(
          title: Text('${widget.plumberDetails.name+"'s"} Details'),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                foregroundImage: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQjkDmT4fzz9xWxlF77TzA_fCinEC1OKypgPlaphkXU-Q&s"),
                radius: 70,
              //  backgroundColor:colorstr ,
              ),
    
              Text('${widget.plumberDetails.name}',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
              Text(
                  '${widget.plumberDetails.profession} ,  ${widget.plumberDetails.experience} years experience ',maxLines: 1,overflow:TextOverflow.fade ,
                  style: TextStyle(
                      fontSize: 20, color: Color.fromARGB(255, 0, 94, 170))),
              Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.435,
                    child: ElevatedButton(
                      onPressed: () {
                        _callNumber();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 45, 167, 49),
                        splashFactory: NoSplash.splashFactory,
                      ),
                      child: Text(
                        'Call',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 18),
                      ),
                    ),
                  ),
                  Spacer(),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.435,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        splashFactory: NoSplash.splashFactory,
                      ),
                      onPressed: _sendMessage,
                      child: Text(
                        'Message',
                        style:
                            TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 40),
              Text(
                "About ${widget.plumberDetails.name}",
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        style: BorderStyle.none,
                      ),
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.black12),
                  child: Text(
                    "I specialize in ${widget.plumberDetails.profession} for residental and commerial properties.I'm fast,reliable, and always on time.",
                    style: TextStyle(fontSize: 18),
                  )),
              SizedBox(height: 10),
    
            

    
              // Text("Rating:",
              //     style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold)),
              // SizedBox(
              //   height: 10,
              // ),
    
              // StarRating(
              //   starCount: 5,
              //   rating: widget.plumberDetails.rating.toInt(),
              //   size: 50,
              // ),
    
              // SizedBox(height: 10),
              InkWell(
               
                child: Text("Location:",
                    style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold)),
              ),
              SizedBox(height: 10),
              InkWell(
                 onTap: () {
                  mapDisplay(passwordvisibility);
                },
                child: Row(
                  children: [
                  Icon(Icons.location_on,color: Color.fromARGB(255, 0, 94, 170),),
                    Text('${widget.plumberDetails.location}(${widget.plumberDetails.distance.toStringAsFixed(2)} km away)',maxLines: 1,overflow:TextOverflow.clip,
                        style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500, color:Color.fromARGB(255, 0, 94, 170))),
                 Spacer(),
                 Expanded(child: Icon(FontAwesomeIcons.locationCrosshairs,color:  Color.fromARGB(255, 0, 94, 170) , )),
                 
                  ],
                ),
              ),SizedBox(
                height: 10,
              ),
                Text("Availability:",
                  style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold)),
              SizedBox(
                height: 5
              ),
                          Text(
  widget.plumberDetails.available ? "Currently Available" : "Sorry, Currently Unavailable",
  style: TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: widget.plumberDetails.available ? Colors.green : Colors.red,
  ),
),
              SizedBox(height: 20),

              Text(
                "Rate this provider:",
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              RatingBar.builder(
                initialRating: 0,
                minRating: 0,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemSize: 30,
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color:colorstr,
                ),
                onRatingUpdate: (rating) {
                  // Store the rating in Firestore
                  storeRating(rating);
                },
              ),


  
  // Display Reviews Section
              SizedBox(height: 20),
              Text(
                "Reviews:",
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              // StreamBuilder to listen to changes in the reviews collection
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('reviews')
                    .where('plumberId', isEqualTo: widget.plumberDetails.userId)
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }
                  if (snapshot.hasData) {
                    List<DocumentSnapshot> documents = snapshot.data!.docs;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: documents.map((doc) {
                        String userId = doc['userId'] ??
                            'Unknown User'; 
                      
                    
                            // Handle null userId
                        // Display each review and the user who gave it
                        return Row(
                          
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 15),
                              child: Container(
                                 padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.01),
                                                width: MediaQuery.of(context).size.width*0.9,
                                                decoration: BoxDecoration(border: Border.all(color: Colors.transparent),
                                                color: Colors.black12,
                                                borderRadius: BorderRadius.circular(10)
                                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      userId,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          color: colorstr),
                                    ),
                              // Text(
                              //   doc['date'] != null ? DateFormat('MMMM d, y').format(doc['date'].toDate()) : '',
                              //   style: TextStyle(fontWeight: FontWeight.bold),
                              // ),
                              
                              
                              
                              
                                    SizedBox(height: MediaQuery.of(context).size.height*0.009,),
                                //    SizedBox(height: 5),
                                    Text(
                                      '"${doc['review']}"',
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(height: 10),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    );
                  }
                  return SizedBox();
                },
              ),

              // Add Review Section
              SizedBox(height: 20),
              Text(
                "Add Your Review:",
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              TextField(
                controller: widget.reviewController,
                decoration: InputDecoration(
                  hintText: 'Write your review here...',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(primary: colorstr,onPrimary: Colors.white),
                onPressed: () {
                  // Function to add the review to Firestore
                  addReview(widget.reviewController!.text);
                },
                child: Text('Submit Review'),
              ),
          

    
              // SizedBox(height: 10),
              // Text('Contact: ${widget.plumberDetails.contact}',
              //     style: TextStyle(fontSize: 18)),
              // // Text('Latitude: ${details.latitude}'),
              // // Text('Longitude: ${details.longitude}'),
              // SizedBox(height: 10),
              // Text(
              //     'Distance: ${widget.plumberDetails.distance.toStringAsFixed(2)} km',
              //     style: TextStyle(fontSize: 18)),
              // SizedBox(height: 10),
              // Text('Experience: ${widget.plumberDetails.experience} years',
              //     style: TextStyle(fontSize: 18)),
            ],
          ),
        ),
      ),
    );
  }
  mapDisplay(Passwordvisibility passwordvisibility) async {
    try {
      // Get coordinates for start and end addresses
      String? startAddress = passwordvisibility.currentLocation;
      String? endAddress = widget.plumberDetails.location;
      List<Location> startLocations = await locationFromAddress(startAddress!);
      List<Location> endLocations = await locationFromAddress(endAddress);
print(endLocations);
      if (startLocations.isNotEmpty && endLocations.isNotEmpty) {
        // Extract coordinates from locations
        double startLatitude = startLocations.first.latitude;
        double startLongitude = startLocations.first.longitude;

        double endLatitude = endLocations.first.latitude;
        double endLongitude = endLocations.first.longitude;

        // Get installed maps
        final availableMaps = await MapLauncher.installedMaps;

        if (availableMaps.isNotEmpty) {
          // Show directions on the first available map
          availableMaps.first.showDirections(
            destination: Coords(endLatitude, endLongitude),
            destinationTitle: endAddress,
            origin: Coords(startLatitude, startLongitude),
            originTitle: startAddress,
            directionsMode:
                DirectionsMode.walking, // You can customize the directions mode
          );
        } else {
          print('No maps app installed.');
        }
      } else {
        print('No coordinates found for the addresses.');
      }
    } catch (e) {
      print('Error during geocoding: $e');
    }
  }

  void _callNumber() async {
    String phoneNumber = '${widget.plumberDetails.contact}';
    Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      throw 'Could not launch $phoneNumber';
    }
  }

  void _sendMessage() async {
    String phoneNumber = '${widget.plumberDetails.contact}';
    String message =
        'Hello, I would like to hire you for a ${widget.plumberDetails.profession} job.'; // Replace with the message you want to send
    Uri launchUri = Uri(
      scheme: 'sms',
      path: phoneNumber,
      queryParameters: {'body': message},
    );
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      throw 'Could not launch $phoneNumber';
    }
  }
  void storeRating(double rating) {
    // Store the rating in Firestore
    FirebaseFirestore.instance.collection("ratings").add({
      "plumberId":
          widget.plumberDetails.userId, // Use plumber's ID as identifier
      "contact": widget.plumberDetails.contact, // Include plumber's contact
      "userId": "currentUserId", // Replace with the current user's ID
      "rating": rating,
    }).then((value) {
      print("Rating added successfully");
    }).catchError((error) {
      print("Failed to add rating: $error");
    });
  }

 void addReview(String review) {
  // Get the current date/time
  DateTime currentDate = DateTime.now();
DateTime dateOnly = DateTime(currentDate.year, currentDate.month, currentDate.day);

  
  // Add the review to the Firestore collection along with the current date/time
  String userName = FirebaseAuth.instance.currentUser?.displayName ?? 'User';
  FirebaseFirestore.instance.collection('reviews').add({
    'plumberId': widget.plumberDetails.userId,
    'review': review,
    'userId': userName,
    'date': dateOnly, // Include the current date
  }).then((value) {
    // Clear the review input field after submitting
    widget.reviewController!.clear();
    print('Review added successfully');
  }).catchError((error) {
    print('Failed to add review: $error');
  });
}


}