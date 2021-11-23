/// Flutter code sample for AlertDialog

// This demo shows a [TextButton] which when pressed, calls [showDialog]. When called, this method
// displays a Material dialog above the current contents of the app and returns
// a [Future] that completes when the dialog is dismissed.

import 'package:flutter/material.dart';

/// This is the stateless widget that the main application instantiates.
class Alert extends StatelessWidget {
  late String message;
  Alert(this.message, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Login Error'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        ),
      ),
      child: const Text('Show Dialog'),
    );
  }
}
