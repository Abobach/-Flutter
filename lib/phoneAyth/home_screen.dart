import 'package:diplom_flutter/phoneAyth/welcome_screen.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'auth_provider.dart';

class HomePageScrenn extends StatefulWidget {
  const HomePageScrenn({super.key});

  @override
  State<HomePageScrenn> createState() => _HomePageScrennState();
}

class _HomePageScrennState extends State<HomePageScrenn> {
  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<AuthProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(29, 65, 53, 1),
        title: const Text("FlutterPhone Auth"),
        actions: [
          IconButton(
            onPressed: () {
              ap.userSignOut().then(
                    (value) => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const WelcomeScreen(),
                      ),
                    ),
                  );
            },
            icon: const Icon(Icons.exit_to_app),
          ),
        ],
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: Color.fromRGBO(29, 65, 53, 1),
            backgroundImage: NetworkImage(ap.userModel.profilePic),
            radius: 50,
          ),
          const SizedBox(height: 20),
          Text(ap.userModel.name),
          Text(ap.userModel.phoneNumber),
          Text(ap.userModel.email),
          Text(ap.userModel.bio),
        ],
      )),
    );
  }
}
