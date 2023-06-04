import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diplom_flutter/core/text_style.dart';
import 'package:diplom_flutter/page/login_page.dart';
import 'package:diplom_flutter/provider/dark_theme_provider.dart';
import 'package:diplom_flutter/screens/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:vector_math/vector_math.dart' as math;

import '../data/coffee_shop.dart';
import '../phoneAyth/auth_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final db = FirebaseFirestore.instance;

  int _Index = 0;

  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    Size size = MediaQuery.of(context).size;
    final user = FirebaseAuth.instance.currentUser;
    final themeState = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                    height: 120,
                    width: double.infinity,
                    color: const Color.fromRGBO(29, 65, 53, 1)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                  alignment: Alignment.topLeft,
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                      image: const DecorationImage(
                                          image: AssetImage(
                                              "assets/image/logo.jpeg")),
                                      borderRadius: BorderRadius.circular(25),
                                      border: Border.all(
                                          color: Colors.white,
                                          style: BorderStyle.solid,
                                          width: 3))),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                ap.userModel.name,
                                style: GoogleFonts.montserrat(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Text(
                "Варим кофе с любовью для вас",
                style: GoogleFonts.montserrat(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
            Container(
                height: 255.0,
                child: ListView(scrollDirection: Axis.horizontal, children: [
                  _buildImage1('assets/assets1/coffee.jpg'),
                  _buildImage2('assets/assets1/coffee2.jpg'),
                  _buildImage3('assets/assets1/coffee3.jpg')
                ])),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Text(
                "Окунись в историю твоего любимого города",
                style: GoogleFonts.montserrat(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
            SizedBox(height: 20),
            const CoffeShop(
              imagePath: "assets/image/1.jpg",
              nameShop: "Волоколамский кремль",
              rating: "4.8",
              jamBuka: "10.00 - 23.00",
            ),
            const CoffeShop(
              imagePath: "assets/image/45.jpg",
              nameShop: "Ярополецкая ГЭС",
              rating: "4.9",
              jamBuka: "13.00 - 18.00",
            ),
            const CoffeShop(
              imagePath: "assets/image/2.jpeg",
              nameShop: "Мемориал героям-панфиловцам",
              rating: "4.7",
              jamBuka: "10.00 - 15.00",
            ),
            SizedBox(height: 30.0),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Дальше - Больше',
                    style: TextStyle(
                        fontFamily: 'varela',
                        fontSize: 17.0,
                        color: Color(0xFF473D3A)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: Text(
                      'Посмотреть все',
                      style: TextStyle(
                          fontFamily: 'varela',
                          fontSize: 15.0,
                          color: Color(0xFFCEC7C4)),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 15.0),
            Container(
                height: 125.0,
                child: ListView(scrollDirection: Axis.horizontal, children: [
                  _buildImage1('assets/assets1/coffee.jpg'),
                ])),
            SizedBox(height: 20.0),
          ],
        )),
      ),
    );
  }

  _buildImage1(String imgPath) {
    return Padding(
        padding: EdgeInsets.only(right: 1.0),
        child: StreamBuilder<Object>(
            stream: db.collection("coffe").snapshots(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData)
                return Center(
                    child: CircularProgressIndicator(
                  backgroundColor: Colors.grey[200], // цвет фона индикатора
                  valueColor: AlwaysStoppedAnimation<Color>(
                      Colors.blue), // цвет индикатора
                  strokeWidth: 6,
                ));
              return Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 1),
                child: Container(
                  height: 300.0,
                  width: 300,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 1,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () => showGeneralDialog(
                            barrierColor: Colors.black.withOpacity(0.5),
                            transitionBuilder: (context, a1, a2, widget) {
                              final curvedValue =
                                  Curves.easeInOutBack.transform(a1.value) -
                                      1.0;
                              return Transform(
                                transform: Matrix4.translationValues(
                                    0.0, curvedValue * 200, 0.0),
                                child: Opacity(
                                  opacity: a1.value,
                                  child: AlertDialog(
                                      shape: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(16.0)),
                                      title:
                                          Text('Авторсике напитки и десерты'),
                                      content: Stack(
                                        children: [
                                          Container(
                                            width: 320,
                                            height: 600,
                                            decoration: BoxDecoration(
                                              color: const Color.fromRGBO(
                                                  29, 65, 53, 1),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.5),
                                                  spreadRadius: 10,
                                                  blurRadius: 7,
                                                  offset: Offset(1,
                                                      5), // changes position of shadow
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 5.0, right: 5.0, top: 10),
                                            child: Container(
                                              height: 260,
                                              width: 320,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  image: DecorationImage(
                                                      image:
                                                          AssetImage(imgPath),
                                                      fit: BoxFit.cover)),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 300.0),
                                            child: Text(
                                                'Мы знаем толк в кофе и с удовольствием приготовим его для Вас.Вы можете попробовать наши авторские десерты, приготовленные по проверенным рецептам нашего шеф-повара.Даже самые маленькие гурманы не останутся равнодушными к нашей выпечке и десертам.',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: const Color.fromRGBO(
                                                        237, 218, 195, 1),
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          )
                                        ],
                                      )),
                                ),
                              );
                            },
                            transitionDuration: Duration(milliseconds: 200),
                            barrierDismissible: true,
                            barrierLabel: '',
                            context: context,
                            pageBuilder: (context, animation1, animation2) {
                              return Container();
                            }),
                        child: Stack(children: [
                          Padding(
                              padding:
                                  const EdgeInsets.only(right: 10.0, top: 15),
                              child: Container(
                                  height: 200,
                                  width: 275,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 20.0),
                                    child: Text(
                                      'Авторское кофе',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 28,
                                        color: Color.fromRGBO(29, 65, 53, 1),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Color.fromRGBO(237, 218, 195, 1),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 10,
                                        blurRadius: 7,
                                        offset: Offset(
                                            1, 5), // changes position of shadow
                                      ),
                                    ],
                                  ))),
                          Padding(
                            padding: const EdgeInsets.only(top: 80.0),
                            child: Container(
                              height: 150.0,
                              width: 275.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                image: DecorationImage(
                                    image: AssetImage(imgPath),
                                    fit: BoxFit.cover),
                              ),
                            ),
                          ),
                        ]),
                      );
                    },
                  ),
                ),
              );
            }));
  }

  _buildImage2(String imgPath) {
    return Padding(
        padding: EdgeInsets.only(right: 1.0),
        child: StreamBuilder<Object>(
            stream: db.collection("coffe").snapshots(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData)
                return Center(
                    child: CircularProgressIndicator(
                  backgroundColor: Colors.grey[200], // цвет фона индикатора
                  valueColor: AlwaysStoppedAnimation<Color>(
                      Colors.blue), // цвет индикатора
                  strokeWidth: 6,
                ));
              return Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 1),
                child: Container(
                  height: 300.0,
                  width: 300,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 1,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () => showGeneralDialog(
                            barrierColor: Colors.black.withOpacity(0.5),
                            transitionBuilder: (context, a1, a2, widget) {
                              final curvedValue =
                                  Curves.easeInOutBack.transform(a1.value) -
                                      1.0;
                              return Transform(
                                transform: Matrix4.translationValues(
                                    0.0, curvedValue * 200, 0.0),
                                child: Opacity(
                                  opacity: a1.value,
                                  child: AlertDialog(
                                      shape: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(16.0)),
                                      title: Text(
                                        'Уютная атмосфера',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 28,
                                          color: Color.fromRGBO(29, 65, 53, 1),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      content: Stack(
                                        children: [
                                          Container(
                                            width: 320,
                                            height: 600,
                                            decoration: BoxDecoration(
                                              color: const Color.fromRGBO(
                                                  29, 65, 53, 1),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.5),
                                                  spreadRadius: 10,
                                                  blurRadius: 7,
                                                  offset: Offset(1,
                                                      5), // changes position of shadow
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 5.0, right: 5.0, top: 10),
                                            child: Container(
                                              height: 260,
                                              width: 320,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  image: DecorationImage(
                                                      image:
                                                          AssetImage(imgPath),
                                                      fit: BoxFit.cover)),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 300.0),
                                            child: Text(
                                                'Интерьер, продуманный до малейших деталей, позволит комфортно провести время.',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Color.fromRGBO(
                                                        237, 218, 195, 1),
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          )
                                        ],
                                      )),
                                ),
                              );
                            },
                            transitionDuration: Duration(milliseconds: 200),
                            barrierDismissible: true,
                            barrierLabel: '',
                            context: context,
                            pageBuilder: (context, animation1, animation2) {
                              return Container();
                            }),
                        child: Stack(children: [
                          Padding(
                              padding:
                                  const EdgeInsets.only(right: 10.0, top: 15),
                              child: Container(
                                  height: 200,
                                  width: 275,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 20.0),
                                    child: Text(
                                      'Интерьер',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 28,
                                        color: Color.fromRGBO(29, 65, 53, 1),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Color.fromRGBO(237, 218, 195, 1),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 10,
                                        blurRadius: 7,
                                        offset: Offset(
                                            1, 5), // changes position of shadow
                                      ),
                                    ],
                                  ))),
                          Padding(
                            padding: const EdgeInsets.only(top: 80.0),
                            child: Container(
                              height: 150.0,
                              width: 275.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                image: DecorationImage(
                                    image: AssetImage(imgPath),
                                    fit: BoxFit.cover),
                              ),
                            ),
                          ),
                        ]),
                      );
                    },
                  ),
                ),
              );
            }));
  }

  _buildImage3(String imgPath) {
    return Padding(
        padding: EdgeInsets.only(right: 1.0),
        child: StreamBuilder<Object>(
            stream: db.collection("coffe").snapshots(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData)
                return Center(
                    child: CircularProgressIndicator(
                  backgroundColor: Colors.grey[200], // цвет фона индикатора
                  valueColor: AlwaysStoppedAnimation<Color>(
                      Colors.blue), // цвет индикатора
                  strokeWidth: 6,
                ));
              return Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 1),
                child: Container(
                  height: 300.0,
                  width: 300,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 1,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () => showGeneralDialog(
                            barrierColor: Colors.black.withOpacity(0.5),
                            transitionBuilder: (context, a1, a2, widget) {
                              final curvedValue =
                                  Curves.easeInOutBack.transform(a1.value) -
                                      1.0;
                              return Transform(
                                transform: Matrix4.translationValues(
                                    0.0, curvedValue * 200, 0.0),
                                child: Opacity(
                                  opacity: a1.value,
                                  child: AlertDialog(
                                      shape: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(16.0)),
                                      title: Text('Погружение в историю'),
                                      content: Stack(
                                        children: [
                                          Container(
                                            width: 320,
                                            height: 600,
                                            decoration: BoxDecoration(
                                              color: const Color.fromRGBO(
                                                  29, 65, 53, 1),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.5),
                                                  spreadRadius: 10,
                                                  blurRadius: 7,
                                                  offset: Offset(1,
                                                      5), // changes position of shadow
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 5.0, right: 5.0, top: 10),
                                            child: Container(
                                              height: 260,
                                              width: 320,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  image: DecorationImage(
                                                      image:
                                                          AssetImage(imgPath),
                                                      fit: BoxFit.cover)),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 300.0),
                                            child: Text(
                                                'Отсылки к историческим векам, великим людям и событиях создают неповторимый образ у пространства и причастности к истории места',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Color.fromRGBO(
                                                        237, 218, 195, 1),
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          )
                                        ],
                                      )),
                                ),
                              );
                            },
                            transitionDuration: Duration(milliseconds: 200),
                            barrierDismissible: true,
                            barrierLabel: '',
                            context: context,
                            pageBuilder: (context, animation1, animation2) {
                              return Container();
                            }),
                        child: Stack(children: [
                          Padding(
                              padding:
                                  const EdgeInsets.only(right: 10.0, top: 15),
                              child: Container(
                                  height: 200,
                                  width: 275,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 20.0),
                                    child: Text(
                                      'История города',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 28,
                                        color: Color.fromRGBO(29, 65, 53, 1),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Color.fromRGBO(237, 218, 195, 1),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 10,
                                        blurRadius: 7,
                                        offset: Offset(
                                            1, 5), // changes position of shadow
                                      ),
                                    ],
                                  ))),
                          Padding(
                            padding: const EdgeInsets.only(top: 80.0),
                            child: Container(
                              height: 150.0,
                              width: 275.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                image: DecorationImage(
                                    image: AssetImage(imgPath),
                                    fit: BoxFit.cover),
                              ),
                            ),
                          ),
                        ]),
                      );
                    },
                  ),
                ),
              );
            }));
  }
}
