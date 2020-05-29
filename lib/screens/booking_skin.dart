import 'package:flutter/material.dart';
import 'package:pareezsalonapp/components/widgetText.dart';


class BookingSkin extends StatefulWidget {
  @override
  _BookingSkinState createState() => _BookingSkinState();
}

class _BookingSkinState extends State<BookingSkin> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.vertical,
      padding: const EdgeInsets.all(10.0),
      children: <Widget>[
        SizedBox(height: 20.0,),
        WidgetText(text: 'Face Clean Up',cost: 100),

        SizedBox(height: 20.0,),
        WidgetText(text: 'Face Detan',cost: 100),

        SizedBox(height: 25.0,),
        WidgetText(text: 'Facial (BASIC)',cost: 100),

        SizedBox(height: 25.0,),
        WidgetText(text: 'Facial (Advanced)',cost: 100),

        SizedBox(height: 20.0,),
        WidgetText(text: 'Waxing (Regular)',cost: 100),

        SizedBox(height: 20.0,),
        WidgetText(text: 'Lipo Soluble Waxing',cost: 100),

        SizedBox(height: 20.0,),
        WidgetText(text: 'Body Polishing',cost: 100),

        SizedBox(height: 20.0,)
      ],
    );
  }
}
