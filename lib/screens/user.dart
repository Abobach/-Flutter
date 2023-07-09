import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diplom_flutter/core/text_style.dart';
import 'package:diplom_flutter/data/IsFavorites.dart';
import 'package:diplom_flutter/screens/reset_password_screen.dart';
import 'package:diplom_flutter/screens/updateInfo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:diplom_flutter/provider/dark_theme_provider.dart';
import 'package:provider/provider.dart';
import '../phoneAyth/auth_provider.dart';
import '../phoneAyth/register_screen.dart';
import '../phoneAyth/user_information_screen.dart';
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
          title: Text("Профиль"),
        ),
        body: SingleChildScrollView(
            child: Center(
                child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (ap.isSignedIn == true)
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
                    decoration:
                        BoxDecoration(color: Color.fromRGBO(29, 65, 53, 1)),
                  ),
                ],
              )
            else
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterScreen()),
                  );
                },
                child: Text(
                  'Войти',
                  style: TextStyle(color: const Color.fromRGBO(29, 65, 53, 1)),
                ),
              ),
            SizedBox(height: 40),
            _listTiles(
                title: 'Редактировать профиль',
                subtitle: 'Возможность изменить данные',
                icon: IconlyBold.profile,
                OnPressed: () async {
                  Map<String, dynamic>? updatedData = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditProfilePage(user: ap.userModel),
                    ),
                  );

                  if (updatedData != null) {
                    // Update the profile page with the updated data
                    setState(() {
                      // Update the profile page state using the updated data
                      // For example, assign the updated data to the profile data variables
                      ap.userModel.name = updatedData['name'];
                      ap.userModel.email = updatedData['email'];
                      ap.userModel.bio = updatedData['bio'];
                    });
                  }
                }),
            _listTiles(
                title: 'Избранное',
                subtitle: 'Ваше избранное',
                icon: IconlyBold.activity,
                OnPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (builder) => FavoritesPage(
                                userId: ap.userModel.uid,
                              )));
                }),
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
        ))));
  }
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
