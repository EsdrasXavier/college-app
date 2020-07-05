import 'package:collegeapp/Models/Billing.dart';
import 'package:collegeapp/Models/User.dart';
import 'package:collegeapp/services/BillingService.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Financial extends StatefulWidget {
  Financial({Key key, this.user}) : super(key: key);

  final User user;

  @override
  State<StatefulWidget> createState() => new _Financial();
}

class _Financial extends State<Financial> {
  bool _isLoading;
  List<Billing> _billings = new List<Billing>();

  void fetchUserData() {
    if (_isLoading == true) return;

    setState(() {
      _isLoading = true;
    });

    BillingService().getUserBillings(widget.user).then((value) {
      for (Billing b in value) {
        print(b.value);
      }
      setState(() {
        _isLoading = false;
        _billings = value;
      });
    });
  }

  @override
  void initState() {
    super.initState();

    if (_billings.isEmpty) {
      fetchUserData();
    }
  }

  @override
  Widget build(BuildContext context) {
    const color = Color.fromRGBO(171, 28, 46, .80);

    if (_billings.isEmpty) {
      fetchUserData();
    }

    if (_isLoading) {
      return new Stack();
    }

    // var registerDate =
    //     DateFormat('dd/MM/yyyy').format(DateTime.parse(_currentUser.createdAt));

    return new Scaffold(
        backgroundColor: color,
        body: new SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: this.getTable(),
        ));
  }

  Widget getTable() {
    return Table(
      border: TableBorder.all(
          color: Colors.black, style: BorderStyle.solid, width: 1.2),
      children: [
        TableRow(
          children: [
            Center(child: this.generateCell('Valor', 18)),
            Center(child: this.generateCell('Bolsa', 18)),
            Center(child: this.generateCell('Baixa', 18)),
            Center(child: this.generateCell('Data', 18))
          ],
        ),
        ...List<TableRow>.generate(35, (index) {
          final item = _billings[0];
          double fontSize = 15;
          return TableRow(
            children: [
              this.generateCell(item.value, fontSize, true),
              this.generateCell(item.scholarshipValue, fontSize, true),
              this.generateCell(item.actualCost, fontSize, true),
              this.generateCell(
                  DateFormat('dd/MM/yyyy')
                      .format(DateTime.parse(item.expirationDate)),
                  fontSize)
            ],
          );
        })
      ],
    );
  }

  Widget generateCell(text, double fontSize, [bool isNumber]) {
    var titleStyle = TextStyle(fontFamily: 'Montserrat', fontSize: fontSize);
    isNumber ??= false;

    var f = new NumberFormat.currency(
      locale: 'pt_BR',
      symbol: 'R\$',
    );

    if (isNumber) {
      text = f.format(text);
    }

    return Padding(
      padding: EdgeInsets.all(1.8),
      child: Text(
        text,
        style: titleStyle,
      ),
    );
  }
}
