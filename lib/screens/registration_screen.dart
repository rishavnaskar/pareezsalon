import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:pareezsalonapp/components/authservice.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final formKey = new GlobalKey<FormState>();
  String phoneNo, verificationId, smsCode, name;
  bool codeSent = false, showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      progressIndicator: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white)),
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text(
                    'PAREEZ',
                    style: TextStyle(
                      shadows: [BoxShadow(blurRadius: 20.0, color: Colors.orange.withOpacity(0.5), offset: Offset(10.0, 25.0))],
                      fontSize: 50.0,
                      fontFamily: 'KaushanScript',
                      fontWeight: FontWeight.w900,
                      color: Colors.orange,
                      fontStyle: FontStyle.italic,
                      letterSpacing: 3.0,
                    ),
                  ),
                ),
                Flexible(
                  child: SizedBox(
                    height: 50.0,
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[900],
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      border: Border.all(color: Colors.white)
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.only(left: 25.0, right: 25.0),
                            child: TextFormField(
                              cursorColor: Colors.orange,
                              textDirection: TextDirection.ltr,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Colors.white,
                                  letterSpacing: 1.0,
                                  fontFamily: 'Montserrat'),
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                hintText: 'Enter your name',
                                hintStyle: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontSize: 14.0,
                                    wordSpacing: 5.0,
                                    fontStyle: FontStyle.italic,
                                    letterSpacing: 1.0),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.orange),
                                ),
                                icon: Icon(
                                  Icons.person_outline,
                                  color: Colors.white,
                                ),
                              ),
                              onChanged: (val) async {
                                setState(() {
                                  this.name = val;
                                });
                              },
                            )),
                        Padding(
                            padding: EdgeInsets.only(left: 25.0, right: 25.0),
                            child: TextFormField(
                              cursorColor: Colors.orange,
                              textDirection: TextDirection.ltr,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Colors.white,
                                  letterSpacing: 2.0,
                                  fontFamily: 'Montserrat'),
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                hintText: 'Enter phone number',
                                hintStyle: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontSize: 14.0,
                                    wordSpacing: 5.0,
                                    fontStyle: FontStyle.italic,
                                    letterSpacing: 1.0),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.orange),
                                ),
                                hoverColor: Colors.orange,
                                focusColor: Colors.orange,
                                icon: Icon(
                                  Icons.phone,
                                  color: Colors.white,
                                ),
                              ),
                              onChanged: (val) async {
                                setState(() {
                                  this.phoneNo = '+91$val';
                                });
                              },
                            )),
                        codeSent
                            ? Padding(
                                padding:
                                    EdgeInsets.only(left: 25.0, right: 25.0),
                                child: TextFormField(
                                  keyboardType: TextInputType.phone,
                                  decoration: InputDecoration(
                                    hintText: 'Enter OTP',
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.orange),
                                    ),
                                  ),
                                  onChanged: (val) {
                                    setState(() {
                                      this.smsCode = val;
                                    });
                                  },
                                ))
                            : Container(),
                        SizedBox(
                          height: 20.0,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 25.0, right: 25.0),
                          child: RaisedButton(
                              color: Colors.orange,
                              padding: EdgeInsets.all(10.0),
                              elevation: 10.0,
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0))),
                              child: Center(
                                  child: codeSent
                                      ? Text(
                                          'Verify',
                                          style: TextStyle(
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        )
                                      : Text(
                                          'Register / Login',
                                          style: TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        )),
                              onPressed: () async {
                                FocusScope.of(context).requestFocus(FocusNode());
                                setState(() {
                                  showSpinner = true;
                                });
                                await Firestore.instance
                                    .collection('records')
                                    .document('$phoneNo')
                                    .setData({
                                  'name': name,
                                  'phone': phoneNo,
                                });
                                if (codeSent) {
                                  await AuthService()
                                      .signInWithOTP(smsCode, verificationId);
                                } else {
                                  await verifyPhone(phoneNo);
                                }
                              }),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }

  Future<void> verifyPhone(phoneNo) async {
    final PhoneVerificationCompleted verified = (AuthCredential authResult) {
      setState(() {
        AuthService().signIn(authResult);
      });
    };

    final PhoneVerificationFailed verificationFailed =
        (AuthException authException) {
      print('${authException.message}');
    };

    final PhoneCodeSent smsSent = (String verId, [int forceResend]) {
      this.verificationId = verId;
      setState(() {
        this.codeSent = true;
      });
    };

    final PhoneCodeAutoRetrievalTimeout autoTimeout = (String verId) {
      setState(() {
        this.verificationId = verId;
      });
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNo,
        timeout: const Duration(seconds: 5),
        verificationCompleted: verified,
        verificationFailed: verificationFailed,
        codeSent: smsSent,
        codeAutoRetrievalTimeout: autoTimeout);
  }
}
