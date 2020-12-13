import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:pareezsalonapp/components/drawer_screen.dart';
import 'package:pareezsalonapp/screens/booking_screen.dart';
import 'package:pareezsalonapp/screens/home_screen.dart';

class Mailer {
  sendMail(BuildContext context) async {
    String username = DotEnv().env['username'];
    String password = DotEnv().env['password'];
    String temp = '';
    List items = [];
    List costItems = [];

    for (int i = 0; i < selectedItems.length; i++) {
      String a = '${selectedItems[i]} - ₹${selectedItemsCost[i]}<br>';
      temp = temp + a;
      items.add('${selectedItems[i]}');
      costItems.add(selectedItemsCost[i]);
    }

    final smtpServer = gmail(username, password);

    final message = Message()
      ..from = Address(username, 'Pareez Salon')
      ..recipients.add('$email')
      ..ccRecipients
          .addAll(['rinkusahanaskar@gmail.com', 'pareez.salon@gmail.com'])
      ..subject = 'Pareez Salon appointment'
      ..html =
          "<h1>Pareez Salon</h1>\n<p>Here is the confirmation of your appointment</p>\n\n<p>Your appointment for $displayName has been successfully booked for ${selectedDate.day}/${selectedDate.month}/${selectedDate.year} at ${selectedTime.format(context)}.</p>\n\n\n<p>The services requested are as follows -</p>\n<p>$temp</p>";

    try {
      final sendReport = await send(message, smtpServer);
      addToCloud(context, items, costItems);
      print('Message sent: ' + sendReport.toString());
      return 'success';
    } on MailerException catch (e) {
      print('Message not sent.');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
      return 'error';
    }
  }

  addToCloud(BuildContext context, List tempItems, List costItems) async {
    final result = await Firestore.instance
        .collection('records')
        .where('email', isEqualTo: email)
        .getDocuments();

    String docID;
    for (var res in result.documents) {
      docID = res.documentID;
    }

    Firestore.instance
        .collection('records')
        .document('$docID')
        .collection('history')
        .add({
      'date': '${selectedDate.day}-${selectedDate.month}-${selectedDate.year}',
      'time': selectedTime.format(context),
      'items': FieldValue.arrayUnion(tempItems),
      'cost': FieldValue.arrayUnion(costItems),
      'gender': selectedGender.toString(),
      'timestamp': FieldValue.serverTimestamp()
    });
  }
}
