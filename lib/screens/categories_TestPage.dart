import 'package:diplom_flutter/data/grid_cards.dart';
import 'package:diplom_flutter/page/Product.dart';
import 'package:diplom_flutter/page/title.dart';

import 'package:flutter/material.dart';

import '../CategoriesPage/coffe_detail_Page.dart';
import '../core/text_style.dart';
import '../data/cart.dart';
import 'coffeCategorys.dart';

class CategoriyScreenTest extends StatelessWidget {
  final int index;
  final void Function() onPress;
  CategoriyScreenTest({super.key, required this.index, required this.onPress});

  final carts = ["1", "2", "3"];

  @override
  Widget build(BuildContext context) {
    onCardPress() {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => TitlePage()));
    }

    onCoffePress() {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => CoffeCategorysPage()));
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(29, 65, 53, 1),
        title: const Text('Категории'),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Container(
                  height: 143,
                  margin: const EdgeInsets.only(
                      left: 10, right: 10, bottom: 13, top: 5),
                  // margin: index % 2 == 0
                  //     ? const EdgeInsets.only(left: 22)
                  //     : const EdgeInsets.only(right: 22),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(34),
                    image: const DecorationImage(
                      image: AssetImage('assets/image/maka.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: GestureDetector(
                    onTap: onCardPress,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(35),
                        child: const Center(
                          heightFactor: 3,
                          child: Text(
                            "Экскурсии",
                            style: headline1,
                          ),
                        )),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Container(
                  height: 143,
                  margin: const EdgeInsets.only(
                      left: 10, right: 10, bottom: 13, top: 5),
                  // margin: index % 2 == 0
                  //     ? const EdgeInsets.only(left: 22)
                  //     : const EdgeInsets.only(right: 22),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(34),
                    image: const DecorationImage(
                      image: AssetImage('assets/image/qwerty.jpeg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: GestureDetector(
                    onTap: onCoffePress,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(35),
                        child: const Center(
                          heightFactor: 3,
                          child: Text(
                            "Кофе и десерты",
                            style: headline1,
                          ),
                        )),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
