// import 'package:flutter/material.dart';
// import 'package:firebase_storage/firebase_storage.dart';

// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   // Создаем экземпляр Firebase Storage
//   FirebaseStorage storage = FirebaseStorage.instance;

//   // Путь к файлу в Firebase Storage
//   String imagePath = 'images/image.jpg';

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Firebase Storage Example'),
//       ),
//       body: Center(
//         child: FutureBuilder(
//           future: storage.ref().child(imagePath).getDownloadURL(),
//           builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
//             if (snapshot.hasError) {
//               return Text('Error: ${snapshot.error}');
//             }
//             if (snapshot.connectionState == ConnectionState.done) {
//               return Image.network(
//                 snapshot.data,
//                 height: 200.0,
//               );
//             }
//             return CircularProgressIndicator();
//           },
//         ),
//       ),
//     );
//   }
// }
