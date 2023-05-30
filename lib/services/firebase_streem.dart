// import 'package:diplom_flutter/page/splash_Page.dart';
// import 'package:diplom_flutter/screens/home_screen.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// import '../page/verify_email_screen.dart';
// import '../screens/btm_bar.dart';

// class FirebaseStream extends StatelessWidget {
//   const FirebaseStream({super.key});

//   // Future getCurrentUser() async {
//   //   return (await firebaseAuth.currentUser());
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<User?>(
//       stream: FirebaseAuth.instance.authStateChanges(),
//       builder: (context, snapshot) {
//         if (snapshot.hasError) {
//           return const Scaffold(
//               body: Center(child: Text('Что-то пошло не так!')));
//         } else if (snapshot.hasData) {
//           if (!snapshot.data!.emailVerified) {
//             return const ();
//           }
//           return HomePage();
//         } else {
//           return HomePage();
//         }
//       },
//     );
//   }
// }
