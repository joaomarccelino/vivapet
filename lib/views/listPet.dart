import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:viva_pet/views/cadPet.dart';
import 'package:viva_pet/views/home.dart';
import 'package:viva_pet/views/petData.dart';
import 'package:viva_pet/widgets/buttons.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_auth/firebase_auth.dart';

class ListPet extends StatefulWidget {
  @override
  _ListPetState createState() => _ListPetState();
}

FirebaseAuth auth = FirebaseAuth.instance;
firebase_storage.FirebaseStorage storage =
    firebase_storage.FirebaseStorage.instance;
final User user = auth.currentUser;
final userId = user.uid;

class _ListPetState extends State<ListPet> {
  List<String> petsList;
  CollectionReference pets = FirebaseFirestore.instance.collection('pets');
  final Stream<QuerySnapshot> _pets = FirebaseFirestore.instance
      .collection('pets')
      .where('owner', isEqualTo: userId)
      .snapshots();
  String documentId;
  @override
  Widget build(BuildContext context) {
    Firebase.initializeApp();
    return Scaffold(
      appBar: AppBar(
        title: Text("Meus Pets"),
      ),
      body: _body(context),
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
            label: "Voltar",
            icon: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Color.fromRGBO(255, 0, 0, 0.5),
              ),
              onPressed: () => {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => Home()))
              },
            ),
          ),
        ],
      ),
    );
  }

  _body(context) {
    return Container(
        padding: EdgeInsets.all(10),
        width: double.infinity,
        color: Colors.orange.shade300,
        child: _listPets(context));
  }

  _listPets(context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _pets,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        return new ListView(
          children: snapshot.data.docs.map((DocumentSnapshot document) {
            return Button3(
              document.data()['name'],
              document.data()['petPicture'],
              onPressed: () {
                _showPet(
                    context,
                    document.data()['name'],
                    document.data()['petPicture'],
                    document.data()['castrated'],
                    document.data()['race']);
              },
            );
          }).toList(),
        );
      },
    );
  }

  _showPet(BuildContext context, String name, String petPicture,
      String castrated, String race) {
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
      return PetData(name, castrated, petPicture, race);
    }));
  }
}
