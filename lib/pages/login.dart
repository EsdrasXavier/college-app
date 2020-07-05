import 'package:collegeapp/CustomBoxShadow.dart';
import 'package:collegeapp/Models/User.dart';
import 'package:collegeapp/services/authentication.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  Login({Key key, this.loginCallback, this.auth}) : super(key: key);
  final VoidCallback loginCallback;
  final Auth auth;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(
          title: 'College System Login',
          loginCallback: this.loginCallback,
          auth: this.auth),
    );
  }
}

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title, this.loginCallback, this.auth})
      : super(key: key);

  final String title;
  final Auth auth;
  final VoidCallback loginCallback;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
      User user;

      print("Email: " + _email);
      print("Senha: " + _password);

      try {
        if (_isLoginForm) {
          user = await widget.auth.signIn(_email, _password);
          print('Signed in: $user');
          widget.loginCallback();
        }

        setState(() {
          _isLoading = false;
        });
      } catch (e) {
        print('Error: $e');
        setState(() {
          _isLoading = false;
          _errorMessage = e;
        });
      }
    } else {
      setState(() {
        _isLoading = false;
      });
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
    final emailField = new TextFormField(
      maxLines: 1,
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "Email",
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(25.7),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(25.7),
        ),
        filled: true,
        fillColor: Colors.white,
        errorStyle: TextStyle(color: Colors.white, fontSize: 15),
      ),
      validator: (value) => value.isEmpty ? 'E-mail deve ser preenchido' : null,
      onSaved: (value) => _email = value.trim(),
    );

    final passwordField = new TextFormField(
      maxLines: 1,
      obscureText: true,
      autofocus: false,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "Senha",
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(25.7),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(25.7),
        ),
        filled: true,
        fillColor: Colors.white,
        errorStyle: TextStyle(color: Colors.white, fontSize: 15),
      ),
      validator: (value) => value.isEmpty ? 'Senha deve ser preenchida' : null,
      onSaved: (value) => _password = value.trim(),
    );

    final loginButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color.fromRGBO(171, 28, 46, .90),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: validateAndSubmit,
        child: Text("Login",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
    // #ab1c2e

    Widget loadingIndicator = _isLoading
        ? new Container(
            color: Color.fromRGBO(171, 28, 46, .0),
            child: new Padding(
                padding: const EdgeInsets.all(5.0),
                child: new Center(child: new CircularProgressIndicator())),
          )
        : loginButon;

    return Scaffold(
      body: SingleChildScrollView(
          child: Container(
              height: MediaQuery.of(context).size.height,
              color: Color.fromRGBO(171, 28, 46, .90),
              child: new Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(36.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 30.0),
                      Container(
                          width: 190.0,
                          height: 190.0,
                          decoration: new BoxDecoration(
                              boxShadow: [
                                new CustomBoxShadow(
                                    color: Color.fromRGBO(0, 0, 0, .7),
                                    offset: new Offset(0, 0),
                                    blurRadius: 10.0,
                                    blurStyle: BlurStyle.normal),
                              ],
                              shape: BoxShape.circle,
                              image: new DecorationImage(
                                image: new ExactAssetImage('assets/logo.png'),
                                fit: BoxFit.cover,
                              ))),
                      SizedBox(height: 100.0),
                      emailField,
                      SizedBox(height: 25.0),
                      passwordField,
                      SizedBox(
                        height: 15.0,
                      ),
                      loadingIndicator,
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        _errorMessage,
                        style: TextStyle(fontSize: 20),
                      )
                      //,
                    ],
                  ),
                ),
              ))),
    );
  }
}
