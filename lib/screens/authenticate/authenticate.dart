import 'package:erestaurant/screens/authenticate/register.dart';
import 'package:erestaurant/screens/authenticate/sign_in.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool bShowSignIn = true;

  //Method to toggle in between sign-in and register widgets
  void toggleView() {
    setState(() => bShowSignIn = !bShowSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if (bShowSignIn) {
      return SignIn(toggleAuth: toggleView);
    } else {
      return Register(toggleAuth: toggleView);
    }
    /* return Container(
      child: /*Text('authenticate'),*/ Register(),
    ); */
  }
}
