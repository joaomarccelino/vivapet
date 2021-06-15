import 'package:flutter/material.dart';
import 'package:viva_pet/main.dart';
import 'package:viva_pet/views/authUser.dart';
import 'package:viva_pet/views/cadPet.dart';
import 'package:viva_pet/views/listPet.dart';
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
  final String assetName = 'images/logo.png';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Seja bem vindo(a) $user"),
      ),
      body: _main(),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            label: "Cadastrar Pet",
            icon: IconButton(
                icon: Icon(Icons.pets),
                onPressed: () => {
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => CadPet()))
                    }),
          ),
          BottomNavigationBarItem(
            label: "Meus Pets",
            icon: IconButton(
                icon: Icon(Icons.search),
                onPressed: () => {
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => ListPet()))
                    }),
          ),
          BottomNavigationBarItem(
            label: "Sair",
            icon: IconButton(
              icon: Icon(
                Icons.logout,
                color: Color.fromRGBO(255, 0, 0, 0.5),
              ),
              onPressed: () => _logout(),
            ),
          ),
        ],
      ),
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
          _body(),
        ],
      ),
    );
  }

  _header() {
    return Container(
      width: 350,
      padding: EdgeInsets.all(10),
      color: PrimaryColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Aqui você pode consultar, cadastrar e acompanhar o seus animaizinhos!!!",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  _body() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(assetName),
        ],
      ),
    );
  }

  Future<void> _logout() async {
    await FirebaseAuth.instance.signOut().then((_) => {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => AuthUser()))
        });
  }
}
