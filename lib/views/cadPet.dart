import 'dart:io';

import 'package:flutter/material.dart';
import 'package:viva_pet/main.dart';
import 'package:viva_pet/views/home.dart';
import 'package:viva_pet/widgets/buttons.dart';
import 'package:viva_pet/widgets/images.dart';
import 'package:viva_pet/widgets/input.dart';
import 'package:smart_select/smart_select.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:viva_pet/widgets/texts.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CadPet extends StatefulWidget {
  @override
  _CadPetState createState() => _CadPetState();
}

FirebaseAuth auth = FirebaseAuth.instance;

firebase_storage.FirebaseStorage storage =
    firebase_storage.FirebaseStorage.instance;

class _CadPetState extends State<CadPet> {
  File _imageFile;
  final _nome = TextEditingController();
  bool selectedImage = false;
  String petPicture;
  String petUrl;

  CollectionReference pets = FirebaseFirestore.instance.collection('pets');

  ListItem _type;
  List<ListItem> types = [
    ListItem('Gato', 'Gato'),
    ListItem('Cachorro', 'Cachorro'),
  ];
  ListItem _race;
  List<ListItem> races = [
    ListItem('Vira-lata', 'Vira-lata'),
    ListItem('Pit-Bull', 'Pit-Bull'),
    ListItem('RotWeiller', 'RotWeiller'),
  ];
  ListItem _castrated;
  List<ListItem> castratedOptions = [
    ListItem('Sim', 'Sim'),
    ListItem('Não', 'Não'),
  ];
  Future<void> addPet() {
    final User user = auth.currentUser;
    final userId = user.uid;
    Firebase.initializeApp();
    return pets
        .add({
          'name': _nome.text,
          'type': _type.value,
          'race': _race.value,
          'castrated': _castrated.value,
          'owner': userId,
          'petPicture': '',
        })
        .then((value) => {
              this.setState(() {
                petUrl = value.id;
              }),
              uploadFile(_imageFile.path, petUrl, _nome.text),
            })
        .catchError((error) =>
            {AlertDialog(title: Text('Falha ao adicionar o animal: $error'))});
  }

  final picker = ImagePicker();
  Future pickImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    setState(() {
      _imageFile = File(pickedFile.path);
      selectedImage = true;
    });
  }

  Future<void> uploadFile(
      String filePath, String fileName, String petname) async {
    final User user = auth.currentUser;
    final userId = user.uid;
    Firebase.initializeApp();
    try {
      String petPic;
      await firebase_storage.FirebaseStorage.instance
          .ref('$userId/$fileName/$petname')
          .putFile(_imageFile)
          .then((value) async => {
                petPic = await value.ref.getDownloadURL(),
                this.setState(() {
                  petPicture = petPic;
                }),
              })
          .then((value) => addPetPic());
    } on FirebaseException catch (e) {}
  }

  Future<void> addPetPic() {
    Firebase.initializeApp();
    return pets.doc(petUrl).update({'petPicture': petPicture}).then(
      (_) => Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => Home())),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Insira os dados do seu animal"),
        ),
        body: _body(),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              label: "Adicionar",
              icon:
                  IconButton(icon: Icon(Icons.pets), onPressed: () => addPet()),
            ),
            BottomNavigationBarItem(
              label: "Voltar",
              icon: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Color.fromRGBO(255, 0, 0, 0.5),
                ),
                onPressed: () => Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => Home())),
              ),
            ),
          ],
        ));
  }

  _body() {
    return Container(
      padding: EdgeInsets.all(10),
      width: double.infinity,
      color: Colors.orange.shade300,
      child: Column(
        children: [
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
          false,
          controller: _nome,
        ),
        Select("Tipo", types, _type, onChange: (selectValue) {
          setState(() {
            _type = selectValue;
          });
        }),
        Select("Raça", races, _race, onChange: (selectValue2) {
          setState(() {
            _race = selectValue2;
          });
        }),
        Select(
          "Castrado?",
          castratedOptions,
          _castrated,
          onChange: ((selectValue3) {
            setState(() {
              _castrated = selectValue3;
            });
          }),
        ),
        selectedImage
            ? Image.file(
                _imageFile,
                width: 150,
                height: 150,
                fit: BoxFit.fitHeight,
              )
            : IconButton(
                icon: Icon(
                  Icons.camera_alt_rounded,
                  color: PrimaryColor,
                  size: 50,
                ),
                onPressed: () => pickImage())
      ],
    ));
  }
}
