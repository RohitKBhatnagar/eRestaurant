import 'package:erestaurant/services/auth.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  final AuthService _authSvc = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[50],
      appBar: AppBar(
        title: Text('Employee Registration'),
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        actions: <Widget>[
          /*FlatButton*/ //FlatButton is deprecated and replaced by TextButton - https://docs.flutter.dev/release/breaking-changes/buttons
          TextButton.icon(
            icon: Icon(
              Icons.person,
              color: Colors.black,
            ),
            label: Text('logout',
                style: TextStyle(
                    color: Colors.red, fontFamily: 'Verdana', fontSize: 16)),
            onPressed: () async {
              await _authSvc.logOut();
            },
          )
        ],
      ),
    );
    /*Container(
      child: Text('home'),
    );*/
  }
}
