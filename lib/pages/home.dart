import 'package:collegeapp/Models/User.dart';
import 'package:collegeapp/pages/Financial.dart';
import 'package:collegeapp/pages/Profile.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  Home({Key key, this.user, this.logoutCallback}) : super(key: key);

  final User user;
  final VoidCallback logoutCallback;

  @override
  State<StatefulWidget> createState() => new _Navigator();
}

class _Navigator extends State<Home> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  // static const

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _widgetOptions = <Widget>[
      Financial(
        user: widget.user,
      ),
      Text(
        'Index 2: School',
        style: optionStyle,
      ),
      Profile(
        user: widget.user,
        logoutCallback: widget.logoutCallback,
      )
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(171, 28, 46, .90),
        title: const Text('Católica SC'),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet),
            title: Text('Financeiro'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            title: Text('Notas'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            title: Text('Perfil'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color.fromRGBO(171, 28, 46, .90),
        onTap: _onItemTapped,
      ),
    );
  }
}
