import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PhoneInput extends StatefulWidget {
  PhoneInput({Key key}) : super(key: key);

  @override
  _PhoneInputState createState() => _PhoneInputState();
}

class _PhoneInputState extends State<PhoneInput> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      height: 70,
      decoration: BoxDecoration(color: Colors.transparent),
      child: TextField(
        keyboardType: TextInputType.number,
        onChanged: (value) {},
        decoration: InputDecoration(
            suffixIcon: Icon(Icons.chevron_right),
            floatingLabelBehavior: FloatingLabelBehavior.never,
            labelText: "Mobile No.",
            labelStyle: TextStyle(color: Colors.white),
            focusColor: Theme.of(context).primaryColorDark,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).primaryColorDark),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).primaryColorDark),
            )),
        inputFormatters: <TextInputFormatter>[
          WhitelistingTextInputFormatter.digitsOnly
        ],
        style: TextStyle(fontSize: 20.0, color: Colors.white),
      ),
    );
  }
}
