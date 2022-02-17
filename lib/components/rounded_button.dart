import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String title;
  final Color color;
  final void Function() onPressed; // final VoidCallback onPress
  RoundedButton(
      {required this.title, required this.color, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: color,
          onPrimary: Colors.white,
          textStyle: TextStyle(fontSize: 20),
          padding: EdgeInsets.all(12),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
        ),
        child: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
