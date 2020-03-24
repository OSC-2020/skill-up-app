import 'package:flutter/material.dart';
import 'package:js_skill_up/widgets/phone-input.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 40.0),
                child: Divider(
                  color: Colors.grey,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    _makeLoginButton(
                        imageLocation: "assets/icons/google.png",
                        context: context,
                        tooltipText: "Login with Google"),
                    _makeLoginButton(
                        imageLocation: "assets/icons/facebook.png",
                        context: context,
                        tooltipText: "Login with Facebook"),
                    _makeLoginButton(
                        imageLocation: "assets/icons/github.png",
                        context: context,
                        tooltipText: "Login with Github"),
                  ],
                ),
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
            0.25,
            0.75
          ],
          colors: [
            Theme.of(context).primaryColor,
            Theme.of(context).accentColor,
          ]),
    );
  }

  Widget _makeLoginButton(
      {String imageLocation, BuildContext context, String tooltipText = ""}) {
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
          onPressed: () => {},
        ));
  }
}
