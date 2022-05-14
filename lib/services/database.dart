import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});
  //Collection Reference Services
  //final CollectionReference restaurantCollection = FirebaseFirestore.instance.collection('restaurants');
  final CollectionReference employeeCollection =
      FirebaseFirestore.instance.collection('employees');

  //HELP - https://firebase.flutter.dev/docs/firestore/usage/#adding-documents
  Future updateEmpData(
      String firstName, String lastName, String eMail, String phoneNo) async {
    return employeeCollection
        .doc(uid)
        .set({
          'first_name': firstName,
          'last_name': lastName,
          'eMail': eMail,
          'Tel': phoneNo
        })
        .then((value) => print("employee added!"))
        .catchError((error) => print("failed to add new employee - $error"));
  }
}
