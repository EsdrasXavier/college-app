import 'dart:async';
import 'dart:convert';

import 'package:collegeapp/Models/User.dart';
import 'package:http/http.dart' as http;

Map<String, String> get headers =>
    {"Accept": "application/json", "Content-Type": "application/json"};

abstract class BaseAuth {
  User currentUser;

  User get user;

  set user(User user);

  Future<User> signIn(String email, String password);

  Future<void> signOut();
  Future<User> getCurrentUser();

  String handleMsg(Map<String, dynamic> json);
}

class Auth implements BaseAuth {
  set user(User user) {
    currentUser = user;
  }

  String handleMsg(Map<String, dynamic> json) {
    print(json);
    return json['msg'];
  }

  Future<User> signIn(String email, String password) async {
    print("Logando com e-mail: " + email + " e senha: " + password);
    var url = 'http://192.168.1.19:3000/login';
    http.Response response = await http.post(url,
        headers: headers,
        body: json.encode({'login': email, 'password': password}));

    if (response.statusCode == 200) {
      currentUser = User.fromJson(json.decode(response.body));
      return currentUser;
    }

    throw (handleMsg(json.decode(response.body)));
  }

  Future<void> signOut() async {
    print("Deslogando...");
    return null;
  }

  Future<User> getCurrentUser() async {
    return currentUser;
  }

  @override
  User currentUser;

  @override
  User get user => currentUser;
}
