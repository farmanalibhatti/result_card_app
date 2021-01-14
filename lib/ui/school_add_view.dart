import 'package:rc_app/net/flutterfire.dart';
import 'package:flutter/material.dart';

class SchoolAddView extends StatefulWidget {
  SchoolAddView({Key key}) : super(key: key);

  @override
  _SchoolAddViewState createState() => _SchoolAddViewState();
}

class _SchoolAddViewState extends State<SchoolAddView> {
  TextEditingController _schoolNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.close,
              color: Colors.red,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            width: MediaQuery.of(context).size.width / 1.3,
            child: TextFormField(
              controller: _schoolNameController,
              decoration: InputDecoration(
                labelText: "School name",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            width: MediaQuery.of(context).size.width / 1.4,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              color: Colors.white,
            ),
            child: MaterialButton(
              onPressed: () async {
                await addSchool(_schoolNameController.text);
                Navigator.of(context).pop();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Add",
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                  Icon(
                    Icons.add,
                    color: Colors.green,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
