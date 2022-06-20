import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:erestaurant/shared/constants.dart';

class SettingsForm extends StatefulWidget {
  const SettingsForm({Key? key}) : super(key: key);

  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> experience = [
    '<1',
    '1-3',
    '3-5',
    '5-7',
    '7-10',
    '10-15',
    '15-20',
    '>20'
  ]; //Experience in years

  //form values
  String? _displayName;
  bool? _seekingJob;
  String? _currentExp;
  String? _currentEmployer;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          const Text(
            'Update employment information..',
            style: TextStyle(fontSize: 18.0),
          ),
          const SizedBox(
            height: 20.0,
          ),
          TextFormField(
            decoration: textDecoration, //We defined this in out constants.dart
            validator: (val) =>
                val!.isEmpty ? 'Please enter a display name' : null,
            onChanged: (val) => setState(() => _displayName = val),
          ),
          const SizedBox(
            height: 20.0,
          ),
          //Drop Down element for years of experience
          DropdownButtonFormField(
            items: experience.map((exp) {
              return DropdownMenuItem(
                value: exp,
                child: Text('$exp years'),
              );
            }).toList(),
            onChanged: (value) =>
                setState(() => _currentExp = value as String?),
          ),
          // Slider option
          //Button
          ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.amber),
                //padding: MaterialStateProperty.all(const EdgeInsets.all(0.5)),
                textStyle:
                    MaterialStateProperty.all(const TextStyle(fontSize: 18.0))),
            child: const Text('Update',
                style: TextStyle(
                    color: Colors.black, fontFamily: 'Verdana', fontSize: 16)),
            onPressed: () async {
              /*dynamic result = await _authSvc.signInAnon();
                if (result == null) {
                  print('Error signing in anonymously');
                } else {
                  print('Signed in anonymously');
                  print('Anonymously signed User ID - ' + result.sUid); //We are returning eUser object now hence directly invoking the method defined inside eUser class
                }*/
              if (kDebugMode) {
                print(_displayName);
                print(_currentExp);
                print(_seekingJob);
                print(_currentEmployer);
              }
            },
          ),
        ],
      ),
    );
  }
}
