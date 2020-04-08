import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:js_skill_up/locale/en/screens/login.dart';
import 'package:js_skill_up/redux/models/app_state.dart';
import 'package:js_skill_up/redux/models/user_model.dart';
import 'package:js_skill_up/redux/reducers/user_reducer.dart';
import 'package:js_skill_up/utils/login_utils.dart';
import 'package:js_skill_up/widgets/phone-input.dart';
import 'package:redux/redux.dart';

typedef SaveToStoreCallback(String method);

class LoginScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  FirebaseLoginUtils _loginUtils;

  LoginScreen() {
    this._loginUtils =
        FirebaseLoginUtils(successCallback: _firebaseSuccessLogin);
  }

  _firebaseSuccessLogin(FirebaseUser user) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(LoginLocale.successSnack(user.email)),
    ));
    this._saveToStore(user.displayName);
  }

  SaveToStoreCallback _saveToStore;

  SaveToStoreCallback _getSaveToStoreCallBack(Store<AppState> store) {
    return (String displayName) {
      // Navigator.push(context, HomeScreen())
      store.dispatch(GetUserAction(UserModel(username: displayName)));
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
      // To remove keyboard when user clicks on screen after focussing on input
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
                    fontFamily: LoginLocale.titleFont,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0),
              ),
              SizedBox(height: 60.0),
              PhoneInput(),
              SizedBox(height: 100.0),
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

  _googleButtonClick() => this._loginUtils.signInWithGoogle();
}
