import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:viva_pet/main.dart';
import 'package:viva_pet/widgets/flipCard.dart';
import 'package:viva_pet/widgets/texts.dart';

class PetData extends StatelessWidget {
  String assetName = 'images/vacina.png';
  String name;
  String castrated;
  String race;
  String petPicture;
  PetData(this.name, this.castrated, this.petPicture, this.race);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            name,
            style: TextStyle(fontSize: 25),
          ),
        ),
        body: FlipCards(true, _body(), _vaccine()));
  }

  _body() {
    return Container(
      padding: EdgeInsets.all(10),
      width: double.infinity,
      color: Colors.orange.shade300,
      child: Column(
        children: <Widget>[
          Image.network(
            petPicture,
            fit: BoxFit.fill,
          ),
          Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.pets_sharp),
                  title: DescriptionText("Raça: $race"),
                  subtitle: Text("Castrado: $castrated"),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  _vaccine() {
    return Container(
        color: PrimaryColor,
        child: GridView(
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
          children: [
            Image.asset(
              assetName,
              fit: BoxFit.fill,
            ),
            Image.asset(
              assetName,
              fit: BoxFit.fill,
            ),
            Image.asset(
              assetName,
              fit: BoxFit.fill,
            ),
            Image.asset(
              assetName,
              fit: BoxFit.fill,
            ),
            Image.asset(
              assetName,
              fit: BoxFit.fill,
            ),
            Image.asset(
              assetName,
              fit: BoxFit.fill,
            ),
            Image.asset(
              assetName,
              fit: BoxFit.fill,
            ),
            Image.asset(
              assetName,
              fit: BoxFit.fill,
            ),
            Image.asset(
              assetName,
              fit: BoxFit.fill,
            )
          ],
        ));
  }
}
