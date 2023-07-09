import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';

import '../core/colors.dart';
import '../data/detail_page.dart';
import '../data/detail_suvenir.dart';

class SuvenirPage extends StatefulWidget {
  const SuvenirPage({super.key});

  @override
  State<SuvenirPage> createState() => _SuvenirPageState();
}

class _SuvenirPageState extends State<SuvenirPage>
    with SingleTickerProviderStateMixin {
  double screenWidth = 0;
  double screenHeight = 0;
  final db = FirebaseFirestore.instance;
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

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
                      const EdgeInsets.only(left: 2.0, right: 10.0, bottom: 12),
                  child: Container(
                    height: 500,
                    child: GridView.count(
                      crossAxisCount: 2, // Количество колонок
                      childAspectRatio: 350 / 390,
                      crossAxisSpacing:
                          10, // Отступы между ячейками по горизонтали
                      mainAxisSpacing:
                          10, // Соотношение сторон дочерних элементов
                      padding: EdgeInsets.zero,
                      children: List.generate(
                        snapshot.data.docs.length,
                        (index) {
                          return GestureDetector(
                            onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => DetailPageSuvenir(
                                  querySnapshot: snapshot.data.docs[index],
                                ),
                              ),
                            ),
                            child: Stack(
                              children: [
                                Hero(
                                  tag: "trail$index",
                                  child: Container(
                                      height: 360,
                                      width: 350,
                                      margin:
                                          EdgeInsets.only(left: 10, bottom: 12),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(35),
                                        image: DecorationImage(
                                            image: NetworkImage(snapshot
                                                .data.docs[index]['image']),
                                            fit: BoxFit.cover),
                                      )),
                                ),
                                Container(
                                    height: 360,
                                    width: 350,
                                    margin: EdgeInsets.only(left: 10),
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
                                            0.8,
                                          ],
                                        ))),
                                Positioned(
                                    top: 16,
                                    left: 14,
                                    child: GlassmorphicContainer(
                                      height: 30,
                                      width: 70,
                                      margin: EdgeInsets.only(left: 10),
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
                                        snapshot.data.docs[index]['price'] +
                                            ' ₽',
                                        // docs[0]['subtitle']
                                        style: const TextStyle(
                                            fontSize: 13,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )),
                                Positioned(
                                  bottom: 12,
                                  left: 24,
                                  child: Container(
                                    margin: EdgeInsets.only(left: 2),
                                    width: size.width / 2,
                                    child: Text(
                                      snapshot.data.docs[index]['name'],
                                      style: const TextStyle(
                                          fontSize: 18,
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
                )
              ],
            );
          }),
    );
  }
}
