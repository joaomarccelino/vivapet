import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';

class FlipCards extends StatefulWidget {
  Widget front;
  Widget back;
  bool permiteTroca;
  FlipCards(
    this.permiteTroca,
    this.front,
    this.back,
  );
  @override
  _FlipCardsState createState() => _FlipCardsState();
}

class _FlipCardsState extends State<FlipCards> {
  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();
  @override
  Widget build(BuildContext context) {
    return FlipCard(
      key: cardKey,
      flipOnTouch: widget.permiteTroca,
      speed: 2000,
      front: widget.front,
      back: widget.back,
    );
  }
}
