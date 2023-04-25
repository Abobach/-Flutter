import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'detailPageCoffe.dart';

class CoffeCategorysPage extends StatefulWidget {
  @override
  _CoffeCategorysPageState createState() => _CoffeCategorysPageState();
}

class _CoffeCategorysPageState extends State<CoffeCategorysPage> {
  final db = FirebaseFirestore.instance;
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
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
              return ListView(
                padding: EdgeInsets.only(left: 15.0),
                children: <Widget>[
                  SizedBox(height: 60.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('Раздел кофе!',
                          style: TextStyle(
                              fontFamily: 'varela',
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF473D3A))),
                      Padding(
                          padding: EdgeInsets.only(right: 15.0),
                          child: Container(
                            height: 40.0,
                            width: 40.0,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                image: DecorationImage(
                                    image:
                                        AssetImage('assets/assets1/model.jpg'),
                                    fit: BoxFit.cover)),
                          ))
                    ],
                  ),
                  SizedBox(height: 10.0),
                  Padding(
                    padding: const EdgeInsets.only(right: 45.0),
                    child: Container(
                      child: Text(
                        'Давайте выберем лучший вкус для вашего следующего кофе-брейка!',
                        style: TextStyle(
                            fontFamily: 'nunito',
                            fontSize: 17.0,
                            fontWeight: FontWeight.w300,
                            color: Color(0xFFB0AAA7)),
                      ),
                    ),
                  ),
                  SizedBox(height: 25.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Вкус недели!',
                        style: TextStyle(
                            fontFamily: 'varela',
                            fontSize: 17.0,
                            color: Color(0xFF473D3A)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 15.0),
                        child: Text(
                          'Посмотреть все!',
                          style: TextStyle(
                              fontFamily: 'varela',
                              fontSize: 15.0,
                              color: Color(0xFFCEC7C4)),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  Container(
                      height: 460.0,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 2,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => DetailsPage(
                                        querySnapshot:
                                            snapshot.data.docs[index]))),
                            child: Stack(children: [
                              _coffeeListCard(
                                  'assets/assets1/starbucks.png',
                                  snapshot.data.docs[index]['name'],
                                  'История места',
                                  snapshot.data.docs[index]['opisanie'],
                                  '\170 ₽',
                                  false),
                            ]),
                          );
                        },
                      )),
                  SizedBox(height: 60.0),
                  Row(
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
                  SizedBox(height: 15.0),
                  Container(
                      height: 125.0,
                      child:
                          ListView(scrollDirection: Axis.horizontal, children: [
                        _buildImage('assets/assets1/coffee.jpg'),
                        _buildImage('assets/assets1/coffee2.jpg'),
                        _buildImage('assets/assets1/coffee3.jpg')
                      ])),
                  SizedBox(height: 20.0)
                ],
              );
            }));
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

  _coffeeListCard(String imgPath, String coffeeName, String shopName,
      String description, String price, bool isFavorite) {
    return Padding(
        padding: EdgeInsets.only(left: 10.0, right: 30.0),
        child: Container(
            height: 470.0,
            width: 250.0,
            child: Column(
              children: <Widget>[
                Stack(children: [
                  Container(height: 385.0),
                  Positioned(
                      top: 75.0,
                      child: Container(
                          padding: EdgeInsets.only(left: 10.0, right: 20.0),
                          height: 360.0,
                          width: 245.0,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25.0),
                              color: Color(0xFFDAB68C)),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(
                                  height: 60.0,
                                ),
                                Text(
                                  shopName + '\'s',
                                  style: TextStyle(
                                      fontFamily: 'nunito',
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                SizedBox(height: 10.0),
                                Text(
                                  coffeeName,
                                  style: TextStyle(
                                      fontFamily: 'varela',
                                      fontSize: 32.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                SizedBox(height: 10.0),
                                Text(
                                  description,
                                  style: TextStyle(
                                      fontFamily: 'nunito',
                                      fontSize: 14.0,
                                      // fontWeight: FontWeight.w300,
                                      color: Colors.white),
                                ),
                                SizedBox(height: 10.0),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      price,
                                      style: TextStyle(
                                          fontFamily: 'varela',
                                          fontSize: 25.0,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF3A4742)),
                                    ),
                                    Container(
                                        height: 40.0,
                                        width: 40.0,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                            color: Colors.white),
                                        child: Center(
                                            child: Icon(Icons.favorite,
                                                color: isFavorite
                                                    ? Colors.red
                                                    : Colors.grey,
                                                size: 15.0)))
                                  ],
                                )
                              ]))),
                  Positioned(
                      left: 60.0,
                      top: 25.0,
                      child: Container(
                          height: 100.0,
                          width: 100.0,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(imgPath),
                                  fit: BoxFit.contain))))
                ]),
                SizedBox(height: 10.0),
              ],
            )));
  }
}
