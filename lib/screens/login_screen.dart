import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:apple_sign_in/apple_sign_in.dart';

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
                size: 150,
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
                        FirebaseAuth auth = FirebaseAuth.instance;
                        AuthResult authResult = await auth
                            .signInWithCredential(credential); // 인증에 성공한 유저 정보
                        FirebaseUser user = authResult.user;
                      } catch (e) {
                        print('err: $e');
                      }
                    },
                  )
                : Container(),
            SignInButton(
              Buttons.Email,
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}
