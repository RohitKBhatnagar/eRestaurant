import 'package:erestaurant/models/euser.dart';
import 'package:erestaurant/screens/wrapper.dart';
import 'package:erestaurant/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//https://medium.com/@lumeilin301/flutter-firebase-app-tutorial-part-1-get-started-95cce84939c3
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<eUser?>.value(
      value: AuthService().fbUsr,
      initialData:
          null, //??? I thought we are going to be listening on our custom user data instance
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}

//minSdkVersion issue
//I modified the android\build.gradle to use a new file created with local-properties
//Used as per the documentation here - https://stackoverflow.com/questions/52060516/how-to-change-android-minsdkversion-in-flutter-project

//Packages included with this app
//https://pub.dev/packages/firebase_auth/example
//https://pub.dev/packages/cloud_firestore/example
//https://pub.dev/packages/firebase_core/install
//https://pub.dev/packages/provider/install
//https://pub.dev/packages/flutter_spinkit/install


//Tutorials - Watch till video list#15 for all authentication videos
//https://www.youtube.com/watch?v=mtNA1neFNVo&list=PL4cUxeGkcC9j--TKIdkb3ISfRbJeJYQwC&index=16 [This video onwards is user creation]