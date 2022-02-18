import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_alt/modal_progress_hud_alt.dart';
import 'package:drunk_homer_chat/constants.dart';
import 'package:drunk_homer_chat/components/rounded_button.dart';
import 'package:drunk_homer_chat/services/validators.dart';
import 'package:drunk_homer_chat/screens/chat_screen.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);
  static const id = 'registration_screen';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
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
          child: Form(
            key: _formKey,
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
                    validator: (value) => validateEmail(value!)
                        ? null
                        : "Sorry buddy, I can't recognize this email address",
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) {
                      email = value;
                    },
                    style: kTextFieldStyle,
                    decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Please, enter your email...',
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
                    validator: (value) => value!.length < 6
                        ? "Hey, password must be 6 or more characters in length"
                        : null,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    onChanged: (value) {
                      password = value;
                    },
                    style: kTextFieldStyle,
                    decoration: kTextFieldDecoration.copyWith(
                      hintText: '...and password',
                      helperText: 'At least 6 characters',
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
                    title: 'Register',
                    color: Color(0xFF917A29),
                    onPressed: () async {
                      setState(() {
                        showSpinner = true;
                      });
                      if (_formKey.currentState!.validate()) {
                        try {
                          final newUser =
                              await _auth.createUserWithEmailAndPassword(
                                  email: email, password: password);
                          Navigator.pushNamed(context, ChatScreen.id);
                          setState(() {
                            showSpinner = false;
                          });
                        } catch (e) {
                          String errorMessage = e
                              .toString()
                              .replaceRange(0, 14, '')
                              .split('] ')[1];
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              backgroundColor: Color(0xFF0E3B41),
                              content: Text(errorMessage)));
                          setState(() {
                            showSpinner = false;
                          });
                        }
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
