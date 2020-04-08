import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

typedef FirebaseLoginSuccessCallback(FirebaseUser user);

class FirebaseLoginUtils {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  FirebaseLoginUtils(
      {FirebaseLoginSuccessCallback successCallback, failureCallback}) {
    try {
      this._attachGoogleListener(successCallback);
    } catch (e) {
      print('Exception in google sign in listner: \n $e');
      failureCallback();
    }
  }

  _attachGoogleListener(successCallback) {
    _googleSignIn.onCurrentUserChanged
        .listen((GoogleSignInAccount googleUser) async {
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      FirebaseUser user = (await _auth.signInWithCredential(credential)).user;
      successCallback(user);
    });
  }

  signInWithGoogle() async {
    try {
      await _googleSignIn.signIn();
    } catch (e) {
      print('Got Exception while signing in with google \n: $e');
    }
  }
}
