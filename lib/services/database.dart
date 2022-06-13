import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:erestaurant/models/employee.dart';
import 'package:flutter/foundation.dart';

class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});
  //Collection Reference Services
  //final CollectionReference restaurantCollection = FirebaseFirestore.instance.collection('restaurants');
  final CollectionReference employeeCollection =
      FirebaseFirestore.instance.collection('employees');

  /// HELP - https://firebase.flutter.dev/docs/firestore/usage/#adding-documents
  /// Using this method to create UID based document in employees collection
  /// Purpose is to extarct or ask user extermely basic information during registration
  Future registerEmpData(
      String? displayName, String? eMail, String? phoneNo) async {
    return employeeCollection
        .doc(uid)
        .set({'display_name': displayName, 'eMail': eMail, 'Tel': phoneNo})
        .then((value) => print("employee registered!"))
        .catchError(
            (error) => print("failed to register new employee - $error"));
  }

  /// Using this method to update UID based document in employees collection
  Future updateEmpData(
      String? displayName, String? eMail, String? phoneNumber) async {
    return employeeCollection
        .doc(uid)
        .update(
            {'display_name': displayName, 'eMail': eMail, 'Tel': phoneNumber})
        .then((value) => print("employee updated!"))
        .catchError(
            (error) => print("failed to update employee details - $error"));
  }

  // employee list from snapshot - https://firebase.flutter.dev/docs/firestore/usage/#querysnapshot
  List<Employee?> _empListFromSnapshot(QuerySnapshot snapshot) {
    /* return snapshot.docs
        .map((doc) => Employee.fromJson(doc.data().toString()))
        .toList(); */
    //https://groups.google.com/g/flutter-dev/c/lquU5iaQjiw

    return snapshot.docs.map((doc) {
      if (kDebugMode) {
        print(doc);
      }
      try {
        return Employee.fromJson(doc.data() /*.toString()*/);
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
        return null;
      }
    }).toList();
  }

  // Gets employee stream
  /* Stream<QuerySnapshot> get employees {
    return employeeCollection.snapshots();
  } */

  // Gets employee stream
  /* Stream<List<Employee>> get employees {
    return employeeCollection.snapshots().map((list) =>
        list.docs.map((e) => Employee.fromJson(e.toString())).toList());
        //https://www.androidbugfix.com/2021/12/flutter-firestore-documentsnapshot-to.html
  } */

  Stream<List<Employee?>> get employees {
    return employeeCollection.snapshots().map(_empListFromSnapshot);
  }
}
