import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:js_skill_up/global_keys.dart';
import 'package:js_skill_up/locale/en/screens/login.dart';
import 'package:js_skill_up/routes.dart';
import 'package:js_skill_up/screens/login/widgets/phone-input.dart';
import 'package:js_skill_up/services/db/users/users.dart';
import 'package:js_skill_up/services/firebase/login_utils.dart';
import 'package:js_skill_up/services/redux/middleware/login_state_middleware.dart';
import 'package:js_skill_up/services/redux/models/app_state.dart';
import 'package:js_skill_up/services/redux/models/user_model.dart';
import 'package:redux/redux.dart';

typedef SaveToStoreCallback(UserModel user);

class LoginScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  FirebaseLoginUtils _firebaseUtils;

  LoginScreen() {
    this._firebaseUtils =
        FirebaseLoginUtils(_firebaseLoginSuccess, _firebaseLoginFailure);
  }

  _showSimpleSnackBar(String message) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  _firebaseLoginSuccess(User user) {
    _showSimpleSnackBar(LoginLocale.successSnack(user.email));
    _loginToApp(user);
  }

  _firebaseLoginFailure({EFailureReasons reason, String message}) {
    switch (reason) {
      case EFailureReasons.SlowNetwork:
        _showSimpleSnackBar(LoginLocale.failureSlowNetwork);
        break;
      case EFailureReasons.UnknownError:
        _showSimpleSnackBar(LoginLocale.failure);
        break;
    }
  }

  _loginToApp(User user) async {
    try {
      UserModel userToSave = UserModel(
          uid: user.uid,
          displayName: user.displayName,
          email: user.email,
          phoneNumber: user.phoneNumber,
          photoURL: user.photoURL);

      UsersDB.saveLoginInfo(userToSave)
          .then((value) => this._saveToStore(userToSave));
    } catch (e) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text(LoginLocale.failure),
          duration: const Duration(
              minutes: LoginLocale.configLoginFailSnackBarDuration),
          action: SnackBarAction(
            label: LoginLocale.retryLabel,
            onPressed: () {
              // Some code to undo the change.
              _loginToApp(user);
              _scaffoldKey.currentState.hideCurrentSnackBar();
            },
          )));

      //TODO: DELETE this code after server side code is done
      // Allowing dummy Login
      print('FAILED! as server is not there so dummy login');
    }
  }

  SaveToStoreCallback _saveToStore;

  SaveToStoreCallback _getSaveToStoreCallBack(Store<AppState> store) {
    return (UserModel user) {
      store.dispatch(saveLoginState(user));
      GlobalKeys.navKey.currentState.pushNamed(AppRoutes.homepage);
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: _buildBody(context),
    );
  }

  Widget _buildBody(context) {
    return GestureDetector(
      // To remove keyboard when user clicks on screen after focusing on input
      onTap: () => FocusScope.of(context).unfocus(),
      child: Container(
        decoration: _getBackgroundDecoration(context),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                LoginLocale.title,
                style: TextStyle(
                    color: Theme.of(context).primaryColorDark,
                    fontSize: 46,
                    fontFamily: LoginLocale.configTitleFont,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0),
              ),
              SizedBox(height: 70.0),
              PhoneInput(),
              SizedBox(height: 40.0),
              StoreConnector<AppState, SaveToStoreCallback>(
                converter: (store) => this._getSaveToStoreCallBack(store),
                builder: (BuildContext context, SaveToStoreCallback callback) {
                  this._saveToStore = callback;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        _makeLoginButton(LoginLocale.googleImageIcon, context,
                            _googleButtonClick,
                            tooltipText: LoginLocale.googleLoginToolTip),
                        _makeLoginButton(
                            LoginLocale.facebookImageIcon, context, callback,
                            tooltipText: LoginLocale.facebookLoginToolTip),
                        _makeLoginButton(
                            LoginLocale.githubImageIcon, context, callback,
                            tooltipText: LoginLocale.githubLoginToolTip),
                      ],
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  _getBackgroundDecoration(context) {
    return BoxDecoration(
      gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [
            0.60,
            1
          ],
          colors: [
            Theme.of(context).accentColor,
            Theme.of(context).primaryColor,
          ]),
    );
  }

  Widget _makeLoginButton(
      String imageLocation, BuildContext context, dynamic callBack,
      {String tooltipText = ""}) {
    return Container(
      width: 50.0,
      height: 50.0,
      decoration: BoxDecoration(color: Colors.transparent),
      child: IconButton(
        icon: Image.asset(
          imageLocation,
          fit: BoxFit.cover,
        ),
        tooltip: tooltipText,
        onPressed: () => callBack(),
      ),
    );
  }

  _googleButtonClick() => this._firebaseUtils.signInWithGoogle();
}
