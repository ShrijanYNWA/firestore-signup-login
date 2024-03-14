import 'package:firebase/provider/passwordvisibility.dart';
import 'package:firebase/util/string_const.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ServiceProviderRegistration extends StatefulWidget {
  ServiceProviderRegistration({super.key});

  @override
  State<ServiceProviderRegistration> createState() => _ServiceProviderRegistrationState();
}

class _ServiceProviderRegistrationState extends State<ServiceProviderRegistration> {
  final _formKey = GlobalKey<FormState>();

  bool alreadyRegistered = false;
  bool isEditing = false; // Added for tracking whether the form is in edit mode

  // List of professions for the dropdown
  List<String> professions = [
    'Cleaner',
    'Plumber',
    'Carpenter',
    'Water Tanker',
    'Photographer',
    'Painter',
    'Mechanic',
  ];


  String? _selectedProfession;

  TextEditingController _nameController = TextEditingController();
  TextEditingController _contactController = TextEditingController();
  TextEditingController _locationController = TextEditingController();
  TextEditingController _experienceController = TextEditingController();

  @override
  void initState() {
    super.initState();

    fetchPreviousRegistrationDetails();
  }

  Future<void> fetchPreviousRegistrationDetails() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        QuerySnapshot existingRegistrations = await FirebaseFirestore.instance
            .collection("plumber")
            .where('userId', isEqualTo: user.uid)
            .get();

        if (existingRegistrations.docs.isNotEmpty) {
          // User is already registered, set the state and populate the form fields
          setState(() {
            alreadyRegistered = true;
          });

          Map<String, dynamic> registrationData =
              existingRegistrations.docs.first.data() as Map<String, dynamic>;

          _nameController.text = registrationData['name'];
          _contactController.text = registrationData['contact'].toString();
          _locationController.text = registrationData['location'];
          _selectedProfession = registrationData['profession'];
          _experienceController.text = registrationData['experience'].toString();
        }
      } catch (error) {
        print('Error fetching registration details: $error');
      }
    }
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    body: Builder(builder: (context) => Stack(
      children: [
        Container(
          color: colorstr,
        ),
        SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child: Image(
                  image: NetworkImage(
                    "https://firebasestorage.googleapis.com/v0/b/test-46b26.appspot.com/o/1000011063.png?alt=media&token=05757cc4-9566-4e9c-a083-2db36a91af92"),
                ),
                height: MediaQuery.of(context).size.height * 0.3,
                color: Colors.transparent,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.7,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(40),
                    topLeft: Radius.circular(40),
                  ),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(height: 40),
                          buildFormField("Name", _nameController, namevalidate, Icons.person),
                          buildFormField("Contact", _contactController, validateContact, Icons.phone),
                          buildFormField("Location", _locationController, locationvalidator, Icons.place),
                          buildDropdownFormField(
                              "Profession",
                              _selectedProfession,
                              (value) {
                                _selectedProfession = value;
                              },
                              professions,
                              Icons.home_repair_service_sharp),
                          buildFormField(
                              "Experience(Years)", _experienceController, experiencevalidator, Icons.person),
                          SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () async {
                              if (isEditing) {
                                // Handle form edit logic
                                await editForm(context);
                              } else {
                                // Handle form submission logic
                                await submitForm(context);
                                // Show the success snackbar only if the user was not already registered
                                if (!alreadyRegistered) {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(content: Text("Form submitted successfully!"));
                                    },
                                  );
                                }
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              shadowColor: colorstr.withOpacity(1),
                              elevation: 15,
                              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [Color.fromARGB(255, 181, 255, 185), const Color.fromARGB(255, 6, 96, 10)],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                ),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Center(
                                child: Text(isEditing ? 'Save Changes' : 'Register',
                                    style: TextStyle(fontSize: 20, color: Color.fromARGB(255, 234, 226, 226))),
                              ),
                            ),
                          ),
                          if (isEditing && _selectedProfession != null)
                            // Display delete button only in edit mode and when a profession is selected
                            ElevatedButton(
                              onPressed: () {
                                // Handle delete logic
                                showDeleteConfirmationDialog(context);
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Colors.red,
                                shadowColor: Colors.red.withOpacity(1),
                                elevation: 15,
                                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Center(
                                  child: Text('Delete', style: TextStyle(fontSize: 20, color: Colors.white)),
                                ),
                              ),
                            ),
                          // Display edit button only if not already editing
                          if (!isEditing && _selectedProfession != null)
                            ElevatedButton(
                              onPressed: () {
                                // Set the form in editing mode
                                setState(() {
                                  isEditing = true;
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Colors.blue,
                                shadowColor: Colors.blue.withOpacity(1),
                                elevation: 15,
                                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Center(
                                  child: Text('Edit', style: TextStyle(fontSize: 20, color: Colors.white)),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    )),
  );
}

  Widget buildFormField(String label, TextEditingController controller, String? Function(String? value)? validator, IconData prefixIcon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        controller: controller,
        style: TextStyle(fontSize: 18),
        decoration: InputDecoration(
          prefixIcon: Icon(prefixIcon, color: colorstr),
          labelText: label,
          labelStyle: TextStyle(fontSize: 16, color: colorstr),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: colorstr),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: colorstr, width: 2),
          ),
        ),
        validator: validator,
      ),
    );
  }

  Widget buildDropdownFormField(String label, String? value,
      ValueChanged<String?> onChanged, List<String> items, IconData prefixIcon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: DropdownButtonFormField<String>(
          value: value,
          onChanged: onChanged,
          items: items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(
                item,
                style: TextStyle(color: Colors.black),
              ),
            );
          }).toList(),
          style: TextStyle(
            fontSize: 16,
          ),
          decoration: InputDecoration(
            prefixIcon: Icon(prefixIcon, color: colorstr),
            labelText: label,
            labelStyle: TextStyle(fontSize: 16, color: colorstr),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: colorstr, width: 2),
            ),
          ),
        ),
      ),
    );
  }

  String? validateContact(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your Contact';
    }
    if (value.length != 10 || !RegExp(r'^[0-9]+$').hasMatch(value)) {
      return 'Please enter a valid 10-digit Contact';
    }
    return null;
  }

  String? namevalidate(String? value) {
    if (value == null || value.isEmpty) {
      return "$nameValidationStr";
    }
    if (value.isNotEmpty && !RegExp(r'^[a-zA-Z ]+$').hasMatch(value)) {
      return 'Name should be a string';
    }
    return null;
  }

  String? locationvalidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter your location";
    }
    return null;
  }

  String? experiencevalidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter your experience year";
    }

    int? experience = int.tryParse(value);
    if (experience == null || experience < 0 || experience > 60) {
      return 'You are providing fake experience';
    }

    return null;
  }

  Future<void> submitForm(BuildContext context) async {
    User? user = FirebaseAuth.instance.currentUser;
    int experience = int.parse(_experienceController.text);
    int contact = int.parse(_contactController.text);

    if (user != null && _selectedProfession != null) {
      try {
        // Check if the user already has a registration
        QuerySnapshot existingRegistrations = await FirebaseFirestore.instance
            .collection("plumber")
            .where('userId', isEqualTo: user.uid)
            .get();

        if (existingRegistrations.docs.isNotEmpty) {
          // User already has a registration, show a Snackbar
          setState(() {
            alreadyRegistered = true;
          });

          showDialog(context: context, builder: (context) {
            return AlertDialog(content: Text("Already register so failed to submit form!"));
          });

          // You can customize the Snackbar's appearance and duration as needed
          return;
        }

        // User doesn't have a registration, proceed with adding a new one
        await FirebaseFirestore.instance.collection("plumber").add({
          'userId': user.uid,
          'name': _nameController.text,
          'contact': contact,
          'location': _locationController.text,
          'profession': _selectedProfession,
          'experience': experience,
        });

        // Clear text controllers and reset dropdown value
        _nameController.clear();
        _contactController.clear();
        _locationController.clear();
        _experienceController.clear();
        _selectedProfession = null;

        // Reload the form
        _formKey.currentState?.reset();

        // Show the success snackbar only if the user was not already registered
        if (!alreadyRegistered) {
          showDialog(context: context, builder: (context) {
            return AlertDialog(content: Text("Form submitted successfully!"));
          });
        }
      } catch (error) {
        print('Error submitting form: $error');
      }
    }
  }

  Future<void> editForm(BuildContext context) async {
    User? user = FirebaseAuth.instance.currentUser;
    int experience = int.parse(_experienceController.text);
    int contact = int.parse(_contactController.text);

    if (user != null && _selectedProfession != null) {
      try {
        // Check if the user has a registration
        QuerySnapshot existingRegistrations = await FirebaseFirestore.instance
            .collection("plumber")
            .where('userId', isEqualTo: user.uid)
            .get();

        if (existingRegistrations.docs.isNotEmpty) {
          // User has a registration, proceed with updating
          QueryDocumentSnapshot registrationDoc = existingRegistrations.docs.first;
          String registrationId = registrationDoc.id;

          await FirebaseFirestore.instance.collection("plumber").doc(registrationId).update({
            'name': _nameController.text,
            'contact': contact,
            'location': _locationController.text,
            'profession': _selectedProfession,
            'experience': experience,
          });

          // Clear text controllers and reset dropdown value
          _nameController.clear();
          _contactController.clear();
          _locationController.clear();
          _experienceController.clear();
          _selectedProfession = null;

          // Reload the form
          _formKey.currentState?.reset();

          setState(() {
            isEditing = false;
          });

          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(content: Text("Form updated successfully!"));
            },
          );
        }
      } catch (error) {
        print('Error updating form: $error');
      }
    }
  }

  Future<void> showDeleteConfirmationDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap a button to dismiss the dialog!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Registration'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure you want to delete your registration?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Delete'),
              onPressed: () async {
                await deleteRegistration(context);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> deleteRegistration(BuildContext context) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        // Check if the user has a registration
        QuerySnapshot existingRegistrations = await FirebaseFirestore.instance
            .collection("plumber")
            .where('userId', isEqualTo: user.uid)
            .get();

        if (existingRegistrations.docs.isNotEmpty) {
          // User has a registration, proceed with deletion
          QueryDocumentSnapshot registrationDoc = existingRegistrations.docs.first;
          String registrationId = registrationDoc.id;

          await FirebaseFirestore.instance.collection("plumber").doc(registrationId).delete();

          // Clear text controllers and reset dropdown value
          _nameController.clear();
          _contactController.clear();
          _locationController.clear();
          _experienceController.clear();
          _selectedProfession = null;

          // Reload the form
          _formKey.currentState?.reset();

          setState(() {
            isEditing = false;
          });

          Navigator.of(context).pop(); // Close the delete confirmation dialog

          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(content: Text("Registration deleted successfully!"));
            },
          );
        }
      } catch (error) {
        print('Error deleting registration: $error');
      }
    }
  }
}
