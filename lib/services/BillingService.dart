import 'dart:async';
import 'dart:convert';

import 'package:collegeapp/Models/Billing.dart';
import 'package:collegeapp/Models/User.dart';
import 'package:collegeapp/services/ErrorMsgService.dart';
import 'package:http/http.dart' as http;

Map<String, String> get headers =>
    {"Accept": "application/json", "Content-Type": "application/json"};

class BillingService {
  Future<List<Billing>> getUserBillings(User user) async {
    print("Buscando usuário com ID: " + user.userId.toString());
    var url = 'http://192.168.1.19:3000/persons/${user.userId}/billing';

    http.Response response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      List<Billing> result = new List<Billing>();

      for (Map i in json.decode(response.body)) {
        result.add(Billing.fromJson(i));
      }

      return result;
    }

    throw (ErrorMsgService.handleMsg(json.decode(response.body)));
  }
}
