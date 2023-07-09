import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FavoritesPage extends StatefulWidget {
  final String userId;

  FavoritesPage({required this.userId});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage>
    with TickerProviderStateMixin {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  late bool _visible = true;

  late final _animationController = AnimationController(
    duration: const Duration(seconds: 1),
    vsync: this,
  )..repeat();

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _animationController.addListener(() {
      setState(() {
        _visible = !_visible;
      });
    });
  }

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
            .where('userId', isEqualTo: widget.userId)
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

                return Dismissible(
                  key: ValueKey(favorite.reference.id),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    color: Colors.red,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Icon(Icons.delete, color: Colors.white),
                    ),
                    alignment: Alignment.centerLeft,
                  ),
                  onDismissed: (direction) {
                    // Remove the favorite from Firestore
                    db
                        .collection('favorites')
                        .doc(favorite.reference.id)
                        .delete()
                        .then((_) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: Colors.green,
                        content: Text("Товар удален из избранного"),
                        duration: Duration(seconds: 2),
                      ));
                    }).catchError((error) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: Colors.red,
                        content: Text(
                            "Не удалось удалить товар из избранного. Повторите попытку позже."),
                        duration: Duration(seconds: 2),
                      ));
                    });
                  },
                  child: Card(
                    margin:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: Stack(
                      children: [
                        ListTile(
                          title: Text(
                            favorite['excursionName'],
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 4),
                              Text(
                                'Описание экскурсии',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                "Описание",
                                style: TextStyle(fontSize: 14),
                              ),
                              AnimatedOpacity(
                                duration: Duration(milliseconds: 600),
                                opacity: _visible ? 1.0 : 0.0,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 16),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(4),
                                      bottomLeft: Radius.circular(4),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        'Смахните влево для удаления',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),
                                      ),
                                      Icon(
                                        Icons.arrow_left,
                                        color: Colors.black,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
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
