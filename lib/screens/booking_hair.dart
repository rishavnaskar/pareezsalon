import 'package:flutter/material.dart';
import 'package:pareezsalonapp/components/widgetText.dart';

class BookingHair extends StatefulWidget {
  @override
  _BookingHairState createState() => _BookingHairState();
}

class _BookingHairState extends State<BookingHair> {

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.vertical,
      padding: const EdgeInsets.all(10.0),
      children: <Widget>[
        SizedBox(height: 20.0,),
        WidgetText(text: 'Men\'s Hair Cut with Hairwash',cost: 100),

        SizedBox(height: 20.0,),
        WidgetText(text: 'Men\'s Hair Spa',cost: 100),

        SizedBox(height: 25.0,),
        WidgetText(text: 'Men\'s Hair Color',cost: 100),

        SizedBox(height: 20.0,),
        WidgetText(text: 'Women\'s Hair Cut with Hairwash',cost: 100),

        SizedBox(height: 20.0,),
        WidgetText(text: 'Women\'s Hair Smoothning',cost: 100),

        SizedBox(height: 20.0,),
        WidgetText(text: 'Women\'s Hair Spa',cost: 100),

        SizedBox(height: 20.0,),
        WidgetText(text: 'Women\'s Hair Treatment',cost: 100),

        SizedBox(height: 20.0,),
        WidgetText(text: 'Women\'s Hair colour (GLOBAL)',cost: 100),

        SizedBox(height: 20.0,),
        WidgetText(text: 'Women\'s Hair colour (HIGHLIGHT)',cost: 100),

        SizedBox(height: 20.0,),
        WidgetText(text: 'Women\'s Hair colour (ROOT TOUCH UP)',cost: 100),

        SizedBox(height: 20.0,),
      ],
    );
  }
}

