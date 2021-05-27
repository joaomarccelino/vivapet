import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String text;
  final Function onPressed;
  Button(this.text, {this.onPressed});
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(color: Colors.grey.shade200, fontSize: 25),
      ),
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.green)),
    );
  }
}

class Button2 extends StatelessWidget {
  final String text;
  final Function onPressed;
  Button2(this.text, {this.onPressed});
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.green)),
        child: Text(
          text,
          style: TextStyle(color: Colors.grey.shade200, fontSize: 25),
        ),
        onPressed: onPressed);
  }
}
