import 'package:firebase/api/api_service_impl.dart';
import 'package:firebase/api/apiservice.dart';
import 'package:firebase/api/status_util.dart';
import 'package:firebase/custom_ui/customelevatedbutton.dart';
import 'package:firebase/custom_ui/customform.dart';
import 'package:firebase/helper/helper.dart';
import 'package:firebase/provider/passwordvisibility.dart';
import 'package:firebase/util/string_const.dart';
import 'package:firebase/view/studentform.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginUi extends StatefulWidget {
  LoginUi({super.key});

  @override
  State<LoginUi> createState() => _LoginUiState();
}

class _LoginUiState extends State<LoginUi> {
  ApiService apiService=ApiServiceImpl();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Consumer<Passwordvisibility>(builder: (context, passwordVisibility, child) => 
          Stack(children: [
              Container(
          color: colorstr,
              ),
               SingleChildScrollView(
            child: loginUi(context, passwordVisibility)
          ),
              
            ]
            ),
        )
    );
  }

 Widget loginUi(BuildContext context, Passwordvisibility passwordVisibility){ //function
  return Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.5,
                color: Colors.transparent,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.5,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(40),
                      topLeft: Radius.circular(40)),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Form(
                    key: _formKey,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 30, left: 20, right: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(loginnowStr,
                              style: TextStyle(
                                  color: colorstr,
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold)),
                          Row(
                            children: [
                              Text(
                                userStr,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                              ClipRRect(
                                child: SizedBox(
                                  height: 31,
                                  child: TextButton(
                                    onPressed: () {
                                      //print("button pressed");
                                      Navigator.push(context, MaterialPageRoute(builder: (context) =>  StudentForm()));
                                    },
                                    child: Text(
                                      accountStr,
                                      style: TextStyle(color: colorstr),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          CustomForm(
                            hintText: EmailaddressStr,
                            keyboardType: TextInputType.emailAddress,
                            prefixIcon: Icon(
                              Icons.email,
                              color: colorstr,
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return emailValidationStr;
                              } else {
                                return null;
                              }
                            },
                            onChanged: (value) {
                              passwordVisibility.email=value;
                              
                              
                            },
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          CustomForm(
                            hintText: passwordStr,
                            prefixIcon: Icon(
                              Icons.lock,
                              color: colorstr,
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return passwordValidationStr;
                              } else {
                                return null;
                              }
                            },
                            onChanged: (value) {
                             passwordVisibility.password=value; 
                            },
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.9,
                            height: 65,
                            child: CustomElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                passwordVisibility.loginDataInFirebase().then((value) {
                                  if(passwordVisibility.loginStatus==NetworkStatus.sucess && passwordVisibility.isUserExist){
                        Helper.snackBarMessage("Successfully Logged in", context);
                        //navigate to dashboard
                      }else if(passwordVisibility.loginStatus==NetworkStatus.sucess && !passwordVisibility.isUserExist){
                        Helper.snackBarMessage("Invalid Credential!!!", context); 
                      }
                      
                      else if(passwordVisibility.loginStatus==NetworkStatus.error){
                        Helper.snackBarMessage("Failed to saved", context);
                      }

                                });
                              //    print("login is presses");
                                }
                              },
                              child: Text(loginStr),
                              primary: colorstr,
                              onprimary: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          ),
                          SizedBox(
                            height: 7,
                          ),
                          Row(
                            children: [
                              TextButton(
                                  onPressed: () {
                                  //  print("forget password button is pressed");
                                  },
                                  child: Text(
                                    ForgetpassStr,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        decoration: TextDecoration.underline),
                                  )),
                              Spacer(),
                              TextButton(
                                  onPressed: () {
                                  //  print("Signup password button is pressed");
                                  },
                                  child: Text(SignupStr,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          decoration:
                                              TextDecoration.underline)))
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          );
 }
}
