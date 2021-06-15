import 'package:flutter/material.dart';
import 'package:viva_pet/views/home.dart';
import 'package:viva_pet/widgets/buttons.dart';
import 'package:viva_pet/widgets/input.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthUser extends StatefulWidget {
  @override
  _AuthUserState createState() => _AuthUserState();
}

FirebaseAuth auth = FirebaseAuth.instance;

class _AuthUserState extends State<AuthUser> {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  final _name = TextEditingController();
  final _cpf = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirmPassword = TextEditingController();
  bool stageNew = false;

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
          stageNew ? _signIn() : _login(),
        ],
      ),
    );
  }

  _login() {
    return Form(
      child: Column(
        children: [
          Input(
            'e-mail',
            false,
            controller: _email,
          ),
          Input(
            'senha',
            true,
            controller: _password,
          ),
          Button(
            'Entrar',
            onPressed: () => _userLogin(),
          ),
          InkWell(
            child: Text("Ainda não é cadastrado?"),
            onTap: () => this.setState(() {
              stageNew = true;
            }),
          ),
        ],
      ),
    );
  }

  _signIn() {
    return Form(
      child: Column(
        children: [
          Input(
            'nome',
            false,
            controller: _name,
          ),
          Input(
            'cpf',
            false,
            controller: _cpf,
          ),
          Input(
            'e-mail',
            false,
            controller: _email,
          ),
          Input(
            'senha',
            true,
            controller: _password,
          ),
          Input(
            'confirme a senha',
            true,
            controller: _confirmPassword,
          ),
          Button(
            'Cadastrar',
            onPressed: () => _userSignIn(),
          ),
          InkWell(
            child: Text("Já tem cadastro?"),
            onTap: () => this.setState(() {
              stageNew = false;
            }),
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

  _userSignIn() async {
    if (_password == _confirmPassword) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: _email.text, password: _password.text)
            .then((value) => _userSaveData(value.user.uid));
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print('Senha muito Fraca');
        } else if (e.code == 'email-already-in-use') {
          print('E-mail já utilizado');
        }
      } catch (e) {
        print(e);
      }
    } else {
      return AlertDialog(
        title: Text("Atenção!"),
        content: Text("As senhas não batem"),
      );
    }
  }

  _userSaveData(String uid) {
    users.doc(uid).set({
      "name": _name.text,
      "cpf": _cpf.text,
    }).then((value) => AlertDialog(
          title: Text("Usuário Cadastrado com sucesso!"),
        ));
  }
}
