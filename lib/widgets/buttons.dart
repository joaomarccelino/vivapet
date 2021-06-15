import 'package:flutter/material.dart';
import 'package:viva_pet/main.dart';
import 'package:viva_pet/widgets/images.dart';

class Button extends StatelessWidget {
  final String text;
  final Function onPressed;
  Button(this.text, {this.onPressed});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      child: Column(
        children: [
          TextButton(
            onPressed: onPressed,
            child: Text(
              text,
              style: TextStyle(color: Colors.grey.shade200, fontSize: 25),
            ),
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(PrimaryColor)),
          )
        ],
      ),
    );
  }
}

class Button2 extends StatelessWidget {
  final String text;
  final Function onPressed;
  Button2(this.text, {this.onPressed});
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.green)),
        child: Text(
          text,
          style: TextStyle(color: Colors.grey.shade200, fontSize: 25),
        ),
        onPressed: onPressed);
  }
}

class Button3 extends StatelessWidget {
  final String title;
  final Function onPressed;
  final String image;
  Button3(this.title, this.image, {this.onPressed});
  @override
  Widget build(BuildContext context) {
    return Card(
      color: PrimaryColor,
      child: ListTile(
        leading: PetImage(
          imagePath: image,
          imgHeight: 50,
          imgWidth: 50,
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        subtitle: Text(
          "Clique para informações",
          style: TextStyle(
            fontSize: 12,
            color: Colors.white,
          ),
        ),
        onTap: onPressed,
      ),
    );
  }
}
