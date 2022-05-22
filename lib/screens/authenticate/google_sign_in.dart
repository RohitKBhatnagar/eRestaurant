import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInProvider extends ChangeNotifier {
  //Create local instance of GoogleSignIn
  final googleSignIn = GoogleSignIn();

  //Local private user
  GoogleSignInAccount? _gUser;

  //Getter method for signed in Google user
  GoogleSignInAccount get user => _gUser!;

  //Method to sign in and authenticate the Google user
  Future googleLogin() async {
    //Display Google SignIn options if multiple users
    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) return;
    _gUser = googleUser;

    //Authenticate Google user selected
    final googleAuth = await googleUser.authentication;

    //gCredential will collect the authenticated Google users access token and id for user later for firebase
    final gCredential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    //Pass the gCredential details to now actually perform the authentication
    await FirebaseAuth.instance.signInWithCredential(gCredential);

    //Finally call notify listeners so that UI knows about the change
    notifyListeners();
  }
}
