import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rc_app/net/flutterfire.dart';
import 'package:rc_app/ui/authentication.dart';
import 'package:flutter/material.dart';
import 'package:rc_app/ui/widgets/app_navigation.dart';
import 'package:rc_app/ui/school_add_view.dart';
import 'package:rc_app/ui/school_remove_view.dart';

class Schools extends StatefulWidget {
  Schools({Key key}) : super(key: key);

  @override
  _SchoolsState createState() => _SchoolsState();
}

class _SchoolsState extends State<Schools> {
  TextEditingController _searchController = TextEditingController();
  String searchText = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              color: Color(0xffF1F2F2),
            ),
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(5.0),
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 1.8,
                        child: TextFormField(
                          onChanged: (value) {
                            setState(() {
                              searchText = _searchController.text;
                            });
                          },
                          controller: _searchController,
                          decoration: InputDecoration(
                            hintText: "Search ...",
                            hintStyle: TextStyle(
                              color: Colors.grey,
                            ),
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(
                              Icons.search,
                              color: Colors.blueAccent,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 50,
                        child: RaisedButton(
                          elevation: 4,
                          color: Colors.white,
                          child: Text('Search'),
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => Authentication(),
                              ),
                            );
                          },
                        ),
                      ),
                      Container(
                        child: IconButton(
                          color: Colors.white,
                          icon: Icon(
                            Icons.add,
                            color: Colors.green,
                          ),
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => SchoolAddView(),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 1.5),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 1.35,
                  color: Color(0xffcccccc),
                  child: (searchText == '')
                      ? StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection("Users")
                              .doc(FirebaseAuth.instance.currentUser.uid)
                              .collection("Schools")
                              .snapshots(),
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (!snapshot.hasData) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            return ListView(
                              shrinkWrap: true,
                              children: snapshot.data.docs.map((document) {
                                return Container(
                                  // color: Colors.red,
                                  // height: MediaQuery.of(context).size.height,
                                  child: Container(
                                    child: Card(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          ListTile(
                                            leading: Icon(
                                              Icons.school,
                                              color: Colors.blueAccent,
                                            ),
                                            title: Text(
                                                'School Name: ${document['schoolName']}'),
                                            trailing: IconButton(
                                              icon: Icon(
                                                Icons.delete_forever,
                                                color: Colors.red,
                                              ),
                                              onPressed: () {
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        SchoolRemoveView(
                                                      schoolID: document.id,
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            );
                          },
                        )
                      : StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection("Users")
                              .doc(FirebaseAuth.instance.currentUser.uid)
                              .collection("Schools")
                              .where('keywords',
                                  arrayContains: searchText.toLowerCase())
                              .snapshots(),
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (!snapshot.hasData) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            return ListView(
                              shrinkWrap: true,
                              children: snapshot.data.docs.map((document) {
                                return Container(
                                  // color: Colors.red,
                                  // height: MediaQuery.of(context).size.height,
                                  child: Container(
                                    child: Card(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          ListTile(
                                            leading: Icon(
                                              Icons.school,
                                              color: Colors.blueAccent,
                                            ),
                                            title: Text(
                                                'School Name: ${document['schoolName']}'),
                                            trailing: IconButton(
                                              icon: Icon(
                                                Icons.delete_forever,
                                                color: Colors.red,
                                              ),
                                              onPressed: () {
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        SchoolRemoveView(
                                                      schoolID: document.id,
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: AppNavigation(
        selected: 1,
      ),
    );
  }
}
