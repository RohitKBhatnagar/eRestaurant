import 'package:flutter/material.dart';

import 'package:erestaurant/models/employee.dart';

class EmployeeTile extends StatelessWidget {
  const EmployeeTile({
    Key? key,
    required this.employee,
  }) : super(key: key);

  final Employee? employee;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 8.0),
        child: Card(
          margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
          child: ListTile(
            leading: CircleAvatar(
              radius: 25.0,
              backgroundColor: Colors.brown[100],
            ),
            title: Text(employee!.display_name),
            //subtitle: Text('May be reached at ${employee!.eMail}'),
            subtitle: Text(employee!.eMail),
          ),
        ));
  }
}
