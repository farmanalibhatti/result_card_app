import 'package:flutter/material.dart';

Future<void> showErrorDialog(
    BuildContext context, String title, String message) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Row(
          children: <Widget>[
            Icon(
              Icons.error,
              color: Colors.red,
            ),
            Text('  ${title}'),
          ],
        ),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('${message}'),
            ],
          ),
        ),
        actions: <Widget>[
          MaterialButton(
            child: Text('Ok'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
