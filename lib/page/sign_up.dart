import 'package:diplom_flutter/page/login_page.dart';
import 'package:diplom_flutter/page/verify_email_screen.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:diplom_flutter/core/colors.dart';

import 'package:diplom_flutter/core/space.dart';
import 'package:diplom_flutter/core/text_style.dart';
import 'package:diplom_flutter/widget/main_button.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../services/firebase_streem.dart';
import '../services/snack_bar.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool isHiddenPassword = true;
  TextEditingController userEmail = TextEditingController();
  TextEditingController userPass = TextEditingController();
  TextEditingController userPassRepet = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    userEmail.dispose();
    userPass.dispose();
    userPassRepet.dispose();

    super.dispose();
  }

  void togglePasswordView() {
    setState(() {
      isHiddenPassword = !isHiddenPassword;
    });
  }

  Future<void> signUp() async {
    final navigator = Navigator.of(context);

    final isValid = formKey.currentState!.validate();
    if (!isValid) return;
    // final isValid = formKey.currentState!.validate();
    // if (!isValid) return;

    if (userPass.text != userPassRepet.text) {
      SnackBarService.showSnackBar(
        context,
        'Пароли должны совпадать',
        true,
      );
      return;
    }

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: userEmail.text.trim(),
        password: userPass.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      print(e.code);

      if (e.code == 'email-already-in-use') {
        SnackBarService.showSnackBar(
          context,
          'Такой Email уже используется, повторите попытку с использованием другого Email',
          true,
        );
        return;
      } else {
        SnackBarService.showSnackBar(
          context,
          'Неизвестная ошибка! Попробуйте еще раз или обратитесь в поддержку.',
          true,
        );
      }
    }

    navigator.push(MaterialPageRoute(
        builder: (BuildContext context) => const VerifyEmailScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/image/maka.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
              bottom: 150.0, left: 10.0, right: 10.0, top: 27),
          child: Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Container(
              decoration: BoxDecoration(
                  color: const Color.fromARGB(156, 150, 149, 149),
                  borderRadius: BorderRadius.circular(50)),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    // const Padding(
                    //   padding: EdgeInsets.only(top: 35.0),
                    //   child: Image(
                    //     image: AssetImage('assets/image/logo3.png'),
                    //     fit: BoxFit.fitHeight,
                    //   ),
                    // ),
                    const SpaceVH(height: 20.0),
                    const Text(
                      'Регистрация',
                      style: headline4,
                    ),
                    const SpaceVH(height: 10.0),
                    const Padding(
                      padding: EdgeInsets.only(left: 20.0),
                      child: Text(
                        'Окунись в историю города вместе с нами!',
                        style: headline3,
                      ),
                    ),
                    const SpaceVH(height: 20.0),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 10, left: 20.0, right: 20),
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        autocorrect: false,
                        controller: userEmail,
                        validator: (email) =>
                            email != null && !EmailValidator.validate(email)
                                ? 'Введите правильный Email'
                                : null,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50.0),
                            borderSide: const BorderSide(
                              color: Color.fromRGBO(237, 218, 195, 1),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: const BorderSide(
                              width: 2,
                              color: Color.fromRGBO(29, 65, 53, 1),
                            ),
                          ),
                          hintText: 'Введите ваш e-mail',
                          hintStyle: const TextStyle(
                              color: Color.fromARGB(255, 66, 66, 66)),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 10, left: 20.0, right: 20),
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        autocorrect: false,
                        controller: userPass,
                        obscureText: isHiddenPassword,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) => value != null && value.length < 6
                            ? 'Минимум 6 символов'
                            : null,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50.0),
                            borderSide: const BorderSide(
                              color: Color.fromRGBO(237, 218, 195, 1),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: const BorderSide(
                              width: 2,
                              color: Color.fromRGBO(29, 65, 53, 1),
                            ),
                          ),
                          hintText: 'Пароль',
                          suffix: InkWell(
                            onTap: togglePasswordView,
                            child: Icon(
                              isHiddenPassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.black,
                            ),
                          ),
                          hintStyle: const TextStyle(
                              color: Color.fromARGB(255, 66, 66, 66)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 10, left: 20.0, right: 20, bottom: 15),
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        autocorrect: false,
                        controller: userPassRepet,
                        obscureText: isHiddenPassword,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) => value != null && value.length < 6
                            ? 'Минимум 6 символов'
                            : null,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50.0),
                            borderSide: const BorderSide(
                              color: Color.fromRGBO(237, 218, 195, 1),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: const BorderSide(
                              width: 2,
                              color: Color.fromRGBO(29, 65, 53, 1),
                            ),
                          ),
                          hintText: 'Повторите пароль',
                          suffix: InkWell(
                            onTap: togglePasswordView,
                            child: Icon(
                              isHiddenPassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.black,
                            ),
                          ),
                          hintStyle: const TextStyle(
                              color: Color.fromARGB(255, 66, 66, 66)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Mainbutton(
                      onTap: () {
                        signUp();
                      },
                      text: 'Зарегистрироваться',
                      txtColor: const Color.fromRGBO(255, 255, 255, 1),
                      btnColor: const Color.fromRGBO(29, 65, 53, 1),
                    ),
                    const SizedBox(height: 20),

                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (builder) => const LoginPage()));
                      },
                      child: RichText(
                        text: TextSpan(children: [
                          TextSpan(
                            text: 'Уже есть аккаунт? ',
                            style: headline.copyWith(
                              fontSize: 14.0,
                            ),
                          ),
                          TextSpan(
                            text: 'Войти',
                            style: headlineDot.copyWith(
                                fontSize: 14.0, color: Colors.blue),
                          ),
                        ]),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
