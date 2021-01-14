import 'package:rc_app/net/flutterfire.dart';
import 'package:flutter/material.dart';

class SchoolRemoveView extends StatefulWidget {
  SchoolRemoveView({Key key, this.schoolID}) : super(key: key);
  String schoolID;

  @override
  _SchoolRemoveViewState createState() => _SchoolRemoveViewState();
}

class _SchoolRemoveViewState extends State<SchoolRemoveView> {
  TextEditingController _schoolNameController = TextEditingController();
  @override
  void initState() {
    super.initState();
    this._schoolNameController.text = widget.schoolID;
  }

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
            child: Text(
              "Are you sure you want to delete this school?",
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
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
                await removeSchool(_schoolNameController.text);
                Navigator.of(context).pop();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Delete",
                    style: TextStyle(
                      color: Colors.green,
                    ),
                  ),
                  Icon(
                    Icons.delete_forever,
                    color: Colors.red,
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
