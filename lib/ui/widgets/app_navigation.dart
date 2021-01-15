import 'package:flutter/material.dart';
import 'package:rc_app/ui/schools.dart';
import 'package:rc_app/ui/profile.dart';
import 'package:rc_app/ui/authentication.dart';

class AppNavigation extends StatefulWidget {
  AppNavigation({Key key, this.selected}) : super(key: key);
  int selected;
  @override
  _AppNavigationState createState() => _AppNavigationState();
}

class _AppNavigationState extends State<AppNavigation> {
  _AppNavigationState({Key key});
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  // static const List<Widget> _widgetOptions = <Widget>[
  //   Text(
  //     'Index 0: Home',
  //     style: optionStyle,
  //   ),
  //   Text(
  //     'Index 1: Schools',
  //     style: optionStyle,
  //   ),
  //   Text(
  //     'Index 2: Results',
  //     style: optionStyle,
  //   ),
  //   Text(
  //     'Index 3: User',
  //     style: optionStyle,
  //   ),
  // ];

  initState() {
    setState(() {
      if (widget.selected != null) {
        print(widget.selected);
        _selectedIndex = widget.selected;
      } else {
        _selectedIndex = 0;
      }
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      switch (index) {
        case 0:
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => Schools()));
          break;
        case 1:
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => Schools()));
          break;
        case 3:
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => Profile()));
          break;
        default:
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => Schools()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            title: Text('Schools'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assessment),
            title: Text('Results'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            title: Text('User'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blueAccent[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
