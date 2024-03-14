import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../util/string_const.dart';
import '../view/plumber.dart';

class PlumberDetailsScreen extends StatefulWidget {
  final PlumberDetails plumberDetails;
  bool isPressed = false;

  PlumberDetailsScreen(this.plumberDetails);

  @override
  State<PlumberDetailsScreen> createState() => _PlumberDetailsScreenState();
}

class _PlumberDetailsScreenState extends State<PlumberDetailsScreen> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.plumberDetails.name} Details'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage("plumberDetails.image"),
              radius: 70,
            ),

            Text('${widget.plumberDetails.name}',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            Text(
                '${widget.plumberDetails.profession} ,  ${widget.plumberDetails.experience} years experience ',
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

            Text("Rating:",
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold)),
            SizedBox(
              height: 10,
            ),

            StarRating(
              starCount: 5,
              rating: widget.plumberDetails.rating.toInt(),
              size: 50,
            ),

            SizedBox(height: 10),
            Text("Location:",
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),


            Row(
              children: [
                Icon(Icons.location_on,color: Color.fromARGB(255, 0, 94, 170),),
                Text('${widget.plumberDetails.location}(${widget.plumberDetails.distance.toStringAsFixed(2)} km away)',
                    style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500, color:Color.fromARGB(255, 0, 94, 170))),
              ],
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
    );
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
}
