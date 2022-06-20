//import 'package:cloud_firestore/cloud_firestore.dart'; //QuerySnapshot call has been transferred to services/database.dart
import 'package:erestaurant/models/employee.dart';
import 'package:erestaurant/screens/home/settings_home.dart';
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
    //To invoke botton sheet when settings icon is pressed
    void _showSettingsPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              //Adding some padding
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
              child: //const Text('bottom sheet'),
                  const SettingsForm(), //Form to update something...
            );
          });
    }

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
              onPressed: () => _showSettingsPanel(),
              icon: const Icon(Icons.settings, color: Colors.black),
              label: const Text('Settings',
                  style: TextStyle(
                      color: Colors.red, fontFamily: 'Verdana', fontSize: 16)),
            ),
            TextButton.icon(
              icon: const Icon(
                Icons.person,
                color: Colors.yellow,
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
