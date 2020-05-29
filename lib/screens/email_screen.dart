import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pareezsalonapp/components/custom_app_bar.dart';
import 'package:pareezsalonapp/components/rounded_Button.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants.dart';

class EmailScreen extends StatefulWidget {
  EmailScreen({@required this.emailBody, @required this.cost});
  final String emailBody;
  final int cost;

  @override
  _EmailScreenState createState() => _EmailScreenState();
}

class _EmailScreenState extends State<EmailScreen> {
  String name, phoneNo, email;

//  void getCurrentUser() async {
//    try {
//      final user = await FirebaseAuth.instance.currentUser();
//      if (user != null) {
//        setState(() {
//          phoneNo = user.phoneNumber;
//        });
//      }
//    } catch (e) {
//      print(e);
//    }
//  }
//
//  void getRecords() async {
//    final records =
//        await Firestore.instance.collection('records').getDocuments();
//    for (var record in records.documents) {
//      if (record.data['phone'] == phoneNo) {
//        name = record.data['name'];
//      }
//    }
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        leading: CustomAppBar().appBarBackIcon(context),
        title: CustomAppBar().appBarTitle(false),
        actions: <Widget>[
          CustomAppBar().appBarCallIcon(),
        ],
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(
              height: 40.0,
            ),
            Container(
              child: TypewriterAnimatedTextKit(
                text: ['A luxurious service is just an Email ahead !'],
                alignment: AlignmentDirectional.topStart,
                textAlign: TextAlign.center,
                isRepeatingAnimation: false,
                speed: Duration(milliseconds: 100),
                textStyle: TextStyle(
                  color: Colors.amber[100],
                  fontSize: 30.0,
                  letterSpacing: 1.0,
                  fontFamily: 'KaushanScript',
                ),
              ),
            ),
            Expanded(flex: 2,child: SizedBox(height: 20.0)),
            Align(alignment: Alignment.center, child: Container(height: 2.0, color: Colors.white)),
//              Container(
//                child: Icon(
//                  Icons.watch_later,
//                  size: 80.0,
//                  color: Colors.orange,
//                ),
//              ),
            Flexible(child: SizedBox(height: 60.0,)),
            Container(
              child: Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: TextField(
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
                    email = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                    hintText:
                        'Enter client\'s email address', //'Enter your preferred time',
                    filled: true,
                  ),
                ),
              ),
            ),
            Container(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 30.0),
                child: TextField(
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.text,
                  onChanged: (value) {
                    name = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                    hintText:
                    'Enter client\'s name', //'Enter your preferred time',
                    filled: true,
                  ),
                ),
              ),
            ),
            Container(
              child: RoundButton(
                color: Colors.orange,
                title: 'Book Now',
                onPressed: () async {
                  _launchURL('$email', 'Pareez Salon Payment Receipt',
                      'Name - $name, Service - ${widget.emailBody}, Amount - ${widget.cost}');
                },
              ),
            ),
            Expanded(child: SizedBox(height: 20.0)),
          ],
        ),
      ),
    );
  }
}

_launchURL(String toMailId, String subject, String body) async {
  var url = 'mailto:$toMailId?subject=$subject&body=$body';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
