// import 'package:diplom_flutter/screens/home_screen.dart';
// import 'package:email_validator/email_validator.dart';
// import 'package:flutter/material.dart';
// import 'package:diplom_flutter/core/colors.dart';
// import 'package:diplom_flutter/core/space.dart';
// import 'package:diplom_flutter/core/text_style.dart';
// import 'package:diplom_flutter/page/sign_up.dart';
// import 'package:diplom_flutter/widget/main_button.dart';
// import 'package:diplom_flutter/widget/text_fild.dart';
// import 'package:diplom_flutter/screens/btm_bar.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:sizer/sizer.dart';

// import '../screens/reset_password_screen.dart';

// import '../services/snack_bar.dart';
// import 'google.dart';
// import 'login_with_google.dart';

// class LoginPage extends StatefulWidget {
//   const LoginPage({Key? key}) : super(key: key);

//   @override
//   _LoginPageState createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   bool isHiddenPassword = true;
//   TextEditingController userName = TextEditingController();
//   TextEditingController userPass = TextEditingController();
//   final formKey = GlobalKey<FormState>();

//   @override
//   void dispose() {
//     userName.dispose();
//     userPass.dispose();

//     super.dispose();
//   }

//   void togglePasswordView() {
//     setState(() {
//       isHiddenPassword = !isHiddenPassword;
//     });
//   }

//   Future<void> login() async {
//     // if (FirebaseAuth.instance.currentUser != null) {

//     // } else {
//     final navigator = Navigator.of(context);

//     final isValid = formKey.currentState!.validate();
//     if (!isValid) return;

//     try {
//       await FirebaseAuth.instance.signInWithEmailAndPassword(
//         email: userName.text.trim(),
//         password: userPass.text.trim(),
//       );
//     } on FirebaseAuthException catch (e) {
//       print(e.code);

//       if (e.code == 'user-not-found' || e.code == 'wrong-password') {
//         SnackBarService.showSnackBar(
//           context,
//           'Неправильный email или пароль. Повторите попытку',
//           true,
//         );
//         return;
//       } else {
//         SnackBarService.showSnackBar(
//           context,
//           'Неизвестная ошибка! Попробуйте еще раз или обратитесь в поддержку.',
//           true,
//         );
//         return;
//       }
//     }
//     navigator.push(MaterialPageRoute(
//         builder: (BuildContext context) => const BotomBarScreen()));
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (FirebaseAuth.instance.currentUser != null) {
//       return BotomBarScreen();
//     } else {
//       return Scaffold(
//         resizeToAvoidBottomInset: false,
//         backgroundColor: const Color.fromRGBO(29, 65, 53, 1),
//         body: Padding(
//           padding: EdgeInsets.only(top: 50.0),
//           child: Form(
//             key: formKey,
//             child: Column(
//               children: [
//                 SpaceVH(height: 50.0),
//                 const Text(
//                   'С возвращением!',
//                   style: headline1,
//                 ),
//                 SpaceVH(height: 10),
//                 const Text(
//                   'Пожалуйста, войдите в свою учетную запись',
//                   style: headline3,
//                 ),
//                 SpaceVH(height: 50.0),
//                 TextFormField(
//                   style: TextStyle(color: Colors.white),
//                   keyboardType: TextInputType.emailAddress,
//                   autocorrect: false,
//                   controller: userName,
//                   validator: (email) =>
//                       email != null && !EmailValidator.validate(email)
//                           ? 'Введите правильный Email'
//                           : null,
//                   decoration: InputDecoration(
//                     fillColor: const Color.fromRGBO(162, 96, 17, 1),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(50.0),
//                       borderSide: const BorderSide(
//                           color: Color.fromRGBO(237, 218, 195, 1)),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(25.0),
//                       borderSide: const BorderSide(
//                         width: 2,
//                         color: Color.fromRGBO(237, 218, 195, 1),
//                       ),
//                     ),
//                     hintText: 'Введите Email',
//                     hintStyle: const TextStyle(color: Colors.white),
//                   ),
//                 ),
//                 SizedBox(height: 20),
//                 TextFormField(
//                   style: const TextStyle(color: Colors.white),
//                   autocorrect: false,
//                   controller: userPass,
//                   obscureText: isHiddenPassword,
//                   validator: (value) => value != null && value.length < 6
//                       ? 'Минимум 6 символов'
//                       : null,
//                   autovalidateMode: AutovalidateMode.onUserInteraction,
//                   decoration: InputDecoration(
//                     fillColor: const Color.fromRGBO(162, 96, 17, 1),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(50.0),
//                       borderSide: const BorderSide(
//                         color: Color.fromRGBO(237, 218, 195, 1),
//                       ),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(25.0),
//                       borderSide: const BorderSide(
//                         width: 2,
//                         color: Color.fromRGBO(237, 218, 195, 1),
//                       ),
//                     ),
//                     hintText: 'Введите пароль',
//                     hintStyle: TextStyle(color: Colors.white),
//                     suffix: InkWell(
//                       onTap: togglePasswordView,
//                       child: Icon(
//                         isHiddenPassword
//                             ? Icons.visibility_off
//                             : Icons.visibility,
//                         color: Color.fromARGB(255, 214, 184, 184),
//                       ),
//                     ),
//                   ),
//                 ),
//                 SpaceVH(height: 10.0),
//                 Align(
//                   alignment: Alignment.centerRight,
//                   child: Padding(
//                     padding: EdgeInsets.only(right: 20.0),
//                     child: TextButton(
//                       onPressed: () {
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (builder) =>
//                                     const ResetPasswordScreen()));
//                       },
//                       child: const Text(
//                         'Забыли пароль?',
//                         style: headline3,
//                       ),
//                     ),
//                   ),
//                 ),
//                 SpaceVH(height: 50.0),
//                 Align(
//                   alignment: Alignment.bottomCenter,
//                   child: Column(
//                     children: [
//                       Mainbutton(
//                         onTap: () {
//                           login();
//                         },
//                         text: 'Войти',
//                         txtColor: Color.fromRGBO(0, 0, 0, 1),
//                         btnColor: Color.fromRGBO(237, 218, 195, 1),
//                       ),
//                       SpaceVH(height: 20.0),
//                       Mainbutton(
//                         onTap: () {
//                           Navigator.of(context).push(MaterialPageRoute(
//                               builder: (context) => Google()));
//                         },
//                         text: 'Войти с помощью Google',
//                         image: 'google.png',
//                         btnColor: white,
//                         txtColor: const Color.fromRGBO(29, 65, 53, 1),
//                       ),
//                       SpaceVH(height: 20.0),
//                       TextButton(
//                         onPressed: () {
//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (builder) => const SignUpPage()));
//                         },
//                         child: RichText(
//                           text: TextSpan(children: [
//                             TextSpan(
//                               text: 'Еще нет аккаунта? ',
//                               style: headline.copyWith(
//                                 fontSize: 14.0,
//                               ),
//                             ),
//                             TextSpan(
//                               text: ' Зарегестрируйтесь',
//                               style: headlineDot.copyWith(
//                                 fontSize: 14.0,
//                               ),
//                             ),
//                           ]),
//                         ),
//                       )
//                     ],
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ),
//       );
//     }
//   }
// }
