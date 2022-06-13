import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

import '../../models/employee.dart';

//Using tutorial (FireStore Streams) - https://www.youtube.com/watch?v=10PcEkQsF9Y&list=PL4cUxeGkcC9j--TKIdkb3ISfRbJeJYQwC&index=18
class EmployeesList extends StatefulWidget {
  const EmployeesList({Key? key}) : super(key: key);

  @override
  State<EmployeesList> createState() => _EmployeesListState();
}

class _EmployeesListState extends State<EmployeesList> {
  @override
  /* Widget build(BuildContext context) {
    final employees = Provider.of<QuerySnapshot?>(context);
    if (kDebugMode) {
      print(employees!.docs);
      for (var doc in employees.docs) {
        print(doc.data());
      }
    }
    return Container();
  } */

  Widget build(BuildContext context) {
    final employees = Provider.of<List<Employee?>>(context);
    employees.forEach((emp) {
      if (kDebugMode) {
        print(emp?.display_name);
        print(emp?.eMail);
        print(emp?.Tel);
      }
    });
    return Container();
  }
}
