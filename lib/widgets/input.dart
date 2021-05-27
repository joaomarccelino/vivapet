import 'package:flutter/material.dart';

import 'package:smart_select/smart_select.dart';

class Input extends StatelessWidget {
  String label;
  TextEditingController controller;

  Input(this.label, {this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: label,
        focusColor: Colors.white,
        hintStyle: TextStyle(
          color: Colors.grey.shade600,
          fontSize: 15,
          backgroundColor: Colors.white,
        ),
      ),
    );
  }
}

class Select extends StatelessWidget {
  String title;
  String value;
  List<S2Choice<String>> options;
  final Function onChange;

  Select(this.title, this.value, this.options, {this.onChange});

  @override
  Widget build(BuildContext context) {
    return SmartSelect<String>.single(
      title: title,
      value: value,
      choiceItems: options,
      onChange: onChange,
    );
  }
}
