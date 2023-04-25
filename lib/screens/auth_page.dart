import 'package:diplom_flutter/constants.dart';
import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
import './screen.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Добро пожаловать!",
        theme: ThemeData(
          scaffoldBackgroundColor: kBackgroundColor,
        ));
  }
}
