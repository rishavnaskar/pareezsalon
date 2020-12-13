import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pareezsalonapp/components/drawer_screen.dart';
import 'package:pareezsalonapp/login/login_screen.dart';

class AuthService {
  String email, photoUrl, displayName;
  AuthService() {
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await FirebaseAuth.instance.currentUser();
      if (user != null) {
          email = user.email;
          photoUrl = user.photoUrl;
          displayName = user.displayName;
      }
    } catch (e) {
      print(e);
    }
  }

  handleAuth() {
    return StreamBuilder(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          AuthService();
          return DrawerPage(email: email, displayName: displayName, photoUrl: photoUrl);
        } else {
          return LoginScreen();
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
