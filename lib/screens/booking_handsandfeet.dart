import 'package:flutter/material.dart';
import 'package:pareezsalonapp/components/widgetText.dart';

class BookingHandsAndFeet extends StatefulWidget {
  @override
  _BookingHandsAndFeetState createState() => _BookingHandsAndFeetState();
}

class _BookingHandsAndFeetState extends State<BookingHandsAndFeet> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.vertical,
      padding: const EdgeInsets.all(10.0),
      children: <Widget>[
        SizedBox(height: 20.0,),
        WidgetText(text: 'Pedicure (Basic)',cost: 100),

        SizedBox(height: 25.0,),
        WidgetText(text: 'Pedicure (Luxury)',cost: 100),

        SizedBox(height: 20.0,),
        WidgetText(text: 'Foot Spa',cost: 100),

        SizedBox(height: 20.0,),
        WidgetText(text: 'Manicure (Basic)',cost: 100),

        SizedBox(height: 20.0,),
        WidgetText(text: 'Manicure (Luxury)',cost: 100),

        SizedBox(height: 20.0,),
        WidgetText(text: 'Hand Spa',cost: 100),

        SizedBox(height: 20.0,),
        WidgetText(text: 'Hands and Feet De-tan',cost: 100),

        SizedBox(height: 20.0,)
      ],
    );
  }
}
