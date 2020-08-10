import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:apple_sign_in/apple_sign_in.dart';
import 'package:login_module_flutter/screens/my_profile_screen.dart';
import 'package:login_module_flutter/screens/signup_email_screen.dart';

class LoginScreen extends StatelessWidget {
  FirebaseAuth auth = FirebaseAuth.instance;
  GoogleSignIn googleSignIn = GoogleSignIn();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: FlutterLogo(
                size: 180,
              ),
            ),
            SignInButton(
              Buttons.GoogleDark,
              onPressed: () async {
                try {
                  GoogleSignInAccount account = await googleSignIn.signIn();
                  GoogleSignInAuthentication authentication =
                      await account.authentication;

                  AuthCredential credential = GoogleAuthProvider.getCredential(
                      idToken: authentication.idToken,
                      accessToken: authentication.accessToken);
                  AuthResult authResult =
                      await auth.signInWithCredential(credential);
                  FirebaseUser user = authResult.user;
//                  Navigator.pushNamedAndRemoveUntil(
//                      context,
//                      MaterialPageRoute(
//                          builder: (BuildContext context) =>
//                              MyProfileScreen(user: user, platform: 'gogole')),
//                      (route) => false);
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              MyProfileScreen(user: user, platform: 'google')),
                      (route) => false);
                } catch (e) {
                  print('err: $e');
                }
              },
            ),
            Platform.isIOS
                ? SignInButton(
                    Buttons.AppleDark,
                    onPressed: () async {
                      try {
                        AuthorizationRequest authorizationRequest =
                            AppleIdRequest(
                                requestedScopes: [Scope.email, Scope.fullName]);
                        print(authorizationRequest.requestedScopes[0].value);
                        print(authorizationRequest.requestedScopes[1].value
                            .toString());
                        AuthorizationResult authorizationResult =
                            await AppleSignIn.performRequests(
                                [authorizationRequest]);
                        AppleIdCredential appleCredential =
                            authorizationResult.credential;
                        OAuthProvider provider =
                            new OAuthProvider(providerId: "apple.com");
                        AuthCredential credential = provider.getCredential(
                          idToken: String.fromCharCodes(
                              appleCredential.identityToken),
                          accessToken: String.fromCharCodes(
                              appleCredential.authorizationCode),
                        );
                        print(String.fromCharCodes(
                            appleCredential.identityToken));
                        FirebaseAuth auth = FirebaseAuth.instance;
                        AuthResult authResult = await auth.signInWithCredential(
                            credential); //// 인증에 성공한 유저 정보
                        print(
                            '===user===\n${authResult.user.displayName}\n${authResult.user.email}\n${authResult.user.photoUrl}\n${authResult.user.phoneNumber}\n${authResult.user.isAnonymous}\n${authResult.user.isEmailVerified}');
                        FirebaseUser user = authResult.user;
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyProfileScreen(
                                    user: user, platform: 'apple')),
                            (route) => false);
                      } catch (e) {
                        print('err: $e');
                      }
                    },
                  )
                : Container(),
            SignInButton(
              Buttons.Email,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SignUpScreen()));
              },
            )
          ],
        ),
      ),
    );
  }
}
