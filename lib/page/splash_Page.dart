import 'package:flutter/material.dart';
import 'package:diplom_flutter/core/colors.dart';
import 'package:diplom_flutter/core/space.dart';
import 'package:diplom_flutter/core/text_style.dart';
import 'package:diplom_flutter/data/demo.dart';
import 'package:diplom_flutter/page/login_page.dart';
import 'package:diplom_flutter/widget/main_button.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: white,
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: height,
                color: const Color.fromRGBO(29, 65, 53, 1),
                child: Image.asset(
                  'assets/image/coffe.jpg',
                  height: height,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: height / 3,
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: gradient,
                  begin: Alignment.center,
                  end: Alignment.topCenter,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                    text: const TextSpan(children: [
                      TextSpan(
                        text: 'История Места',
                        style: headline,
                      ),
                    ]),
                  ),
                  SpaceVH(height: 20.0),
                  const Text(
                    splashText,
                    textAlign: TextAlign.center,
                    style: headline2,
                  ),
                  Mainbutton(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (builder) => LoginPage()));
                    },
                    btnColor: blueButton,
                    text: 'Присоединиться к нам',
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
