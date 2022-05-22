import 'package:erestaurant/models/euser.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //final googleUser = GoogleSignIn().signIn();
  //late final googleUser;

  //Convert FirebaseUser into our custome eUser
  eUser? _userFromFirebaseUser(User? fbaseUsr) {
    //// ignore: unnecessary_null_comparison
    //return fbaseUsr != null ? eUser(sUid: fbaseUsr.uid) : null;
    //https://medium.com/@lumeilin301/flutter-firebase-app-tutorial-part-4-custom-model-in-flutter-app-1ec618ed4686
    if (fbaseUsr != null) {
      return eUser(sUid: fbaseUsr.uid);
    } else {
      return null;
    }
  }

  //Authentication changes based upon user stream - We wish to detect when user
  //signs in and signs out.
  //We will use Streams for detecting the same, so that when user is signed in
  //we will get Flutter User instance returned to us otherwise stream from Firebase will return null
  Stream<eUser?> get fbUsr {
    return _auth
        .authStateChanges()
        //.map((User? fireUsr) => _userFromFirebaseUser(fireUsr));
        .map(
            _userFromFirebaseUser); //Simplified from above map implementation :-)
  }

  //Sign in anonymously
  Future signInAnon() async {
    try {
      /*AuthResult*/ UserCredential result = await _auth.signInAnonymously();
      if (kDebugMode) {
        print(result);
      }
      /*FirebaseUser*/ User? fbUser = result.user;
      //return fbUser; //Since we are now returning User details into our custome user object eUser
      return _userFromFirebaseUser(fbUser!); //with null check
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return null;
    }
  }

  //Method to sign in and authenticate the Google user
  Future googleLogin() async {
    //Display Google SignIn options if multiple users
    final googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) return;

    //Authenticate Google user selected
    final googleAuth = await googleUser.authentication;

    //gCredential will collect the authenticated Google users access token and id for user later for firebase
    final gCredential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    //Pass the gCredential details to now actually perform the authentication
    UserCredential usrCred =
        await FirebaseAuth.instance.signInWithCredential(gCredential);
    User? fbUser = usrCred.user;
    return _userFromFirebaseUser(fbUser!); //with null check
  }

  //Sign in with email & password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      if (kDebugMode) {
        print("Authenticating - $email : $password");
      }
      /*AuthResult*/ UserCredential result = await _auth
          .signInWithEmailAndPassword(email: email, password: password);
      if (kDebugMode) {
        print(result);
      }
      User? fbUser = result.user;
      return _userFromFirebaseUser(fbUser!); //with null check
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return null;
    }
  }

  //Register with email & password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      if (kDebugMode) {
        print("Registering - $email : $password");
      }
      /*AuthResult*/ UserCredential result = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      if (kDebugMode) {
        print(result);
      }
      User? fbUser = result.user;
      return _userFromFirebaseUser(fbUser!); //with null check
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return null;
    }
  }

  //Sign out

  Future logOut() async {
    try {
      await GoogleSignIn().signOut();
      return await _auth.signOut();
    } catch (exp) {
      if (kDebugMode) {
        print(exp.toString());
      }
      return null;
    }
  }
}
