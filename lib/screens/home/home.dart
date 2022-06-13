//import 'package:cloud_firestore/cloud_firestore.dart'; //QuerySnapshot call has been transferred to services/database.dart
import 'package:erestaurant/models/employee.dart';
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
    return StreamProvider<List<Employee?>>.value(
      //return StreamProvider<QuerySnapshot?>.value(
      value: DatabaseService(uid: '').employees,
      //initialData: null,
      initialData: const <Employee>[],
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
        body: const EmployeesList(),
      ),
    );
    /*Container(
      child: Text('home'),
    );*/
  }
}
