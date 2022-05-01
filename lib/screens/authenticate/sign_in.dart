import 'package:erestaurant/services/auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../shared/constants.dart';
import '../../shared/loading.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key, required this.toggleAuth}) : super(key: key);

  final Function toggleAuth;

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
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
              title: const Text('Sign in to eRestaurant'),
              actions: <Widget>[
                /*FlatButton*/ //FlatButton is deprecated and replaced by TextButton - https://docs.flutter.dev/release/breaking-changes/buttons
                TextButton.icon(
                  icon: const Icon(
                    Icons.person,
                    color: Colors.black,
                  ),
                  label: const Text('Register',
                      style: TextStyle(
                          color: Colors.orange,
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
                        child: const Text('Sign In'),
                        style: ElevatedButton.styleFrom(
                            primary: Colors.pink[400],
                            textStyle: const TextStyle(color: Colors.black)),
                        onPressed: () async {
                          //print(email);
                          //print(password);
                          if (_formKey.currentState!.validate()) {
                            setState(() => loading = true);
                            if (kDebugMode) {
                              print(email);
                              print(password);
                            }

                            dynamic result = await _authSvc
                                .signInWithEmailAndPassword(email, password);
                            if (result == null) {
                              setState(() {
                                error =
                                    'unable to sign in with provided credentials';
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
