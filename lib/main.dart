import 'package:flutter/material.dart';
import 'package:drunk_homer_chat/screens/welcome_screen.dart';
import 'package:drunk_homer_chat/screens/login_screen.dart';
import 'package:drunk_homer_chat/screens/registration_screen.dart';
import 'package:drunk_homer_chat/screens/chat_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Инициализируем Firebase
  await Firebase.initializeApp();
  runApp(DrunkHomerChat());
}

class DrunkHomerChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
