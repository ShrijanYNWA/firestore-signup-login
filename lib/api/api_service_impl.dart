import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/api/api_response.dart';
import 'package:firebase/api/apiservice.dart';
import 'package:firebase/api/status_util.dart';
import 'package:firebase/model/credential.dart';

class ApiServiceImpl extends ApiService {
  bool isUserExist = false;

  @override
  Future<ApiResponse> saveStudent(Credential credential) async {
    //  print("name : ${credential.name}");
    // return ApiResponse(data:null);
    try {
      FirebaseFirestore.instance
          .collection("credential")
          .add(credential.toJson());
      return ApiResponse(networkStatus: NetworkStatus.sucess);
    } catch (e) {
      return ApiResponse(
          networkStatus: NetworkStatus.error, errormessage: e.toString());
    }
  }

  @override
  Future<ApiResponse> getStudent() {
    // TODO: implement getStudent
    throw UnimplementedError();
  }
  
  @override
  Future<ApiResponse> loginData(Credential credential)async {
    try {
      await FirebaseFirestore.instance
          .collection("credential")
          .where("email", isEqualTo: credential.email)
          .where("password", isEqualTo: credential.password)
          .get() // value get garaxa 
          .then((value) { //value vanne variable ma email ra password store garxa
        if (value.docs.isNotEmpty) {
          isUserExist = true;
        } else {
          isUserExist = false;
        }
      });
    } catch (e) {
      return ApiResponse(
          networkStatus: NetworkStatus.error, errormessage: e.toString());
    }
    return ApiResponse(networkStatus: NetworkStatus.sucess, data: isUserExist);
  
  }
}
