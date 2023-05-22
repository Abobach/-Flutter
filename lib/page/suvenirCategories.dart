import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';

import '../core/colors.dart';
import '../data/detail_page.dart';

class SuvenirPage extends StatefulWidget {
  const SuvenirPage({super.key});

  @override
  State<SuvenirPage> createState() => _SuvenirPageState();
}

class _SuvenirPageState extends State<SuvenirPage> {
  final db = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Сувениры"),
        backgroundColor: const Color.fromRGBO(29, 65, 53, 1),
      ),
      body: StreamBuilder(
          stream: db.collection("suvenirs").snapshots(),
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
                    "Сувениры ручной работы только у нас",
                    style: TextStyle(fontSize: 28, color: black),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(height: 20),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 15.0, right: 8.0, bottom: 12),
                  child: Container(
                    height: 700,
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: 6,
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
                                    width: 350,
                                    margin:
                                        EdgeInsets.only(left: 24, bottom: 13),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(35),
                                      image: const DecorationImage(
                                          image: AssetImage(
                                              "assets/image/coffe.jpg"),
                                          fit: BoxFit.cover),
                                    )),
                              ),
                              Container(
                                  height: 360,
                                  width: 350,
                                  margin: EdgeInsets.only(left: 24),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(35),
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
                                  top: 34,
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
                                      snapshot.data.docs[index]['price'],
                                      // docs[0]['subtitle']
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
                                    snapshot.data.docs[index]['name'],
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
                ),
              ],
            );
          }),
    );
  }
}
