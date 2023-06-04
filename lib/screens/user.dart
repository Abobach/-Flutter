import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diplom_flutter/core/text_style.dart';
import 'package:diplom_flutter/screens/reset_password_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:diplom_flutter/provider/dark_theme_provider.dart';
import 'package:provider/provider.dart';

import '../phoneAyth/auth_provider.dart';
import '../phoneAyth/welcome_screen.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final ap = Provider.of<AuthProvider>(context, listen: false);
    // profileSet();
    final themeState = Provider.of<DarkThemeProvider>(context);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(29, 65, 53, 1),
          leading: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.arrow_back_ios),
            color: Color.fromRGBO(237, 218, 195, 1),
          ),
          title: Text("Профиль"),
        ),
        body: SingleChildScrollView(
            child: StreamBuilder(
                stream: db.collection("user").snapshots(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData)
                    return Center(
                      child: CircularProgressIndicator(
                        color: Colors.black12,
                      ),
                    );
                  return Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: 130,
                            width: 130,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: NetworkImage(ap.userModel.profilePic),
                                  fit: BoxFit.fill),
                            ),
                          ),
                          SizedBox(height: 20),
                          Text(
                            ap.userModel.name,
                            style: headline4,
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            'Общая информация',
                            style: TextStyle(color: Colors.grey),
                          ),
                          SizedBox(height: 10),
                          Container(
                            height: 200,
                            width: 300,
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(237, 218, 195, 1),
                              borderRadius: BorderRadius.circular(40),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 12.0),
                              child: Text(
                                ap.userModel.bio,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Color.fromRGBO(29, 65, 53, 1),
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: 6,
                            width: size.width,
                            decoration: BoxDecoration(
                                color: Color.fromRGBO(29, 65, 53, 1)),
                          ),
                        ],
                      ),
                      SizedBox(height: 40),
                      _listTiles(
                          title: 'Адресс',
                          subtitle: 'Изменить адрес',
                          icon: IconlyBold.profile,
                          OnPressed: () async {
                            try {
                              final result =
                                  await InternetAddress.lookup('example.com');
                              if (result.isNotEmpty &&
                                  result[0].rawAddress.isNotEmpty) {
                                print('connected');
                              }
                            } on SocketException catch (_) {
                              print('not connected');
                            }
                          }),
                      _listTiles(
                          title: 'Номер телефона',
                          subtitle: 'Изменить номер телефона',
                          icon: IconlyBold.call,
                          OnPressed: () {}),
                      _listTiles(
                          title: 'Мои места',
                          subtitle: 'места которые вы посетили',
                          icon: IconlyBold.activity,
                          OnPressed: () {}),
                      _listTiles(
                          title: 'Востановление пароля',
                          icon: IconlyBold.unlock,
                          OnPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (builder) =>
                                        ResetPasswordScreen()));
                          }),
                      SwitchListTile(
                        title: const Text('Темная тема'),
                        secondary: Icon(themeState.getDarlTheme
                            ? Icons.dark_mode_outlined
                            : Icons.light_mode_outlined),
                        onChanged: (bool value) {
                          setState(() {
                            themeState.setDarkTheme = value;
                          });
                        },
                        value: themeState.getDarlTheme,
                      ),
                      _listTiles(
                        title: 'Выход',
                        icon: IconlyBold.logout,
                        OnPressed: () {
                          ap.userSignOut().then(
                                (value) => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const WelcomeScreen(),
                                  ),
                                ),
                              );
                        },
                      )
                    ],
                  ));
                })));
  }

  Widget _listTiles({
    required String title,
    String? subtitle,
    required IconData icon,
    required Function OnPressed,
  }) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(subtitle == null ? "" : subtitle),
      leading: Icon(icon),
      trailing: const Icon(IconlyLight.arrowRight2),
      onTap: () {
        OnPressed();
      },
    );
  }
}
