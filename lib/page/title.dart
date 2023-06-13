// import 'package:flutter/material.dart';

import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diplom_flutter/core/colors.dart';
import 'package:diplom_flutter/core/text_style.dart';
import 'package:diplom_flutter/page/trailspage.dart';
import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';

import '../data/YabdexMapPage.dart';
import '../data/detail_page.dart';

final FirebaseFirestore firestore = FirebaseFirestore.instance;

class TitlePage extends StatefulWidget {
  const TitlePage({super.key});

  @override
  State<TitlePage> createState() => _TitlePageState();
}

class _TitlePageState extends State<TitlePage> {
  CollectionReference collectionReference = firestore.collection('City');

  Timer? _timer;
  Map<String, dynamic> randomDocumentData = {};

  @override
  void initState() {
    super.initState();
    startRandomDocumentSelection();
    selectRandomDocument();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void startRandomDocumentSelection() {
    const duration = Duration(minutes: 1);
    _timer = Timer.periodic(duration, (Timer timer) {
      selectRandomDocument();
    });
  }

  void selectRandomDocument() async {
    QuerySnapshot snapshot = await collectionReference.get();

    if (snapshot.docs.isNotEmpty) {
      int randomIndex = Random().nextInt(snapshot.docs.length);
      DocumentSnapshot randomDocument = snapshot.docs[randomIndex];

      Map<String, dynamic>? data =
          randomDocument.data() as Map<String, dynamic>?;

      if (data != null) {
        setState(() {
          randomDocumentData = data;
        });
      }
    } else {
      setState(() {
        randomDocumentData = {};
      });
    }
  }

  final db = FirebaseFirestore.instance;
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: const Text("Экскурсии"),
          backgroundColor: const Color.fromRGBO(29, 65, 53, 1),
        ),
        body: SingleChildScrollView(
            child: StreamBuilder(
                stream: db.collection("categories").snapshots(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData)
                    return Center(child: CircularProgressIndicator());
                  return Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: const Text(
                          "Окунись в историю любимого города",
                          style: TextStyle(fontSize: 28, color: black),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const SizedBox(height: 20),
                      Container(
                        height: 300,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 4,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) => DetailPage(
                                          querySnapshot:
                                              snapshot.data.docs[index]))),
                              child: Stack(
                                children: [
                                  Hero(
                                    tag: "trail$index",
                                    child: Container(
                                        height: 360,
                                        width: 250,
                                        margin: EdgeInsets.only(left: 24),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(35),
                                          image: DecorationImage(
                                              image: NetworkImage(snapshot
                                                  .data.docs[index]['image']),
                                              fit: BoxFit.cover),
                                        )),
                                  ),
                                  Container(
                                      height: 360,
                                      width: 250,
                                      margin: EdgeInsets.only(left: 24),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(35),
                                          gradient: const LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: [
                                              Colors.transparent,
                                              Colors.grey,
                                            ],
                                            stops: [
                                              0.6,
                                              0.9,
                                            ],
                                          ))),
                                  Positioned(
                                    bottom: 32,
                                    left: 24,
                                    child: Container(
                                      margin: EdgeInsets.only(left: 24),
                                      width: size.width / 2,
                                      child: Text(
                                        snapshot.data.docs[index]['title'],
                                        style: const TextStyle(
                                            fontSize: 28,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 10,
                        width: size.width,
                        decoration: BoxDecoration(color: Colors.black),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text('Где можно прогуляться?',
                          style: TextStyle(fontSize: 28, color: black)),
                      SizedBox(
                        height: 6,
                      ),
                      Text('Подборка интересных мест для вас и вашей семьи',
                          style: TextStyle(fontSize: 14, color: grayText)),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 10,
                        width: size.width,
                        decoration: BoxDecoration(color: Colors.black),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 500,
                        width: size.width,
                        decoration: BoxDecoration(),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Column(
                            children: [
                              Text(
                                randomDocumentData.isNotEmpty
                                    ? randomDocumentData['Name']
                                    : 'Нет данных',
                                style: TextStyle(fontSize: 28),
                              ),
                              if (randomDocumentData.isNotEmpty &&
                                  randomDocumentData.containsKey('image'))
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: 300,
                                    width: 400,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(40),
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                randomDocumentData['image']),
                                            fit: BoxFit.cover)),
                                  ),
                                ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(randomDocumentData['opis']),
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 10,
                        width: size.width,
                        decoration: BoxDecoration(color: Colors.black),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text("Маршруты нашего города",
                          style: TextStyle(fontSize: 28, color: black)),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 300,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 10,
                              blurRadius: 7,
                              offset:
                                  Offset(1, 5), // changes position of shadow
                            ),
                          ],
                        ),
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 4,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) => YandexMapPage(
                                          querySnapshot:
                                              snapshot.data.docs[index]))),
                              child: Stack(
                                children: [
                                  Container(
                                      height: 360,
                                      width: 250,
                                      margin: EdgeInsets.only(left: 24),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(35),
                                        image: DecorationImage(
                                            image: NetworkImage(snapshot
                                                .data.docs[index]['image']),
                                            fit: BoxFit.cover),
                                      )),
                                  Container(
                                      height: 360,
                                      width: 250,
                                      margin: EdgeInsets.only(left: 24),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(35),
                                          gradient: const LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: [
                                              Colors.transparent,
                                              Colors.grey,
                                            ],
                                            stops: [
                                              0.6,
                                              0.9,
                                            ],
                                          ))),
                                  Positioned(
                                      top: 24,
                                      left: 24,
                                      child: GlassmorphicContainer(
                                        height: 50,
                                        width: 210,
                                        margin: EdgeInsets.only(left: 24),
                                        blur: 8.0,
                                        border: 0.0,
                                        borderRadius: 8.0,
                                        alignment: Alignment.center,
                                        linearGradient: LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: [
                                              Colors.grey.withOpacity(0.4),
                                              Colors.grey.withOpacity(0.4),
                                            ]),
                                        borderGradient: LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: [
                                              Colors.grey.withOpacity(0.4),
                                              Colors.grey.withOpacity(0.4),
                                            ]),
                                        child: Text(
                                          "Показать маршрут",
                                          style: const TextStyle(
                                              fontSize: 18,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )),
                                  Positioned(
                                    bottom: 32,
                                    left: 24,
                                    child: Container(
                                      margin: EdgeInsets.only(left: 24),
                                      width: size.width / 2,
                                      child: Text(
                                        snapshot.data.docs[index]['title'],
                                        style: const TextStyle(
                                            fontSize: 28,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      )
                    ],
                  );
                })));
  }
}
