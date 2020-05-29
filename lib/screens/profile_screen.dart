import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pareezsalonapp/components/authservice.dart';
import 'package:pareezsalonapp/components/custom_app_bar.dart';
import 'package:pareezsalonapp/components/rounded_Button.dart';

String phoneNo;

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await FirebaseAuth.instance.currentUser();
      if (user != null) {
        setState(() {
          phoneNo = user.phoneNumber;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 10.0,
        centerTitle: true,
        leading: CustomAppBar().appBarLocationIcon(),
        title: CustomAppBar().appBarTitle(false),
        actions: <Widget>[
          CustomAppBar().appBarCallIcon(),
        ],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: SizedBox(
                height: 30.0,
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey[900],
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(color: Colors.orange)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Center(
                      child: Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Icon(
                          Icons.phone,
                          size: 80.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Flexible(
                      child: SizedBox(
                        height: 20.0,
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            '$phoneNo',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Montserrat',
                              letterSpacing: 2.0,
                              fontWeight: FontWeight.bold,
                              fontSize: 25.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                    NameStream(),
                    Expanded(
                      flex: 1,
                      child: SizedBox(
                        height: 30.0,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.0),
                      child: Container(height: 2.0, color: Colors.white),
                    ),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: RoundButton(
                            color: Colors.orange,
                            title: 'Log Out',
                            onPressed: () {
                              FirebaseAuth.instance.signOut();
                              setState(() {
                                AuthService().handleAuth();
                              });
                            }),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: SizedBox(
                height: 30.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NameStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
        stream: Firestore.instance
            .collection('records')
            .document('$phoneNo')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return new Text("Loading");
          }
          var userDocument = snapshot.data['name'];
          return Center(
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                '$userDocument',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30.0,
                  fontFamily: 'Montserrat',
                  letterSpacing: 2.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        });
  }
}
