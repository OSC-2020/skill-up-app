import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:js_skill_up/redux/models/app_state.dart';
import 'package:js_skill_up/redux/models/user_model.dart';
import 'package:js_skill_up/redux/reducers/user_reducer.dart';
import 'package:js_skill_up/utils/login_utils.dart';
import 'package:js_skill_up/widgets/phone-input.dart';

typedef LoginSuccessCallBack(String method);

class LoginScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  FirebaseLoginUtils _loginUtils;

  LoginScreen() {
    this._loginUtils =
        FirebaseLoginUtils(successCallback: _firebaseSuccessLogin);
  }

  _firebaseSuccessLogin(FirebaseUser user) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text("Welcome back ${user.email}"),
    ));
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
                "JS Skill Up",
                style: TextStyle(
                    color: Theme.of(context).primaryColorDark,
                    fontSize: 46,
                    fontFamily: "Calibre-Semibold",
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0),
              ),
              SizedBox(height: 60.0),
              PhoneInput(),
              SizedBox(height: 100.0),
              StoreConnector<AppState, LoginSuccessCallBack>(
                converter: (store) {
                  return (String method) {
                    print(method);
                    // Navigator.push(context, HomeScreen())
                    store.dispatch(
                        GetUserAction(UserModel(username: "Rahul Barwal")));
                  };
                },
                builder: (context, callback) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        _makeLoginButton("assets/icons/google.png", context,
                            _googleButtonClick,
                            tooltipText: "Login with Google"),
                        _makeLoginButton(
                            "assets/icons/facebook.png", context, callback,
                            tooltipText: "Login with Facebook"),
                        _makeLoginButton(
                            "assets/icons/github.png", context, callback,
                            tooltipText: "Login with Github"),
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
