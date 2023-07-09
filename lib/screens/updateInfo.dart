import 'package:diplom_flutter/phoneAyth/auth_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

import '../phoneAyth/user_model.dart';

class EditProfilePage extends StatefulWidget {
  final UserModel user;

  EditProfilePage({required this.user});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _bioController;

  late TextEditingController _phoneNumberController;

  @override
  void initState() {
    super.initState();

    // Initialize the text controllers with existing user data
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _bioController = TextEditingController();

    _phoneNumberController = TextEditingController();

    getUserData();
  }

  @override
  void dispose() {
    // Dispose the text controllers when the widget is disposed
    _nameController.dispose();
    _emailController.dispose();
    _bioController.dispose();

    _phoneNumberController.dispose();
    super.dispose();
  }

  void getUserData() async {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    if (ap.userModel != null) {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(_firebaseAuth.currentUser!.uid)
          .get();

      setState(() {
        _nameController.text = ap.userModel.name;
        _emailController.text = ap.userModel.email;
        _bioController.text = ap.userModel.bio;

        _phoneNumberController.text = ap.userModel.phoneNumber;
      });
    }
  }

  void updateUserProfile() async {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    String newName = _nameController.text;
    String newEmail = _emailController.text;
    String newBio = _bioController.text;

    // Создаем объект с обновленными данными пользователя
    Map<String, dynamic> updatedUserData = {
      "name": newName,
      "email": newEmail,
      "bio": newBio,
    };

    // Обновляем данные пользователя в Firebase
    await _firebaseFirestore
        .collection('users')
        .doc(_firebaseAuth.currentUser!.uid)
        .update(updatedUserData);
    Map<String, dynamic> updatedData = {
      "name": newName,
      "email": newEmail,
      "bio": newBio,
    };

    // Показываем сообщение об успешном обновлении или выполняем другие необходимые действия
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Данные успешно обновлены')),
    );
    Navigator.pop(context, updatedUserData);
  }

  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Обновить данные'),
        backgroundColor: const Color.fromRGBO(29, 65, 53, 1),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Имя'),
            ),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'e-mail'),
            ),
            TextFormField(
              controller: _bioController,
              decoration: InputDecoration(labelText: 'Краткая информация'),
            ),
            TextFormField(
              controller: _phoneNumberController,
              decoration: InputDecoration(labelText: 'Номер телефона'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: updateUserProfile,
              child: Text('Сохранить'),
            ),
          ],
        ),
      ),
    );
  }
}
