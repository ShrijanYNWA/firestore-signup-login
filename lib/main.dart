import 'package:firebase/provider/passwordvisibility.dart';
import 'package:firebase/util/string_const.dart';
import 'package:firebase/view/UploadImage.dart';
import 'package:firebase/view/carousel.dart';
import 'package:firebase/view/dashboard.dart';
import 'package:firebase/view/drawer.dart';
import 'package:firebase/view/forgetpassword.dart';
import 'package:firebase/view/login.dart';
import 'package:firebase/view/navbar.dart';
import 'package:firebase/view/otp.dart';
import 'package:firebase/view/plumber.dart';
import 'package:firebase/view/profile.dart';
import 'package:firebase/view/see_all.dart';
import 'package:firebase/view/signup.dart';
import 'package:firebase/view/test.dart';
import 'package:firebase/view/testloginwithg.dart';
import 'package:firebase/view/upload.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
    
  );
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
   MyApp({super.key});
  FirebaseMessaging messaging = FirebaseMessaging.instance;


  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  void initState(){
    notificationSetting();
    listenNotification();
  //  readValueFromSharedPreference();
    super.initState();
  }
  bool isUserExist=false;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
ChangeNotifierProvider<Passwordvisibility>(create: (context) => Passwordvisibility(),),

      ],
      child:  MaterialApp( debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
          
            colorScheme: ColorScheme.fromSeed(seedColor:colorstr),
            useMaterial3: true,
          ),
          home:Dashboard(),
               // isUserExist? Dashboard():LoginUi(),
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
  notificationSetting()async{

NotificationSettings settings = await messaging.requestPermission(
  alert: true,
  announcement: false,
  badge: true,
  carPlay: false,
  criticalAlert: false,
  provisional: false,
  sound: true,
);

print('User granted permission: ${settings.authorizationStatus}');
  }
  listenNotification(){
    FirebaseMessaging.onMessage.listen((RemoteMessage message){
print(message);
    });

  }
  getToken()async{
    String? token = await messaging.getToken();//yo device ko token yeslai init state ma call garne
  }
}

