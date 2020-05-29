import 'package:flutter/material.dart';
import 'package:pareezsalonapp/components/widgetText.dart';

class BookingBridal extends StatefulWidget {
  @override
  _BookingBridalState createState() => _BookingBridalState();
}

class _BookingBridalState extends State<BookingBridal> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.vertical,
      padding: const EdgeInsets.all(10.0),
      children: <Widget>[
        SizedBox(height: 20.0,),
        WidgetText(text: 'Make Up',cost: 100),

        SizedBox(height: 20.0,),
        WidgetText(text: 'Party Makeup',cost: 100),

        SizedBox(height: 25.0,),
        WidgetText(text: 'Bridal Makeup',cost: 100),

        SizedBox(height: 20.0,),
        WidgetText(text: 'Makup for Reception',cost: 100),

        SizedBox(height: 20.0,),
        WidgetText(text: 'Groom Makeup',cost: 100),

        SizedBox(height: 20.0,),
      ],
    );
  }
}
