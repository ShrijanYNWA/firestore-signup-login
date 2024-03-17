// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// import '../custom_ui/customelevatedbutton.dart';
// import '../custom_ui/customform.dart';
// import '../util/string_const.dart';
// import 'login.dart';

// class ForgotPasswordPage extends StatefulWidget {
//   @override
//   _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
// }
// @override
// void initState() {
//   TextEditingController;
//   initState();
  
// }

// class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
//   final TextEditingController _emailController = TextEditingController();
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   final RegExp emailRegex =
//       RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

//   void _resetPassword() async {
//     if (_formKey.currentState != null && _formKey.currentState!.validate()) {
//       try {
//         await FirebaseAuth.instance.sendPasswordResetEmail(
//           email: _emailController.text.trim(),
//         );      // Show success message or navigate to a success screen
//         showDialog(
//           context: context,
//           builder: (context) => AlertDialog(
//             title: Text('Password Reset Email Sent'),
//             content: Text(
//                 'A password reset email has been sent to ${_emailController.text.trim()}. Please check your email and follow the instructions to reset your password.'),
//             actions: <Widget>[
//               TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//                 child: Text('OK'),
//               ),
//             ],
//           ),
//         );
//       } catch (e) {
//         // Show error message
//         showDialog(
//           context: context,
//           builder: (context) => AlertDialog(
//             title: Text('Error'),
//             content: Text('Failed to send password reset email. Error: $e'),
//             actions: <Widget>[
//               TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//                 child: Text('OK'),
//               ),
//             ],
//           ),
//         );
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: colorstr,
//         title: Text('Forgot Password',style: TextStyle(color: Colors.white),),
//       ),
//       body: Stack(
//         children:[
//           Container(
//       color: colorstr,
//       ),
          
//            SingleChildScrollView(
//              child: Column(
//                children: [
//                  Container(
//                   height: MediaQuery.of(context).size.height * 0.5,
//                 color: Colors.transparent,
//                           child: Image(image: AssetImage("asset/images/logo.png")),

//                  ),
//                     Container(
//                          height: MediaQuery.of(context).size.height * 0.4,
//                 width: MediaQuery.of(context).size.width,
           
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.only(
//                       topRight: Radius.circular(40),
//                       topLeft: Radius.circular(40)),
//                   color: Colors.white,
//                   ),
//                       child: Padding(
//                   padding: const EdgeInsets.only(left:15,right: 15,top: 25),
//                       child: Column( crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                              Text("Forget Password?", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: colorstr)),
//                           Row(
//                             children: [
//                               Text("Already have an account?"),
//                               SizedBox(
//                                 width: width(0.015, context),
//                               ),
//                               GestureDetector(child: Text("Login Now",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14, decoration: TextDecoration.underline, color: colorstr)),onTap: () {
//                                 Navigator.push(context, MaterialPageRoute(builder: (context) => LoginUi(),));
                                
//                               },),
//                             ],
//                           ),
//                           SizedBox(height: height(0.018, context),),
                            
//                             Form(
//                                      key: _formKey,
//                                      child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                              CustomForm(
//                                 controller: _emailController,
//                                 hintText: "Email Address",
//                                 keyboardType: TextInputType.emailAddress,
//                                 prefixIcon: Icon(Icons.email,color: colorstr,),
//                                 validator: (value) {
//                                   if(value!.isEmpty){
//                                     return emailValidationStr;
           
//                                   }
//                                  else if(!emailRegex.hasMatch(value)){
//                                       return 'Please enter a valid email';
           
//                                   }
//                                   else{
//                                     return null;
//                                   }
//                                 },
//                               ),
//                               SizedBox(height: height(0.03, context)),
//                               Padding(
//                                 padding: const EdgeInsets.symmetric(horizontal: 0),
//                                 child: SizedBox(
//                                   width: width(1, context),
//                                   height: width(0.14, context),
//                                   child: CustomElevatedButton(onPressed: () {
                                         
//                                                        // if (_formKey.currentState!.validate()) 
//                                                         {
//                                                          _resetPassword(); 
//                                                         } 
//                                   },child: Text("Submit"),onprimary: Colors.white,primary: colorstr,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),),
//                                 ),
//                               )
                        
//                         ],
//                       ),
//                     ),
             
//                           ],
//               )
                 
               
//              ),
//              ),
//                    ]
//                  ),
//            )

//          ]
//           )
//     );
      
//   }
//   height(value, context) {
//     return MediaQuery.of(context).size.height * value;
//   }

//   width(value, context) {
//     return MediaQuery.of(context).size.width * value;
//   }
// }
