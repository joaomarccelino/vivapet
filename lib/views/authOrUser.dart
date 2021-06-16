import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:viva_pet/views/home.dart';
import 'authUser.dart';

FirebaseAuth auth = FirebaseAuth.instance;
User isAuth;
Future<void> authOrApp(context) async {
  await Firebase.initializeApp();
  isAuth = auth.currentUser;
  isAuth != null
      ? Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => Home()))
      : Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => AuthUser()));
}

class AuthOrUser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    authOrApp(context);
    return Scaffold(
      backgroundColor: Colors.orange.shade300,
    );
  }
}
