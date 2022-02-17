import 'package:flutter/material.dart';
import 'package:drunk_homer_chat/screens/welcome_screen.dart';
import 'package:drunk_homer_chat/screens/login_screen.dart';
import 'package:drunk_homer_chat/screens/registration_screen.dart';
import 'package:drunk_homer_chat/screens/chat_screen.dart';

void main() => runApp(DrunkHomerChat());

class DrunkHomerChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        textTheme: TextTheme(
          bodyText2: TextStyle(color: Color(0xFF3E9BAA)),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: WelcomeScreen(),
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        ChatScreen.id: (context) => ChatScreen(),
      },
    );
  }
}
