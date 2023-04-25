import 'package:diplom_flutter/data/grid_cards.dart';
import 'package:diplom_flutter/page/Product.dart';
import 'package:diplom_flutter/page/title.dart';

import 'package:flutter/material.dart';

class CategoriyScreen extends StatefulWidget {
  CategoriyScreen({super.key});

  @override
  State<CategoriyScreen> createState() => _CategoriyScreenState();
}

class _CategoriyScreenState extends State<CategoriyScreen> {
  final carts = ["1", "2", "3"];

  @override
  Widget build(BuildContext context) {
    onCardPress() {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => TitlePage()));
    }

    // return Container(
    //   child: GridView.builder(
    //       itemCount: carts.length,
    //       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    //           crossAxisCount: 2, mainAxisSpacing: 30, crossAxisSpacing: 30),
    //       itemBuilder: (BuildContext context, int index) {
    //         return GridCard(
    //             index: index,
    //             onPress: () {
    //               Navigator.push(
    //                   context,
    //                   MaterialPageRoute(
    //                       builder: (context) => const ProductScreen()));
    //             });
    //       }),
    // );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(29, 65, 53, 1),
        title: const Text('Категории'),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(vertical: 30),
              itemCount: carts.length,
              itemBuilder: (context, index) {
                return GridCard(index: index, onPress: onCardPress);
              })
        ]),
      ),
    );
  }
}
