import 'package:flutter/material.dart';
import 'package:viva_pet/views/cadPet.dart';
import 'package:viva_pet/widgets/buttons.dart';
import 'package:viva_pet/widgets/texts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

FirebaseAuth auth = FirebaseAuth.instance;

class _HomeState extends State<Home> {
  final String user = "João";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Página inicial"),
      ),
      body: _main(),
    );
  }

  _main() {
    return Container(
      padding: EdgeInsets.all(10),
      width: double.infinity,
      color: Colors.orange.shade300,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _header(),
          _menu(),
        ],
      ),
    );
  }

  _header() {
    return Container(
      width: 350,
      padding: EdgeInsets.all(10),
      color: Color.fromRGBO(150, 228, 177, 1),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TitleText("Olá $user!!"),
        ],
      ),
    );
  }

  _menu() {
    return Container(
      child: Column(
        children: [
          Button(
            "Cadastrar Pet",
            onPressed: () => {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => CadPet()))
            },
          ),
          Button("Meus Pets"),
          Button(
            "Sair",
            onPressed: () => _logout(),
          )
        ],
      ),
    );
  }

  Future<void> _logout() async {
    await FirebaseAuth.instance.signOut().then((_) => {
          Navigator.of(context)
              .pushReplacement(MaterialPageRoute(builder: (context) => Home()))
        });
  }
}
