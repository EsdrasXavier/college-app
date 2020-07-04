import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  Home({Key key, this.logoutCallback, this.userId}) : super(key: key);
  final VoidCallback logoutCallback;
  final int userId;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: HomePage(
          title: 'College System Login',
          logoutCallback: this.logoutCallback,
          userId: this.userId),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key, this.userId, this.title, this.logoutCallback})
      : super(key: key);
  final String title;
  final int userId;

  final VoidCallback logoutCallback;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  final _formKey = new GlobalKey<FormState>();

  String _email;
  String _password;
  String _errorMessage;

  bool _isLoginForm;
  bool _isLoading;

  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  // Perform login or signup
  void validateAndSubmit() async {
    setState(() {
      _errorMessage = "";
      _isLoading = true;
    });
    if (validateAndSave()) {
      String userId = "";
      print("logout");
      print("Email: " + _email);
      print("Senha: " + _password);
      widget.logoutCallback();
      // try {
      //   if (_isLoginForm) {
      //     userId = await widget.auth.signIn(_email, _password);
      //     print('Signed in: $userId');
      //   } else {
      //     userId = await widget.auth.signUp(_email, _password);
      //     //widget.auth.sendEmailVerification();
      //     //_showVerifyEmailSentDialog();
      //     print('Signed up user: $userId');
      //   }
      //   setState(() {
      //     _isLoading = false;
      //   });

      //   if (userId.length > 0 && userId != null && _isLoginForm) {
      //   }
      // } catch (e) {
      //   print('Error: $e');
      //   setState(() {
      //     _isLoading = false;
      //     _errorMessage = e.message;
      //     _formKey.currentState.reset();
      //   });
      // }
    }
  }

  @override
  void initState() {
    _errorMessage = "";
    _isLoading = false;
    _isLoginForm = true;
    super.initState();
  }

  void resetForm() {
    _formKey.currentState.reset();
    _errorMessage = "";
  }

  void toggleFormMode() {
    resetForm();
    setState(() {
      _isLoginForm = !_isLoginForm;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: Color.fromRGBO(171, 28, 46, .90),
              child: Column(children: <Widget>[
                SizedBox(height: 50.0),
                Text("Oi oni-chan")
              ]))),
    );
  }
}
