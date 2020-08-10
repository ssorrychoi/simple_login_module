import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_module_flutter/screens/login_screen.dart';

class MyProfileScreen extends StatelessWidget {
  FirebaseUser user;
  String platform;

  MyProfileScreen({this.user, this.platform});

  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    return Scaffold(
      appBar: AppBar(
        title: Text('My page'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () {
                print('clicked');
                auth.signOut();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                    (route) => false);
              },
            ),
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.only(bottom: 32),
              child: Image.network(
                platform == 'apple'
                    ? 'https://cdn2.iconfinder.com/data/icons/apple-tv-1/512/apple_logo-512.png'
                    : platform == 'google'
                        ? 'https://cdn.cognitiveseo.com/blog/wp-content/uploads/2017/10/1000px-Google_-G-_Logo.svg_.png'
                        : 'https://image.flaticon.com/icons/png/512/8/8807.png',
                height: 100,
              ),
            ),
            Text(platform == 'apple'
                ? '안녕하세요!\n'
                : (platform == 'google'
                    ? '안녕하세요, ${user.displayName}.\n'
                    : '안녕하세요!\n로그인 하신 이메일 주소는 \n${user.email}입니다.')),
            Text(platform == 'apple'
                ? 'apple로 로그인하셨습니다.'
                : (platform == 'google'
                    ? 'Google로 로그인하셨습니다.'
                    : 'Email로 로그인하셨습니다.')),
          ],
        ),
      ),
    );
  }
}
