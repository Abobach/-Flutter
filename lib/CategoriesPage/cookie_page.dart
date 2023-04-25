// import 'dart:html';

// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';

// class ImageStore extends StatefulWidget {
//   const ImageStore({super.key});

//   @override
//   State<ImageStore> createState() => _ImageStoreState();
// }

// class _ImageStoreState extends State<ImageStore> {
//   @override
//   Widget build(BuildContext context) {
//     final ref = FirebaseStorage.instance.ref().child(
//         'userImages/macos-monterey-stock-black-dark-mode-layers-5k-4480x2520-5889.jpeg');
// // no need of the file extension, the name will do fine.
//     var url = ref.getDownloadURL();

//     return Image.network(storage.getDownloadURL(
//         'userImages/macos-monterey-stock-black-dark-mode-layers-5k-4480x2520-5889.jpeg'));
//   }
// }
