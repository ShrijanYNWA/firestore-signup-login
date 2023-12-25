import 'package:firebase/provider/passwordvisibility.dart';
import 'package:firebase/util/string_const.dart';
import 'package:firebase/view/dashboard.dart';
import 'package:firebase/view/login.dart';
import 'package:firebase/view/studentform.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void initState(){
    readValueFromSharedPreference();
    super.initState();
  }
  bool isUserExist=false;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
ChangeNotifierProvider<Passwordvisibility>(create: (context) => Passwordvisibility(),)

      ],
      child: Consumer<Passwordvisibility>(builder: (context, passwordVisibility, child) =>  MaterialApp( debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
          
            colorScheme: ColorScheme.fromSeed(seedColor:colorstr),
            useMaterial3: true,
          ),
          home: isUserExist? Dashboard():LoginUi(),
        ),
      ),
    );
  }

  readValueFromSharedPreference()async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
isUserExist = prefs.getBool('isUserExit')??false ; //yedi user exit ko value kayhee aayena vane bu default false nai hunxa ?? ko kam tei ho
setState(() {
});
isUserExist; // isUserExist ko value change vairako ko kura lai UI ma update garaune 
  }
}

