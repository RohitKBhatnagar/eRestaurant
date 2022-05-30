import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:erestaurant/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:erestaurant/services/database.dart';
import 'package:provider/provider.dart';

import 'employees_list.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  final AuthService _authSvc = AuthService();

  @override
  Widget build(BuildContext context) {
    return StreamProvider<QuerySnapshot?>.value(
      value: DatabaseService(uid: '').employees,
      initialData: null,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: const Text('Employee Registration'),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          actions: <Widget>[
            /*FlatButton*/ //FlatButton is deprecated and replaced by TextButton - https://docs.flutter.dev/release/breaking-changes/buttons
            TextButton.icon(
              icon: const Icon(
                Icons.person,
                color: Colors.black,
              ),
              label: const Text('logout',
                  style: TextStyle(
                      color: Colors.red, fontFamily: 'Verdana', fontSize: 16)),
              onPressed: () async {
                await _authSvc.logOut();
              },
            )
          ],
        ),
        body: EmployeesList(),
      ),
    );
    /*Container(
      child: Text('home'),
    );*/
  }
}
