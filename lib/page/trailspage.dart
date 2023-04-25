import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TrailsPage extends StatefulWidget {
  final querySnapshot;

  TrailsPage({required this.querySnapshot});

  @override
  State<TrailsPage> createState() => _TrailsPageState();
}

class _TrailsPageState extends State<TrailsPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Hero(
            tag: "trail${widget.querySnapshot}",
            child: Image.network(widget.querySnapshot['image'],
                height: size.height, width: size.width, fit: BoxFit.cover),
          ),
          Container(
              height: size.height,
              width: size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(35),
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black,
                    ],
                    stops: [
                      0.6,
                      0.9,
                    ],
                  ))),
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: const Padding(
              padding:
                  EdgeInsets.only(top: 64.0, bottom: 0.0, left: 28, right: 28),
              child: Icon(
                Icons.arrow_back_ios,
                size: 34,
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            bottom: 300.0,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.querySnapshot['title'],
                    style: const TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  Container(
                    height: 400,
                    width: 300,
                    child: Text(
                      widget.querySnapshot['subtitle'],
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
