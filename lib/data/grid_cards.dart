import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../core/text_style.dart';

class GridCard extends StatelessWidget {
  final int index;
  final void Function() onPress;
  const GridCard({Key? key, required this.index, required this.onPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          height: 143,
          margin:
              const EdgeInsets.only(left: 10, right: 10, bottom: 13, top: 5),
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
            onTap: onPress,
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
    );
  }
}
