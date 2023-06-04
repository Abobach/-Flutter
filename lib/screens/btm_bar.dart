import 'package:diplom_flutter/phoneAyth/home_screen.dart';
import 'package:diplom_flutter/screens/categories.dart';
import 'package:diplom_flutter/screens/home_screen.dart';

import 'package:diplom_flutter/screens/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import '../provider/dark_theme_provider.dart';
import '../services/category.dart';
import 'categories_TestPage.dart';

class BotomBarScreen extends StatefulWidget {
  const BotomBarScreen({super.key});

  @override
  State<BotomBarScreen> createState() => _BotomBarScreenState();
}

class _BotomBarScreenState extends State<BotomBarScreen> {
  int _selectIndex = 0;
  final List<Map<String, dynamic>> _pages = [
    {'page': const HomeScreen(), 'title': 'Главная страница'},
    {
      'page': CategoriyScreenTest(
        index: 1,
        onPress: () {},
      ),
      'title': 'Категории'
    },
    {'page': UserScreen(), 'title': 'Профиль'},
  ];
  void _selectPage(int index) {
    setState(() {
      _selectIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final themeState = Provider.of<DarkThemeProvider>(context);
    bool _isDark = themeState.getDarlTheme;
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(_pages[_selectIndex]['title']),
      // ),
      body: _pages[_selectIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: _isDark
            ? Theme.of(context).cardColor
            : const Color.fromRGBO(29, 65, 53, 1),
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectIndex,
        unselectedItemColor: _isDark
            ? Color.fromRGBO(237, 218, 195, 1)
            : Color.fromRGBO(237, 218, 195, 1),
        selectedItemColor: _isDark
            ? Color.fromRGBO(237, 218, 195, 1)
            : Color.fromRGBO(237, 218, 195, 1),
        onTap: _selectPage,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon:
                  Icon(_selectIndex == 0 ? IconlyBold.home : IconlyLight.home),
              label: "Главная"),
          BottomNavigationBarItem(
              icon: Icon(_selectIndex == 1
                  ? IconlyBold.category
                  : IconlyLight.category),
              label: "Категории"),
          BottomNavigationBarItem(
              icon: Icon(
                  _selectIndex == 2 ? IconlyBold.user2 : IconlyLight.user2),
              label: "Профиль"),
        ],
      ),
    );
  }
}
