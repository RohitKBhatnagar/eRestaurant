import 'dart:convert';

import 'package:flutter/foundation.dart';

//import 'package:flutter/rendering.dart';

class Employee {
  // final String name;
  // final String eMail;
  // final String phoneNo;
  String display_name = '';
  String eMail = '';
  String Tel = '';

  Employee(this.Tel, this.display_name, this.eMail);
  //Employee({required name}, {required eMail}, {required phoneNo});

  Map<String, dynamic> toMap() {
    return {'Tel': Tel, 'display_name': display_name, 'eMail': eMail};
  }

  factory Employee.fromMap(Map<String, dynamic> map) {
    return Employee(
      map['Tel']! ?? '',
      map['display_name'] ?? '',
      map['eMail'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  //factory Employee.fromJson(String source) => Employee.fromMap(json.decode(source));
  factory Employee.fromJson(dynamic source) {
    if (kDebugMode) {
      print(source);
      /*try {
        print(json.decode(source));
      } catch (e) {
        print("Printing the json decoded values...");
        print(e);
      }*/
    }
    return Employee(source['Tel'] ?? '0' as String,
        source['display_name'] as String, source['eMail'] as String);
  }
}
