import 'package:firebase/api/api_response.dart';
import 'package:firebase/api/api_service_impl.dart';
import 'package:firebase/api/apiservice.dart';
import 'package:firebase/api/status_util.dart';
import 'package:firebase/model/credential.dart';
import 'package:flutter/material.dart';

class Passwordvisibility extends ChangeNotifier{
   bool showPassword=false;
   String? name,address,email,contact,password;
  ApiService apiservice = ApiServiceImpl();
  
  String? errormessage;
  bool isUserExist=false;
NetworkStatus loginStatus=NetworkStatus.idel;

   Visibility(bool value){
    showPassword==value;
    notifyListeners();
   }

NetworkStatus saveStudentStatus=NetworkStatus.idel;
//NetworkStatus getStudentDetailsStatus=NetworkStatus.idel;

setSaveStudentNetworkStatus(NetworkStatus status){
saveStudentStatus=status;
notifyListeners();
}
setLoginStatus(NetworkStatus networkStatus){
    loginStatus=networkStatus;
    notifyListeners();

  }

//setStudentDetailsNetworkStatus(NetworkStatus status){
//  getStudentDetailsStatus=status;
 // notifyListeners();
//}
Future<void> saveStudentData()async{
  if(saveStudentStatus!=NetworkStatus.loading){
    saveStudentStatus=NetworkStatus.loading;
  }
  Credential credential=Credential(name: name,address: address,contact: contact,email: email,password: password);
ApiResponse response= await apiservice.saveStudent(credential);
if(response.networkStatus==NetworkStatus.sucess){
      setSaveStudentNetworkStatus(NetworkStatus.sucess);
    }else if(response.networkStatus==NetworkStatus.error){
      errormessage=response.errormessage;
      setSaveStudentNetworkStatus(NetworkStatus.error);
    }


}
Future<void> loginDataInFirebase()async{
    if(loginStatus!=NetworkStatus.loading){
      setLoginStatus(NetworkStatus.loading);

    }
    Credential credential=Credential(email: email,password: password);
    ApiResponse response=await apiservice.loginData(credential);
    if(response.networkStatus==NetworkStatus.sucess){
      isUserExist=response.data;
      setLoginStatus(NetworkStatus.sucess);
    }else if(response.networkStatus==NetworkStatus.error){
      errormessage=response.errormessage;
      setLoginStatus(NetworkStatus.error);
    }


  }
  
}