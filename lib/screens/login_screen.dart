import 'package:flutter/material.dart';
import 'package:drunk_homer_chat/constants.dart';
import 'package:drunk_homer_chat/components/rounded_button.dart';

class LoginScreen extends StatefulWidget {
  static const id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFD0EDF2),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Hero(
              tag: 'logo',
              child: Container(
                height: 250.0,
                child: Image.asset('images/logo.png'),
              ),
            ),
            SizedBox(
              height: 48.0,
            ),
            TextFormField(
              onChanged: (value) {
                //Do something with the user input.
              },
              style: kTextFieldStyle,
              decoration: kTextFieldDecoration.copyWith(
                hintText: 'Enter your login',
                prefixIcon: Icon(
                  Icons.person,
                  color: Color(0xFF3E9BAA),
                ),
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            TextFormField(
              onChanged: (value) {
                //Do something with the user input.
              },
              style: kTextFieldStyle,
              decoration: kTextFieldDecoration.copyWith(
                hintText: 'Enter your password',
                prefixIcon: Icon(
                  Icons.password,
                  color: Color(0xFF3E9BAA),
                ),
              ),
            ),
            SizedBox(
              height: 24.0,
            ),
            RoundedButton(
              title: 'Log in',
              color: Color(0xFFC3B47A),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
