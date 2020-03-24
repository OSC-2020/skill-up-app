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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              Text(
                "js Skill Up",
                style: TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0),
              ),
            ]),
            SizedBox(height: 8.0),
            PhoneInput()
          ],
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
}
