import 'package:flutter/material.dart';
import 'package:viva_pet/widgets/buttons.dart';
import 'package:viva_pet/widgets/input.dart';
import 'package:smart_select/smart_select.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:viva_pet/widgets/texts.dart';

import 'package:firebase_auth/firebase_auth.dart';

class CadPet extends StatefulWidget {
  @override
  _CadPetState createState() => _CadPetState();
}

FirebaseAuth auth = FirebaseAuth.instance;

class _CadPetState extends State<CadPet> {
  CollectionReference pets = FirebaseFirestore.instance.collection('pets');
  List<S2Choice<String>> types = [
    S2Choice<String>(value: 'Gato', title: 'Gato'),
    S2Choice<String>(value: 'Cachorro', title: 'Cachorro'),
  ];
  String type;
  List<S2Choice<String>> races = [
    S2Choice<String>(value: 'Vira-Lata', title: 'Vira-Lata'),
    S2Choice<String>(value: 'Pit-Bull', title: 'Pit-Bull'),
    S2Choice<String>(value: 'RotWeiller', title: 'RotWeiller'),
  ];
  String race;
  Future<void> addPet() {
    final User user = auth.currentUser;
    final userId = user.uid;
    Firebase.initializeApp();
    return pets
        .add({
          'name': _nome.text,
          'type': type,
          'race': race,
          'owner': userId,
        })
        .then((value) =>
            AlertDialog(title: Text("Animal adicionado com sucesso!")))
        .catchError((error) =>
            AlertDialog(title: Text("Falha ao adicionar o animal: $error")));
  }

  final _nome = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastrar Pet"),
      ),
      body: _body(),
    );
  }

  _body() {
    return Container(
      padding: EdgeInsets.all(10),
      width: double.infinity,
      color: Colors.orange.shade300,
      child: Column(
        children: [
          TitleText("Insira os dados do seu animal"),
          _form(),
        ],
      ),
    );
  }

  _form() {
    return Form(
        child: Column(
      children: [
        Input(
          "Nome",
          controller: _nome,
        ),
        Select("Tipo: ", type, types,
            onChange: (state) => setState(() => type = state.value)),
        Select("Raça: ", race, races,
            onChange: (state) => setState(() => race = state.value)),
        Button(
          "Adicionar",
          onPressed: () => addPet(),
        )
      ],
    ));
  }
}
