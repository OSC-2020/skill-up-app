import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

typedef FirebaseLoginSuccessCallback(User user);
typedef FirebaseLoginFailureCallback({EFailureReasons reason, String message});

enum EFailureReasons { SlowNetwork, UnknownError }

class FirebaseLoginUtils {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final FirebaseLoginFailureCallback failureCallback;
  final FirebaseLoginSuccessCallback successCallback;

  FirebaseLoginUtils(this.successCallback, this.failureCallback) {
    assert(this.successCallback != null);
    assert(this.failureCallback != null);
    try {
      this._attachGoogleListener();
    } catch (e) {
      print('Exception in google sign in listener: \n $e');
      this.failureCallback();
    }
  }

  _attachGoogleListener() {
    _googleSignIn.onCurrentUserChanged
        .listen((GoogleSignInAccount googleUser) async {
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      User user = (await _auth.signInWithCredential(credential)).user;
      this.successCallback(user);
    });
  }

  signInWithGoogle() async {
    try {
      await _googleSignIn.signIn();
    } on PlatformException {
      print("Problem with internet check your internet connection");
      this.failureCallback(reason: EFailureReasons.SlowNetwork);
    } catch (e) {
      print('Got Exception while signing in with google \n: $e');
      this.failureCallback(reason: EFailureReasons.UnknownError, message: e);
    }
  }
}
