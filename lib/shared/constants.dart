import 'package:flutter/material.dart';

//Constants which may be shared across the board
const textDecoration = InputDecoration(
  //hintText: 'eMail', //We will use copyWith method to update any property which we set as constants
  fillColor: Colors.white,
  filled: true,
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.brown, width: 2.0),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.pink, width: 2.0),
  ),
);
