import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pareezsalonapp/screens/email_screen.dart';

class WidgetText extends StatelessWidget {
  WidgetText({@required this.text, @required this.cost});
  final String text;
  final int cost;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Colors.orange),
        boxShadow: [BoxShadow(blurRadius: 10.0, offset: Offset(2.0, 4.0))]
      ),
      child: ListTile(
        title: FittedBox(fit: BoxFit.scaleDown, child: Text('$text',textAlign: TextAlign.center, style: TextStyle(color: Colors.white, letterSpacing: 1.0))),
        enabled: true,
        trailing: Text('₹$cost',textAlign: TextAlign.center, style: TextStyle(color: Colors.white)),
        focusColor: Colors.grey,
        onTap: (){
          Navigator.push(
            context,
            new CupertinoPageRoute(
              builder: (context) => EmailScreen(emailBody: text, cost: cost),
            ),
          );
        },
      ),
    );


//      return Container(
//        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
//        decoration: kTextDecoration,
//        child: GestureDetector(
//          onTap: (){
//              Navigator.push(
//                context,
//                new CupertinoPageRoute(
//                  builder: (context) => EmailScreen(emailBody: text,),
//                ),
//              );
//          },
//          child: Center(
//            child: Text(
//              text,
//              style: TextStyle(
//                color: Colors.white,
//                fontSize: 20.0,
//                wordSpacing: 3.0,
//                fontWeight: FontWeight.bold,
//              ),
//            ),
//          ),
//        ),
//      );
  }
}
