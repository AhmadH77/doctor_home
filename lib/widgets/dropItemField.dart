import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DropItemField extends StatelessWidget{
  final List<DropdownMenuItem<String>>? dropdownItems;
  final String? value,hintText;
  final onChange;

  const DropItemField({Key? key, this.dropdownItems, this.value, this.onChange, this.hintText}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DropdownButtonFormField(
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.black),
          enabledBorder: OutlineInputBorder(
            // borderSide: BorderSide(color: Colors.transparent, width: 2),
            borderRadius: BorderRadius.circular(30),
          ),
          border: OutlineInputBorder(
            // borderSide: BorderSide(color: Colors.transparent, width: 2),
            borderRadius: BorderRadius.circular(30),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
        validator: (value) => value == null ? hintText ??"Select" : null,
        // dropdownColor: Colors.blueAccent,
        value: value,
        onChanged: onChange,
        items: dropdownItems);
  }

}