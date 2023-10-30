// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_app1/pages/forget_pass.dart';
import 'package:firebase_auth_app1/pages/sign_up.dart';
import 'package:firebase_auth_app1/pages/user_main.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formkey = GlobalKey<FormState>();

  var email = "";
  var password = "";
  var username = '';

  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController paswordcontroller = TextEditingController();
  final TextEditingController usernamecontroller = TextEditingController();

  Future<void> userLogin() async {
    try {
      final UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      final User? user = userCredential.user;
      if (user != null) {
        await user.updateProfile(displayName: usernamecontroller.text);
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => UserMain(
                      user: user,
                    )));
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('no user found on that email');
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.blueGrey,
            content: Text(
              'no user found on that email',
              style: TextStyle(fontSize: 18.0, color: Colors.amber),
            )));
      } else if (e.code == 'wrong-password') {
        print('wrong password provide by the user');
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.blueGrey,
            content: Text(
              'wrong password provide by the user',
              style: TextStyle(fontSize: 18.0, color: Colors.amber),
            )));
      }
    }
  }

  @override
  void dispose() {
    emailcontroller.dispose();
    paswordcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: _formkey,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 60.0, horizontal: 20.0),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset("assets/images/login.png"),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10.0),
                child: TextFormField(
                  autofocus: false,
                  decoration: const InputDecoration(
                    labelText: "Username",
                    labelStyle: TextStyle(fontSize: 20.0),
                    border: OutlineInputBorder(),
                    errorStyle: TextStyle(color: Colors.black, fontSize: 15.0),
                  ),
                  controller: usernamecontroller,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "please enter Username";
                    }
                    return null;
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10.0),
                child: TextFormField(
                  autofocus: false,
                  decoration: const InputDecoration(
                    labelText: "Gmail",
                    labelStyle: TextStyle(fontSize: 20.0),
                    border: OutlineInputBorder(),
                    errorStyle: TextStyle(color: Colors.black, fontSize: 15.0),
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
                margin: const EdgeInsets.symmetric(vertical: 10.0),
                child: TextFormField(
                  autofocus: false,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: "Password",
                    labelStyle: TextStyle(fontSize: 20.0),
                    border: OutlineInputBorder(),
                    errorStyle: TextStyle(color: Colors.black, fontSize: 15.0),
                  ),
                  controller: paswordcontroller,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "please enter Password";
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
                        if (_formkey.currentState!.validate()) {
                          setState(() {
                            email = emailcontroller.text;
                            password = paswordcontroller.text;
                            username = usernamecontroller.text;
                          });
                          userLogin();
                        }
                      },
                      child: const Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const ForgetpassPage()));
                        },
                        child: const Text(
                          "forget password",
                          style: TextStyle(color: Colors.blue, fontSize: 18.0),
                        ))
                  ],
                ),
              ),
              SizedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Do not Have Any account ?"),
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
                        child: const Text("Sign Up"))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
