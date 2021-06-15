import 'package:flutter/material.dart';

class PetImage extends StatefulWidget {
  final String imagePath;
  final double imgWidth;
  final double imgHeight;
  PetImage({
    Key key,
    this.imagePath,
    this.imgHeight,
    this.imgWidth,
  }) : super(key: key);

  @override
  _PetImageState createState() => _PetImageState();
}

class _PetImageState extends State<PetImage> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(50.0),
      child: Image.network(
        widget.imagePath,
        filterQuality: FilterQuality.high,
        width: widget.imgWidth,
        height: widget.imgHeight,
      ),
    );
  }
}
