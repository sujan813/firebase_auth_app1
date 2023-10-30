import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserMain extends StatefulWidget {
  final User user;
  UserMain({super.key, required this.user});

  @override
  State<UserMain> createState() => _UserMainState();
}

class _UserMainState extends State<UserMain> {
  final uid = FirebaseAuth.instance.currentUser!.uid;
  final email = FirebaseAuth.instance.currentUser!.email;
  final creationtime = FirebaseAuth.instance.currentUser!.metadata.creationTime;
  final username = FirebaseAuth.instance.currentUser!.displayName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("User Profile"),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 60.0, horizontal: 20.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Image.asset("assets/images/login.png"),
            ),
            const SizedBox(
              height: 50.0,
            ),
            Column(
              children: [
                const Text(
                  "U Id : ",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  username.toString(),
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w100,
                  ),
                ),
                const SizedBox(
                  height: 50.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Email : $email",
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w100,
                      ),
                    ),
                  ],
                ),
                Column(children: [
                  const Text(
                    "Created Time : ",
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    creationtime.toString(),
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w100,
                    ),
                  ),
                ]),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
