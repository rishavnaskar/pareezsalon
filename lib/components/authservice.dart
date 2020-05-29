import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pareezsalonapp/screens/registration_screen.dart';
import 'bottomNavigationBar.dart';

class AuthService {
  handleAuth() {
    return StreamBuilder(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          return BottomNavBar();
        } else {
          return RegistrationScreen();
        }
      },
    );
  }

  signIn(AuthCredential authCredential) {
    FirebaseAuth.instance.signInWithCredential(authCredential);
  }

  signInWithOTP(smsCode, verID) {
    AuthCredential authCreds = PhoneAuthProvider.getCredential(verificationId: verID, smsCode: smsCode);
    signIn(authCreds);
  }
}
