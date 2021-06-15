import 'package:flutter/material.dart';
import 'package:viva_pet/main.dart';

class TitleText extends StatelessWidget {
  String text;
  TitleText(this.text);
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 20,
        color: Colors.white,
      ),
    );
  }
}

class DescriptionText extends StatelessWidget {
  String text;
  DescriptionText(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    );
  }
}
