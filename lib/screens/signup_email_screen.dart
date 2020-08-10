import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_module_flutter/screens/login_screen.dart';
import 'package:login_module_flutter/screens/my_profile_screen.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseUser firebaseUser;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Sign up for Email'),
        ),
        body: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    icon: Icon(Icons.mail),
                    labelText: "Enter User E-mail address",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  validator: (value) {
                    return value.contains('@')
                        ? null
                        : 'Confirm your email address';
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    icon: Icon(Icons.lock),
                    labelText: "Enter User password",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  validator: (value) {
//                    return value.isEmpty ? "Enter your password" : null;
                    return value.isEmpty
                        ? "Enter your password"
                        : (value.length < 6
                            ? "The password must be 6 characters long or more."
                            : null);
                  },
                ),
              ),
              RaisedButton(
                color: Colors.lightBlue,
                onPressed: () async {
                  try {
                    if (_formKey.currentState.validate()) {
                      /// 회원가입
                      await firebaseAuth.createUserWithEmailAndPassword(
                          email: emailController.text,
                          password: passwordController.text);
                      print(
                          '===fireAuth===\nemail:${emailController.text},pwd:${passwordController.text}');

                      /// 로그인
                      await firebaseAuth
                          .signInWithEmailAndPassword(
                              email: emailController.text,
                              password: passwordController.text)
                          .then((value) => Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MyProfileScreen(
                                        user: value.user,
                                        platform: 'email',
                                      )),
                              (route) => false));
                    }
                  } catch (e) {
                    print('err: $e');
                  }
                },
                child: Text('Submit'),
              )
            ],
          ),
        ));
  }
}
