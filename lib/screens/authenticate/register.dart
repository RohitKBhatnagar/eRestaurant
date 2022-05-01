import 'package:erestaurant/shared/constants.dart';
import 'package:erestaurant/shared/loading.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../services/auth.dart';

class Register extends StatefulWidget {
  const Register({Key? key, required this.toggleAuth}) : super(key: key);

  final Function toggleAuth;

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _authSvc = AuthService();
  final _formKey =
      GlobalKey<FormState>(); //Global validation key for the form submitted
  bool loading = false;

  // Text Field State
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Loading()
        : Scaffold(
            backgroundColor: Colors.brown[100],
            appBar: AppBar(
              backgroundColor: Colors.brown[400],
              elevation: 0.0,
              title: const Text('Register to eRestaurant'),
              actions: <Widget>[
                /*FlatButton*/ //FlatButton is deprecated and replaced by TextButton - https://docs.flutter.dev/release/breaking-changes/buttons
                TextButton.icon(
                  icon: const Icon(
                    Icons.person,
                    color: Colors.black,
                  ),
                  label: const Text('Sign In',
                      style: const TextStyle(
                          color: Colors.black,
                          fontFamily: 'Verdana',
                          fontSize: 16)),
                  onPressed: () {
                    widget.toggleAuth();
                  },
                )
              ],
            ),
            body: Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      //User Name
                      const SizedBox(height: 20.0),
                      TextFormField(
                          decoration:
                              textDecoration.copyWith(hintText: 'eMail'),
                          //We use constants.dart file for sharing common implementations including text decorations like these
                          /*decoration: const InputDecoration(
                      hintText: 'eMail',
                      fillColor: Colors.white,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.brown, width: 2.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.pink, width: 2.0),
                      ),
                    ) ,*/
                          validator: (val) =>
                              val!.isEmpty ? 'Enter an email' : null,
                          onChanged: (val) {
                            setState(() => email = val);
                          }),
                      //Password
                      const SizedBox(height: 20.0),
                      TextFormField(
                        decoration:
                            textDecoration.copyWith(hintText: 'password'),
                        validator: (val) => val!.length < 6
                            ? 'Enter secret 6+ chars long'
                            : null,
                        obscureText:
                            true, //This would be the password field hence hide the text
                        onChanged: (val) {
                          setState(() => password = val);
                        },
                      ),
                      //Sign In Button
                      const SizedBox(height: 20.0),
                      ElevatedButton(
                        child: const Text('Register'),
                        style: ElevatedButton.styleFrom(
                            primary: Colors.deepOrange[400],
                            textStyle: const TextStyle(color: Colors.black)),
                        onPressed: () async {
                          //print(email);
                          //print(password);
                          if (_formKey.currentState!.validate()) {
                            if (kDebugMode) {
                              print(email);
                              print(password);
                            }
                            setState(() => loading = true);
                            dynamic result = await _authSvc
                                .registerWithEmailAndPassword(email, password);
                            if (result == null) {
                              setState(() {
                                error = 'please provide valid email';
                                loading = false;
                              });
                            }
                          }
                        },
                      ),
                      const SizedBox(
                        height: 12.0,
                      ),
                      Text(
                        error,
                        style:
                            const TextStyle(color: Colors.red, fontSize: 14.0),
                      )
                    ],
                  )),
              //https://api.flutter.dev/flutter/material/RaisedButton-class.html
              /*child: RaisedButton //- RaiseButton is deprecated */
              /* Code below allowed us to authenticate Anonymously we wish to use email and password as authentication logic 
            child: ElevatedButton(
              child: Text('Signin anonymously'),
              onPressed: () async {
                dynamic result = await _authSvc.signInAnon();
                if (result == null) {
                  print('Error signing in anonymously');
                } else {
                  print('Signed in anonymously');
                  print('Anonymously signed User ID - ' +
                      result
                          .sUid); //We are returning eUser object now hence directly invoking th emethod defined inside eUser class
                }
              },
            ) //Code above allowed us to authenticate Anonymously we wish to use email and password as authentication logic  */
            ),
          );
  }
}
