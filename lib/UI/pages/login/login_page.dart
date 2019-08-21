import 'package:flutter/material.dart';
import 'package:my_movie_browser/utils/database_helper.dart';
import 'package:my_movie_browser/data/user.dart';

import 'package:my_movie_browser/UI/pages/login/login_presenter.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> implements LoginPageContract {
  BuildContext _ctx;
  bool _isLoading;
  final formKey = new GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();

  String _username, _password;

  LoginPagePresenter _presenter;

  _LoginPageState() {
    _presenter = new LoginPagePresenter(this);
  }

  void _submit() {
    final form = formKey.currentState;

    if (form.validate()) {
      setState(() {
        _isLoading = true;
        form.save();
        _presenter.doLogin(_username, _password);
      });
    }
  }

  void _showSnackBar(String text) {
    scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(text)));
  }

  @override
  Widget build(BuildContext context) {
    _ctx = context;
    var loginButton = RaisedButton(
      onPressed: _submit,
      child: new Text("Login"),
      color: Colors.redAccent,
    );
    var loginForm = new Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 100.0),
          child: new Text("My Movie Browser", textScaleFactor: 2.0, style: TextStyle(color: Colors.white),),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 100.0),
          child: new Form(
              key: formKey,
              child: new Column(
                children: <Widget>[
                  new Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: new TextFormField(
                        onSaved: (val) => _username = val,
                        decoration: new InputDecoration(labelText: "Username"),
                        style: TextStyle(color: Colors.white),
                      )),
                  new Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: new TextFormField(
                        onSaved: (val) => _password = val,
                        decoration: new InputDecoration(labelText: "Password"),
                      ))
                ],
              )),
        ),
        loginButton
      ],
    );

    return new Scaffold(
      backgroundColor: Color(0xff595d6b),
      appBar: new AppBar(title: new Text("Login Page")),
      key: scaffoldKey,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: new Container(
          child: new Center(
            child: loginForm,
          ),
        ),
      ),
    );
  }

  @override
  void onLoginError(String error) {
    _showSnackBar(error);
    setState(() {
      this._isLoading = false;
    });
  }

  @override
  void onLoginSuccess(User user) async {
    _showSnackBar(user.toString());
    setState(() {
      this._isLoading = false;
    });
    var db = new DatabaseHelper();
    await db.saveUser(user);
    Navigator.of(context).pushNamed("/home");
  }
}
