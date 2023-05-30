import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diplom_flutter/data/YabdexMapPage.dart';
import 'package:diplom_flutter/widget/geolocation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailPage extends StatefulWidget {
  final querySnapshot;
  DetailPage({Key? key, required this.querySnapshot}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  // Пользовательские дефолтные координаты.
  final db = FirebaseFirestore.instance;
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double widht = MediaQuery.of(context).size.width;
    return Scaffold(
      body: StreamBuilder(
          stream: db.collection("categories").snapshots(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData)
              return Center(
                  child: CircularProgressIndicator(
                backgroundColor: Colors.grey[200], // цвет фона индикатора
                valueColor: AlwaysStoppedAnimation<Color>(
                    Colors.blue), // цвет индикатора
                strokeWidth: 6,
              ));
            return SingleChildScrollView(
              child: SafeArea(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Container(
                        height: height * 0.3,
                        width: double.infinity,
                        child: Image.network(
                          widget.querySnapshot['image'],
                        ),
                      ),
                      Positioned(
                          top: 16,
                          left: 16,
                          child: Container(
                            child: Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                            padding: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(
                                color: Colors.grey,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                          )),
                      Positioned(
                          top: 16,
                          right: 16,
                          child: Container(
                            child: Icon(
                              Icons.assistant_direction,
                              color: Colors.white,
                            ),
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                          )),
                      Container(
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Text(
                              widget.querySnapshot['title'],
                              style: GoogleFonts.montserrat(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                          height: height * .07,
                          width: double.infinity,
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20))))
                    ],
                  ),
                  // Row rating dan jam buka
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text("4.6 (32 оценки)",
                                style: GoogleFonts.montserrat(fontSize: 12))
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.access_time,
                              color: Colors.grey,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text("10.00 - 22.00",
                                style: GoogleFonts.montserrat(fontSize: 12))
                          ],
                        )
                      ],
                    ),
                  ),

                  // Card promo
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      color: Colors.amber[100],
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Text(
                                  "Внимания!",
                                  style: GoogleFonts.montserrat(fontSize: 12),
                                ),
                                Text("Посмотреть маршрут",
                                    style:
                                        GoogleFonts.montserrat(fontSize: 11)),
                              ],
                            ),
                            ElevatedButton(
                                onPressed: () {},
                                child: Text("Посмотреть маршрут")),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Alamat
                  TitleDetail(
                    detail: widget.querySnapshot['opis'],
                    title: 'Экскурсия',
                  ),

                  // Deskripsi
                  TitleDetail(
                    detail: widget.querySnapshot['subtitle'],
                    title: 'Описание',
                  ),
                  Container(
                      height: 220.0,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 1,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => YandexMapPage(
                                        querySnapshot:
                                            snapshot.data.docs[index]))),
                            child: Stack(children: [Text('data')]),
                          );
                        },
                      )),

                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      "Отзывы и оценка",
                      style: GoogleFonts.montserrat(
                          fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ),

                  // Widget Ulasan / Comment
                  Comment(), Comment(), Comment(), Comment()
                ],
              )),
            );
          }),
    );
  }

  /// Поиск местоположения

  /// Создания дороги.

  /// Поиск местоположения
}

class Comment extends StatelessWidget {
  const Comment({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              Image.network(
                "https://oliver-andersen.se/wp-content/uploads/2018/03/cropped-Profile-Picture-Round-Color.png",
                width: 40,
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Артем Кумакшев",
                      style: GoogleFonts.montserrat(fontSize: 12)),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber),
                      Icon(Icons.star, color: Colors.amber),
                      Icon(Icons.star, color: Colors.amber),
                      Icon(Icons.star, color: Colors.amber)
                    ],
                  )
                ],
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
              style: GoogleFonts.montserrat(fontSize: 12),
              " is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, ")
        ],
      ),
    );
  }
}

class TitleDetail extends StatelessWidget {
  final String title;
  final String detail;
  const TitleDetail({Key? key, required this.title, required this.detail})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.montserrat(
                fontSize: 12, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          Text(detail, style: GoogleFonts.montserrat(fontSize: 12))
        ],
      ),
    );
  }
}
