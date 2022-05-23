import 'package:erestaurant/models/euser.dart';
import 'package:erestaurant/screens/wrapper.dart';
import 'package:erestaurant/services/auth.dart';
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
      child: const MaterialApp(
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
//https://pub.dev/packages/google_sign_in/example
//https://pub.dev/packages/font_awesome_flutter/example



//Tutorials - Watch till video list#15 for all authentication videos
//https://www.youtube.com/watch?v=mtNA1neFNVo&list=PL4cUxeGkcC9j--TKIdkb3ISfRbJeJYQwC&index=16 [This video onwards is user creation]
//https://www.youtube.com/watch?v=1k-gITZA9CI - Google SignIn


//For setting up Google services I received platform errors
//Solved it by 2 steps
//Enabled OAuth via credentials tab here - https://console.cloud.google.com/apis/credentials?project=erestaurant-70210
//Deleted my existing Android simulator and created a new one after installing 'Google Play Services' as instructed here - https://developer.android.com/studio/intro/update

//This URL is for FYI - https://console.cloud.google.com/iam-admin/iam?authuser=0&project=erestaurant-70210&pli=1


//Some extremely good reference
//Using Firebase Authentication - https://firebase.flutter.dev/docs/auth/usage/
//Video Tutorial iOS Google Sign In - https://www.youtube.com/watch?v=xuvBFjNOl5M
//Flutter POD Run issues - https://phongyewtong.medium.com/how-to-fix-flutter-stuck-at-running-pod-install-when-run-578ad867774#:~:text=found%20for%20method-,Solution,directory%20and%20run%20Pod%20install%20.