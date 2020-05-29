import 'package:flutter/material.dart';

const kSendButtonTextStyle = TextStyle(
  color: Colors.lightBlueAccent,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

const kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type your message here...',
  border: InputBorder.none,
);

final kTextDecoration = BoxDecoration(
  color: Colors.black,
  border:
      Border.all(width: 1.0, color: Colors.orange, style: BorderStyle.solid),
  borderRadius: BorderRadius.all(Radius.circular(20.0)),
);

const kTextFieldDecoration = InputDecoration(
  fillColor: Colors.white,
  filled: false,
  hintText: 'Enter a value',
  hintStyle: TextStyle(fontFamily: 'Montserrat', color: Colors.black),
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.orangeAccent, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.orangeAccent, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
  ),
);
