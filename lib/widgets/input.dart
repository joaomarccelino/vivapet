import 'package:flutter/material.dart';

import 'package:smart_select/smart_select.dart';
import 'package:viva_pet/main.dart';

class ListItem {
  String value;
  String title;

  ListItem(this.value, this.title);
}

class Input extends StatelessWidget {
  String label;
  bool senha;
  TextEditingController controller;

  Input(this.label, this.senha, {this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5.0),
      child: Column(
        children: [
          TextFormField(
            cursorColor: PrimaryColor,
            controller: controller,
            obscureText: senha,
            decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.always,
                labelText: label,
                focusColor: Colors.white,
                labelStyle: TextStyle(
                  color: Colors.grey.shade800,
                  fontSize: 20,
                ),
                border: OutlineInputBorder(borderSide: BorderSide())),
          )
        ],
      ),
    );
  }
}

class Select extends StatefulWidget {
  String label;
  List<ListItem> options;
  ListItem _selectedItem;
  final Function onChange;
  Select(this.label, this.options, this._selectedItem, {this.onChange});
  @override
  _Select createState() => _Select();
}

class _Select extends State<Select> {
  List<DropdownMenuItem<ListItem>> _dropdownMenuItems;

  void initState() {
    super.initState();
    _dropdownMenuItems = buildDropDownMenuItems(widget.options);
  }

  List<DropdownMenuItem<ListItem>> buildDropDownMenuItems(List listItems) {
    List<DropdownMenuItem<ListItem>> items = [];
    for (ListItem listItem in listItems) {
      items.add(
        DropdownMenuItem(
          child: Text(listItem.value),
          value: listItem,
        ),
      );
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15.0),
      alignment: Alignment.bottomLeft,
      child: DropdownButton<ListItem>(
        value: widget._selectedItem,
        items: _dropdownMenuItems,
        onChanged: widget.onChange,
        hint: Text(widget.label),
      ),
    );
  }
}
