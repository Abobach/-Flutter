import 'package:diplom_flutter/phoneAyth/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

import '../phoneAyth/register_screen.dart';
import '../phoneAyth/user_model.dart';

class DetailPageSuvenir extends StatefulWidget {
  final querySnapshot;
  DetailPageSuvenir({Key? key, required this.querySnapshot}) : super(key: key);

  @override
  State<DetailPageSuvenir> createState() => _DetailPageSuvenirState();
}

class _DetailPageSuvenirState extends State<DetailPageSuvenir> {
  double screenWidth = 0;
  double screenHeight = 0;
  final db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: SizedBox(
              height: screenHeight / 2.2,
              width: screenWidth,
              child: Image.network(
                widget.querySnapshot['image'],
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth / 20,
              vertical: 20,
            ),
            child: Text(
              widget.querySnapshot['name'],
              style: const TextStyle(
                fontWeight: FontWeight.w900,
                color: Colors.black87,
                fontSize: 30,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth / 20,
            ),
            child: Text(
              widget.querySnapshot['price'],
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                color: Colors.black87,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
