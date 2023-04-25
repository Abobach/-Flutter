// import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diplom_flutter/core/colors.dart';
import 'package:diplom_flutter/core/text_style.dart';
import 'package:diplom_flutter/page/trailspage.dart';
import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';

import '../data/detail_page.dart';

class TitlePage extends StatefulWidget {
  const TitlePage({super.key});

  @override
  State<TitlePage> createState() => _TitlePageState();
}

class _TitlePageState extends State<TitlePage> {
  final db = FirebaseFirestore.instance;
  int currentIndex = 0;
  List<String> category = [
    "Церкви",
    "Усадьбы",
    "Памятники",
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: const Text("Экскурсии"),
          backgroundColor: const Color.fromRGBO(29, 65, 53, 1),
        ),
        body: StreamBuilder(
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
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 6, horizontal: 6.0),
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: const TextField(
                              cursorColor: Colors.black12,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Поиск",
                                  prefixIcon: Icon(
                                    Icons.search,
                                    size: 34,
                                  )),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () => print("object"),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 16, horizontal: 16),
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(29, 65, 53, 1),
                              borderRadius: BorderRadius.circular(50)),
                          child: const Icon(
                            Icons.search,
                            color: Colors.white,
                            size: 34,
                          ),
                        ),
                      )
                    ],
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(
                        category.length,
                        (index) => GestureDetector(
                          onTap: () => setState(() {
                            currentIndex = index;
                          }),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 20.0, right: 10, top: 10),
                            child: Text(
                              category[index],
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: currentIndex == index
                                      ? Colors.black
                                      : Colors.grey),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    height: 400,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 2,
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
                                    height: 460,
                                    width: 350,
                                    margin: EdgeInsets.only(left: 24),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(35),
                                      image: const DecorationImage(
                                          image: AssetImage(
                                              "assets/image/coffe.jpg"),
                                          fit: BoxFit.cover),
                                    )),
                              ),
                              Container(
                                  height: 460,
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
                                      snapshot.data.docs[index]['subtitle'],
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
                ],
              );
            }));
  }
}
