import 'dart:async';

import 'package:diplom_flutter/const/theme_data.dart';
import 'package:diplom_flutter/page/login_page.dart';
import 'package:diplom_flutter/page/sign_up.dart';
import 'package:diplom_flutter/page/splash_Page.dart';
import 'package:diplom_flutter/page/verify_email_screen.dart';
import 'package:diplom_flutter/phoneAyth/auth_provider.dart';
import 'package:diplom_flutter/phoneAyth/user_model.dart';
import 'package:diplom_flutter/phoneAyth/welcome_screen.dart';
import 'package:diplom_flutter/provider/dark_theme_provider.dart';
import 'package:diplom_flutter/screens/btm_bar.dart';
import 'package:diplom_flutter/screens/reset_password_screen.dart';
import 'package:diplom_flutter/screens/user.dart';
import 'package:diplom_flutter/services/firebase_streem.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'data/phone.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  DarkThemeProvider themeChangeProvider = DarkThemeProvider();

  void getCurrentAppTheme() async {
    themeChangeProvider.setDarkTheme =
        await themeChangeProvider.darkThemePrefs.getTheme();
  }

  @override
  Widget build(BuildContext context) {
    bool _isDark = false;

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) {
          return themeChangeProvider;
        }),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child:
          Consumer<DarkThemeProvider>(builder: (context, themeProvider, child) {
        return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: Styles.themeData(themeProvider.getDarlTheme, context),
            home: const WelcomeScreen());
      }),
    );
  }
}
