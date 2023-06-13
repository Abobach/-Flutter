import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FavoritesPage extends StatelessWidget {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final String userId;

  FavoritesPage({required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Избранное'),
        backgroundColor: Color.fromRGBO(29, 65, 53, 1),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: db
            .collection('favorites')
            .where('userId', isEqualTo: userId)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final List<QueryDocumentSnapshot> favoriteList =
                snapshot.data!.docs;

            if (favoriteList.isEmpty) {
              return Center(
                child: Text('У вас нет избранных экскурсий.'),
              );
            }

            return ListView.builder(
              itemCount: favoriteList.length,
              itemBuilder: (context, index) {
                final favorite = favoriteList[index];

                return ListTile(
                  title: Text(favorite['excursionName']),
                  // Ваш код для отображения дополнительных данных экскурсии
                );
              },
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Произошла ошибка при загрузке избранных экскурсий.'),
            );
          }

          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
