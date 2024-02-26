// import 'dart:io';

// import 'package:firebase/view/upload.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// class Test extends StatelessWidget {
//    Test({super.key});
//   File? file;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: file==null? Column(
//           children: [
//             GestureDetector(
//               onTap: () async {
// // Pick an image.
//                 final XFile? image =
//                     await ImagePicker().pickImage(source: ImageSource.gallery);
//                     print(image);
//                     if(image==null)
//                     return;
//                     file=File(image.path);

//               },
//               child: Container(
//                 height: 500,
//                 width: 500,
//                 child: Column(
//                   children: [
//                     Icon(
//                       Icons.upload,
//                       size: 100,
//                     ),
//                     ElevatedButton(onPressed: () {
                      
//                     }, child: Text("continue"))
//                   ],
//                 ),
//               ),
//             )
//           ],
//         ): Image.file(),
//       ),
//     );
//   }
//   UploadImageToFirebase()async{
//     final storageReference= FirebaseStorage.instance.ref();
//     var  uploadValue=storageReference.child(image!.name);
//     await uploadValue.putFile(File!);
//     final downloadUrl =await storageReference.child(image!.name).getDownloadURL();
//     print(downloadUrl);

//   }
// }
