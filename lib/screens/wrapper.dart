import 'package:erestaurant/models/euser.dart';
import 'package:erestaurant/screens/authenticate/authenticate.dart';
import 'package:erestaurant/screens/home/home.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // var myUsr;
    // if (myUsr != null) print('User so far - ' + myUsr);

    //(context) {
    final myUsr = Provider.of<eUser?>(context);
    if (kDebugMode) {
      print('Wrapper.dart:: build(): Current status of the user - ');
      print(myUsr);
    }

    //Return either Home or Authenticate widget here
    if (myUsr == null) {
      print('Wrapper.dart:: build(): User needs to be authenticated');
      return Authenticate();
    } else {
      if (kDebugMode) {
        print('Wrapper.dart:: build(): User is already authenticated');
      }
      return Home();
    }
    //};
  }
}


/*
Exception has occurred.
ProviderNotFoundException (Error: Could not find the correct Provider<eUser> above this Wrapper Widget

This happens because you used a `BuildContext` that does not include the provider
of your choice. There are a few common scenarios:

- You added a new provider in your `main.dart` and performed a hot-reload.
  To fix, perform a hot-restart.

- The provider you are trying to read is in a different route.

  Providers are "scoped". So if you insert of provider inside a route, then
  other routes will not be able to access that provider.

- You used a `BuildContext` that is an ancestor of the provider you are trying to read.

  Make sure that Wrapper is under your MultiProvider/Provider<eUser>.
  This usually happens when you are creating a provider and trying to read it immediately.

  For example, instead of:

  ```
  Widget build(BuildContext context) {
    return Provider<Example>(
      create: (_) => Example(),
      // Will throw a ProviderNotFoundError, because `context` is associated
      // to the widget that is the parent of `Provider<Example>`
      child: Text(context.watch<Example>()),
    ),
  }
  ```

  consider using `builder` like so:

  ```
  Widget build(BuildContext context) {
    return Provider<Example>(
      create: (_) => Example(),
      // we use `builder` to obtain a new `BuildContext` that has access to the provider
      builder: (context) {
        // No longer throws
        return Text(context.watch<Example>()),
      }
    ),
  }
  ```

If none of these solutions work, consider asking for help on StackOverflow:
https://stackoverflow.com/questions/tagged/flutter
)
*/