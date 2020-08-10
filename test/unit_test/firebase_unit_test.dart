import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../mock/FirebaseMock.dart';

void main() {
  FirebaseAuthMock firebaseAuth = FirebaseAuthMock();
  GoogleSignInMock googleSignIn = GoogleSignInMock();
  AppleSignInMock appleSignIn = AppleSignInMock();

  final GoogleSignInAccountMock googleSignInAccount = GoogleSignInAccountMock();
  final GoogleSignInAuthenticationMock googleSignInAuthentication =
      GoogleSignInAuthenticationMock();
  final FirebaseUserMock firebaseUser = FirebaseUserMock();

  test('signInWithGoogle returns a Firebase User', () async {
    /// googleSignIn
    when(googleSignIn.signIn()).thenAnswer(
        (_) => Future<GoogleSignInAccountMock>.value(googleSignInAccount));

    /// googleSignInAccount
    when(googleSignInAccount.authentication).thenAnswer((_) =>
        Future<GoogleSignInAuthenticationMock>.value(
            googleSignInAuthentication));

    /// firebaseAuth
    when(firebaseAuth.currentUser())
        .thenAnswer((_) => Future<FirebaseUserMock>.value(firebaseUser));
  });
}
