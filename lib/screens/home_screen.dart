import 'package:diplom_flutter/page/login_page.dart';
import 'package:diplom_flutter/provider/dark_theme_provider.dart';
import 'package:diplom_flutter/screens/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../data/coffee_shop.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _Index = 0;

  @override
  Widget build(BuildContext context) {
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
                                "Добро пожаловать!",
                                style: GoogleFonts.montserrat(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          Container(
                              alignment: Alignment.topRight,
                              child: const Icon(
                                Icons.notifications_active,
                                color: Colors.white,
                                size: 30,
                              )),
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
                height: 125.0,
                child: ListView(scrollDirection: Axis.horizontal, children: [
                  _buildImage('assets/assets1/coffee.jpg'),
                  _buildImage('assets/assets1/coffee2.jpg'),
                  _buildImage('assets/assets1/coffee3.jpg')
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
                  _buildImage('assets/assets1/coffee.jpg'),
                  _buildImage('assets/assets1/coffee2.jpg'),
                  _buildImage('assets/assets1/coffee3.jpg')
                ])),
            SizedBox(height: 20.0),
          ],
        )),
      ),
    );
  }

  _buildImage(String imgPath) {
    return Padding(
        padding: EdgeInsets.only(right: 15.0),
        child: Container(
            height: 100.0,
            width: 275.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                image: DecorationImage(
                    image: AssetImage(imgPath), fit: BoxFit.cover))));
  }
}
