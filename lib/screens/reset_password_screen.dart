import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../core/colors.dart';
import '../core/space.dart';
import '../core/text_style.dart';
import '../services/snack_bar.dart';
import '../widget/main_button.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  TextEditingController emailTextInputController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailTextInputController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(29, 65, 53, 1),
        title: const Text('Востановление пароля'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/image/qwerty.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding:
              const EdgeInsets.only(bottom: 180.0, left: 20.0, right: 20.0),
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
                    //   child: Image(image: AssetImage('assets/image/logo3.png')),
                    // ),
                    const SpaceVH(height: 70.0),
                    const Text(
                      'Похоже вы забыли пароль',
                      style: headline4,
                    ),
                    const SpaceVH(height: 40.0),
                    const Padding(
                      padding: EdgeInsets.only(left: 20.0),
                      child: Text(
                        'Пожалуйста, напишите вашу почту, чтоб мы вам смогли помочь',
                        style: headline3,
                      ),
                    ),
                    const SpaceVH(height: 40.0),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20),
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        autocorrect: false,
                        controller: emailTextInputController,
                        validator: (email) =>
                            email != null && !EmailValidator.validate(email)
                                ? 'Введите правильный Email'
                                : null,
                        decoration: InputDecoration(
                          fillColor: const Color.fromRGBO(162, 96, 17, 1),
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
                    const SizedBox(height: 50),
                    Mainbutton(
                      onTap: () {},
                      text: 'Сбросить пароль',
                      txtColor: const Color.fromRGBO(255, 255, 255, 1),
                      btnColor: const Color.fromRGBO(29, 65, 53, 1),
                    ),
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
