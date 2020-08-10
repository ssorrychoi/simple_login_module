import 'package:apple_sign_in/apple_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mockito/mockito.dart';

class FirebaseAuthMock extends Mock implements FirebaseAuth {}

class GoogleSignInMock extends Mock implements GoogleSignIn {}

class AppleSignInMock extends Mock implements AppleSignIn {}

class FirebaseUserMock extends Mock implements FirebaseUser {
  @override
  // TODO: implement displayName
  String get displayName => 'Jacob Choi';

  @override
  // TODO: implement uid
  String get uid => 'uid';

  @override
  // TODO: implement email
  String get email => 'jaesung@braincolla.com';

  @override
  // TODO: implement photoUrl
  String get photoUrl => 'http://velog.io/@ssorry_choi';
}

class GoogleSignInAccountMock extends Mock implements GoogleSignInAccount {}

class GoogleSignInAuthenticationMock extends Mock
    implements GoogleSignInAuthentication {}
