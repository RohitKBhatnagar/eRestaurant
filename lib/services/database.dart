import 'package:cloud_firestore/cloud_firestore.dart';

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
}
