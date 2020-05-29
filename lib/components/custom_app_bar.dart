import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'location.dart';

class CustomAppBar
{
  appBarLocationIcon () {
    return IconButton(
      onPressed: () async {
        MapUtils().openMap();
      },
      icon: Icon(
        Icons.location_on,
        color: Colors.white,
      ),
    );
  }

  appBarTitle (bool value) {
    return FittedBox(
      fit: BoxFit.fitWidth,
      child: ColorizeAnimatedTextKit(
        text: ['Pareez Salon'],
        totalRepeatCount: 2,
        isRepeatingAnimation: value,
        textStyle: TextStyle(
          fontSize: 30.0,
          fontFamily: 'Montserrat',
          letterSpacing: 3.0,
          color: Colors.white,
        ),
        colors: [
          Colors.white,
          Colors.orange,
          Colors.red,
          Colors.yellow,
          Colors.yellow[900],
        ],
      ),
    );
  }

  appBarCallIcon () {
    return IconButton(
      onPressed: () {
        CallsAndMessagesService().call();
      },
      icon: Icon(
        Icons.phone_in_talk,
        color: Colors.white,
      ),
    );
  }

  appBarBackIcon (BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      color: Colors.white,
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }
}
