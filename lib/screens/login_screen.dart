import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_alt/modal_progress_hud_alt.dart';
import 'package:drunk_homer_chat/constants.dart';
import 'package:drunk_homer_chat/components/rounded_button.dart';
import 'package:drunk_homer_chat/screens/chat_screen.dart';

class LoginScreen extends StatefulWidget {
  static const id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;
  String email = '';
  String password = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFD0EDF2),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: SingleChildScrollView(
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
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
                    email = value;
                  },
                  style: kTextFieldStyle,
                  decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter your email, drunkard',
                    prefixIcon: Icon(
                      Icons.alternate_email,
                      color: Color(0xFF3E9BAA),
                    ),
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                TextFormField(
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  onChanged: (value) {
                    password = value;
                  },
                  style: kTextFieldStyle,
                  decoration: kTextFieldDecoration.copyWith(
                    hintText: 'And don\'t forget the password!',
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
                  onPressed: () async {
                    setState(() {
                      showSpinner = true;
                    });
                    try {
                      // Авторизуем пользователя
                      final user = await _auth.signInWithEmailAndPassword(
                          email: email, password: password);
                      Navigator.pushNamed(context, ChatScreen.id);
                      setState(() {
                        showSpinner = false;
                      });
                    } catch (e) {
                      String errorMessage =
                          e.toString().replaceRange(0, 14, '').split('] ')[1];
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: Color(0xFF0E3B41),
                          content: Text(errorMessage)));
                      setState(() {
                        showSpinner = false;
                      });
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
