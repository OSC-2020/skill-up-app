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
      margin: EdgeInsets.symmetric(horizontal: 16),
      padding: EdgeInsets.symmetric(horizontal: 16),
      height: 70,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(8.0))),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) {},
              decoration: InputDecoration.collapsed(
                hintText: "Mobile No.",
              ),
              inputFormatters: <TextInputFormatter>[
                WhitelistingTextInputFormatter.digitsOnly
              ],
              style: TextStyle(fontSize: 20.0),
            ),
          ),
          IconButton(
            icon: Icon(Icons.chevron_right),
            color: Theme.of(context).primaryColor,
            onPressed: () {},
          )
        ],
      ),
    );
  }
}