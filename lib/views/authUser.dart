import 'package:flutter/material.dart';
import 'package:viva_pet/views/home.dart';
import 'package:viva_pet/widgets/buttons.dart';
import 'package:viva_pet/widgets/input.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthUser extends StatefulWidget {
  @override
  _AuthUserState createState() => _AuthUserState();
}

FirebaseAuth auth = FirebaseAuth.instance;

class _AuthUserState extends State<AuthUser> {
  final _email = TextEditingController();
  final _password = TextEditingController();

  final String assetName = 'images/logo.png';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
    );
  }

  _body() {
    return Container(
      color: Colors.orange.shade300,
      padding: EdgeInsets.all(30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(assetName),
          Input(
            'e-mail',
            controller: _email,
          ),
          Input(
            'senha',
            controller: _password,
          ),
          Button(
            'Entrar',
            onPressed: () => _userLogin(),
          ),
        ],
      ),
    );
  }

  _userLogin() async {
    try {
      await Firebase.initializeApp();
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: _email.text,
        password: _password.text,
      )
          .then((_) {
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) => Home()));
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('Usuário não encontrado');
      } else if (e.code == 'wrong-password') {
        print('Senha errada');
      }
    }
  }
}
