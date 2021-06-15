import 'package:flutter/material.dart';
import 'package:viva_pet/views/authOrUser.dart';

void main() {
  runApp(MyApp());
}

const PrimaryColor = const Color(0xFF4c9900);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Viva Pet',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: PrimaryColor,
      ),
      home: AuthOrUser(),
    );
  }
}
