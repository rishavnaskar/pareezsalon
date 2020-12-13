import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleLoginIn {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googlSignIn = GoogleSignIn();

  void googleLogInUser(BuildContext context) async {
    try {
      final GoogleSignInAccount googleSignInAccount = await _googlSignIn
          .signIn();
      final GoogleSignInAuthentication googleAuth =
      await googleSignInAccount.authentication;
      final AuthCredential credential = GoogleAuthProvider.getCredential(
          idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);
      await _firebaseAuth.signInWithCredential(credential)
          .whenComplete(() async {
        final users = await Firestore.instance.collection('records').getDocuments();
        int cnt = 0;

        for (var user in users.documents) {
          if (user.data['email'] == googleSignInAccount.email) {
            cnt++;
          }
        }

        if (cnt == 0) {
          Firestore.instance.collection('records').add({
            'email': googleSignInAccount.email,
            'name': googleSignInAccount.displayName,
            'id': googleSignInAccount.id,
            'photoUrl': googleSignInAccount.photoUrl,
          });
        }
      });
    } catch (error) {
      print(error);
    }
  }

  void googleLogOutUser(BuildContext context) {
    _googlSignIn.signOut();
    _firebaseAuth.signOut();
  }
}
