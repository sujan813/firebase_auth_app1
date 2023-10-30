// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_app1/pages/login.dart';
import 'package:firebase_auth_app1/pages/sign_up.dart';
import 'package:flutter/material.dart';

class ForgetpassPage extends StatefulWidget {
  const ForgetpassPage({super.key});

  @override
  State<ForgetpassPage> createState() => _ForgetpassPageState();
}

class _ForgetpassPageState extends State<ForgetpassPage> {
  final formkey = GlobalKey<FormState>();

  var email = '';

  final emailcontroller = TextEditingController();

  resetpasssword() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.blueGrey,
          content: Text(
            "password reset email has been send",
            style: TextStyle(fontSize: 20.0, color: Colors.amber),
          ),
        ),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginPage(),
        ),
      );
    } on FirebaseAuthException catch (error2) {
      if (error2.code == 'user-not-found') {
        print('no user found on that email');

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.blueGrey,
            content: Text(
              "no user found on that email",
              style: TextStyle(fontSize: 20.0, color: Colors.greenAccent),
            ),
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    emailcontroller.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Forget Password"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Image.asset(
              'assets/images/forget.png',
              height: 200.0,
              width: 200.0,
            ),
          ),
          Container(
            margin: const EdgeInsets.all(20.0),
            child: const Text(
              'Reset link will be send in your email',
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
          ),
          Expanded(
            child: Form(
              key: formkey,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 30.0),
                child: ListView(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10.0),
                      child: TextFormField(
                        autofocus: false,
                        decoration: const InputDecoration(
                          labelText: "Gmail",
                          labelStyle: TextStyle(fontSize: 20.0),
                          border: OutlineInputBorder(),
                          errorStyle:
                              TextStyle(color: Colors.black, fontSize: 15.0),
                        ),
                        controller: emailcontroller,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "please enter email";
                          } else if (!value.contains('@')) {
                            return "please enter valid email";
                          }
                          return null;
                        },
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              if (formkey.currentState!.validate()) {
                                setState(() {
                                  email = emailcontroller.text;
                                });

                                resetpasssword();
                              }
                            },
                            child: const Text(
                              'Send email',
                              style: TextStyle(fontSize: 18.0),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginPage(),
                                ),
                              );
                            },
                            child: const Text(
                              "Login",
                              style: TextStyle(fontSize: 15.0),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Dont have Account ?"),
                          TextButton(
                              onPressed: () {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    PageRouteBuilder(
                                        pageBuilder: (context, a, b) =>
                                            const SignUpScreen(),
                                        transitionDuration:
                                            const Duration(seconds: 1)),
                                    (route) => false);
                              },
                              child: const Text('Sign Up'))
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
