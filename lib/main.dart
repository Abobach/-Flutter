import 'dart:async';

import 'package:diplom_flutter/const/theme_data.dart';
import 'package:diplom_flutter/page/login_page.dart';
import 'package:diplom_flutter/page/sign_up.dart';
import 'package:diplom_flutter/page/splash_Page.dart';
import 'package:http/http.dart' as http;

import 'package:diplom_flutter/page/verify_email_screen.dart';
import 'package:diplom_flutter/provider/dark_theme_provider.dart';
import 'package:diplom_flutter/screens/btm_bar.dart';

import 'package:diplom_flutter/screens/reset_password_screen.dart';
import 'package:diplom_flutter/screens/user.dart';

import 'package:diplom_flutter/services/firebase_streem.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  String _ipAddress = 'Неизвестно';

  @override
  void initState() {
    super.initState();
    getCurrentAppTheme();
    _getIpAddress();
  }

  Future<void> _getIpAddress() async {
    var response = await http.get(Uri.parse('http://ip-api.com/json/'));
    setState(() {
      _ipAddress = response.body.toString();
    });
    print('IP-адрес устройства: $_ipAddress');
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
        })
      ],
      child:
          Consumer<DarkThemeProvider>(builder: (context, themeProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: Styles.themeData(themeProvider.getDarlTheme, context),
          routes: {
            '/': (context) => const FirebaseStream(),
            '/home': (context) => const BotomBarScreen(),
            '/account': (context) => const UserScreen(),
            '/login': (context) => const LoginPage(),
            '/signup': (context) => const SignUpPage(),
            '/reset_password': (context) => const ResetPasswordScreen(),
            '/verify_email': (context) => const VerifyEmailScreen(),
          },
          initialRoute: '/',
        );
      }),
    );
  }
}
