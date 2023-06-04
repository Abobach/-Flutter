import 'package:diplom_flutter/phoneAyth/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

import '../phoneAyth/user_model.dart';

class DetailPage extends StatefulWidget {
  final querySnapshot;
  DetailPage({Key? key, required this.querySnapshot}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final db = FirebaseFirestore.instance;
  int currentIndex = 0;
  List<Review> reviews = [];
  double averageRating = 0.0;

  @override
  void initState() {
    super.initState();
    loadReviews();
  }

  Future<void> loadReviews() async {
    final querySnapshot = await db
        .collection('reviews')
        .where('excursionId', isEqualTo: widget.querySnapshot.id)
        .get();

    setState(() {
      reviews = querySnapshot.docs.map((doc) {
        return Review(
            id: doc.id,
            excursionId: doc['excursionId'],
            username: doc['username'],
            rating: doc['rating'],
            comment: doc['comment'],
            profilePic: doc['profilePic']);
      }).toList();
      final totalReviews = reviews.length;
      final totalRating = reviews.fold(0, (sum, review) => sum + review.rating);
      averageRating = totalReviews > 0 ? totalRating / totalReviews : 0.0;
    });
  }

  Future<void> saveReview(Review review) async {
    if (review.username.isEmpty || review.comment.isEmpty) {
      // Проверяем, что имя пользователя и комментарий не пустые
      return; // Прерываем сохранение пустого отзыва
    }
    final ap = Provider.of<AuthProvider>(context, listen: false);
    final profilePic = ap.userModel.profilePic;

    await db.collection('reviews').add({
      'excursionId': review.excursionId,
      'username': review.username,
      'rating': review.rating,
      'comment': review.comment,
      'profilePic': profilePic,
    });

    setState(() {
      reviews.add(review);
      final totalReviews = reviews.length;
      final totalRating = reviews.fold(0, (sum, review) => sum + review.rating);
      averageRating = totalReviews > 0 ? totalRating / totalReviews : 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double widht = MediaQuery.of(context).size.width;
    return Scaffold(
      body: StreamBuilder(
        stream: db.collection("categories").snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData)
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.grey[200],
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                strokeWidth: 6,
              ),
            );
          final categories = snapshot.data.docs;

          return SingleChildScrollView(
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Container(
                        height: height * 0.3,
                        width: double.infinity,
                        child: Image.network(
                          widget.querySnapshot['image'],
                        ),
                      ),
                      Positioned(
                        top: 16,
                        left: 16,
                        child: Container(
                          child: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 16,
                        right: 16,
                        child: Container(
                          child: Icon(
                            Icons.assistant_direction,
                            color: Colors.white,
                          ),
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                        ),
                      ),
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Text(
                            widget.querySnapshot['title'],
                            style: GoogleFonts.montserrat(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        height: height * .09,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 40, left: 16, right: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 20.0),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    '${averageRating.toStringAsFixed(1)}',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 20.0),
                                  child: const Icon(
                                    Icons.access_time,
                                    color: Colors.grey,
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 20.0),
                                  child: Text("10.00 - 22.00",
                                      style:
                                          GoogleFonts.montserrat(fontSize: 12)),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 36),
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: Container(
                      decoration: BoxDecoration(
                          color: const Color.fromRGBO(237, 218, 195, 1),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20))),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Описание экскурсии',
                              style: GoogleFonts.montserrat(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              widget.querySnapshot['opis'],
                              style: GoogleFonts.montserrat(fontSize: 14),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Краткая информация',
                              style: GoogleFonts.montserrat(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              widget.querySnapshot['subtitle'],
                              style: GoogleFonts.montserrat(fontSize: 14),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Отзывы',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title:
                                              const Text('Добавьте ваш отзыв'),
                                          content: CommentInput(
                                            onSave: (username, rating, comment,
                                                profilePic) {
                                              final newReview = Review(
                                                excursionId:
                                                    widget.querySnapshot.id,
                                                username: username,
                                                rating: rating,
                                                comment: comment,
                                                profilePic: profilePic,
                                                id: '',
                                              );

                                              saveReview(newReview);
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  icon: Icon(Icons.add),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: reviews.length,
                              itemBuilder: (BuildContext context, int index) {
                                final review = reviews[index];
                                return Comment(
                                    username: review.username,
                                    rating: review.rating,
                                    comment: review.comment,
                                    profilePic: review.profilePic);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class Review {
  final String id;
  final String excursionId;
  final String username;
  final int rating;
  final String comment;
  final String profilePic;

  Review(
      {required this.id,
      required this.excursionId,
      required this.username,
      required this.rating,
      required this.comment,
      required this.profilePic});
}

class Comment extends StatelessWidget {
  final String username;
  final int rating;
  final String comment;
  final String profilePic;

  const Comment({
    Key? key,
    required this.username,
    required this.rating,
    required this.comment,
    required this.profilePic,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              Image.network(
                profilePic,
                width: 40,
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(username, style: GoogleFonts.montserrat(fontSize: 12)),
                  Row(
                    children: List.generate(rating, (index) {
                      return Icon(Icons.star, color: Colors.amber);
                    }),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Text(comment, style: GoogleFonts.montserrat(fontSize: 12)),
        ],
      ),
    );
  }
}

class CommentInput extends StatefulWidget {
  final Function(String username, int rating, String comment, String profilePic)
      onSave;

  const CommentInput({Key? key, required this.onSave}) : super(key: key);

  @override
  _CommentInputState createState() => _CommentInputState();
}

class _CommentInputState extends State<CommentInput> {
  String username = '';
  int rating = 0;
  String comment = '';
  String profilePic = '';

  @override
  void initState() {
    super.initState();
    final ap = Provider.of<AuthProvider>(context, listen: false);

    profilePic = ap.userModel.profilePic;

    username = ap
        .userModel.name; // Устанавливаем начальное значение имени пользователя
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
          onChanged: (value) {
            setState(() {
              username = value;
            });
          },
          decoration: InputDecoration(
            labelText: 'Фио',
          ),
          controller: TextEditingController(text: username),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Оценка: $rating'),
            Slider(
              value: rating.toDouble(),
              min: 0,
              max: 5,
              divisions: 5,
              onChanged: (value) {
                setState(() {
                  rating = value.toInt();
                });
              },
            ),
          ],
        ),
        const SizedBox(height: 8),
        TextField(
          onChanged: (value) {
            setState(() {
              comment = value;
            });
          },
          decoration: InputDecoration(labelText: 'Отзыв'),
        ),
        const SizedBox(height: 8),
        ElevatedButton(
          onPressed: () {
            widget.onSave(username, rating, comment, profilePic);
          },
          child: Text('Отправить'),
        ),
      ],
    );
  }
}
