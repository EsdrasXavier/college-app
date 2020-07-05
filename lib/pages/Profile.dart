import 'package:collegeapp/Models/User.dart';
import 'package:collegeapp/services/User.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Profile extends StatefulWidget {
  Profile({Key key, this.user, this.logoutCallback}) : super(key: key);

  final User user;
  final VoidCallback logoutCallback;

  @override
  State<StatefulWidget> createState() => new _Profile();
}

class _Profile extends State<Profile> {
  bool _isLoading;
  User _currentUser;

  void fetchUserData() {
    setState(() {
      _isLoading = true;
    });

    UserService().getUserData(widget.user).then((value) {
      print('Ok');
      print(value.userName);
      setState(() {
        _isLoading = false;
        _currentUser = value;
      });
    });
  }

  @override
  void initState() {
    super.initState();

    if (_currentUser == null) {
      fetchUserData();
    }
  }

  @override
  Widget build(BuildContext context) {
    const color = Color.fromRGBO(171, 28, 46, .80);

    if (_currentUser == null) {
      fetchUserData();
    }

    if (_isLoading) {
      return new Stack();
    }

    var registerDate =
        DateFormat('dd/MM/yyyy').format(DateTime.parse(_currentUser.createdAt));

    return new Scaffold(
        body: new Stack(
      children: <Widget>[
        ClipPath(
          child: Container(color: Color.fromRGBO(171, 28, 46, .80)),
          // clipper: getClipper(),
        ),
        Positioned(
            width: MediaQuery.of(context).size.width,
            top: MediaQuery.of(context).size.height / 12,
            child: Column(
              children: <Widget>[
                Container(
                    width: 150.0,
                    height: 150.0,
                    decoration: BoxDecoration(
                        color: Colors.red,
                        image: DecorationImage(
                            image: new ExactAssetImage(
                                'assets/no-profile-img.jpg'),
                            fit: BoxFit.cover),
                        borderRadius: BorderRadius.all(Radius.circular(75.0)),
                        boxShadow: [
                          BoxShadow(blurRadius: 7.0, color: Colors.black)
                        ])),
                SizedBox(height: 90.0),
                Text(
                  _currentUser.userName,
                  style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat'),
                ),
                SizedBox(height: 15.0),
                Text(
                  'Data de cadastro: ${registerDate.toString()}',
                  style: TextStyle(
                      fontSize: 17.0,
                      fontStyle: FontStyle.italic,
                      fontFamily: 'Montserrat'),
                ),
                SizedBox(height: 105.0),
                Container(
                    height: 35.0,
                    width: 125.0,
                    child: Material(
                      borderRadius: BorderRadius.circular(20.0),
                      shadowColor: Colors.redAccent,
                      color: color,
                      elevation: 7.0,
                      child: GestureDetector(
                        onTap: () {
                          print('Deslogando');
                          widget.logoutCallback();
                        },
                        child: Center(
                          child: Text(
                            'Log out',
                            style: TextStyle(
                                color: Colors.white, fontFamily: 'Montserrat'),
                          ),
                        ),
                      ),
                    ))
              ],
            ))
      ],
    ));
  }
}
