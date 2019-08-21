import 'package:flutter/material.dart';
import 'package:my_movie_browser/UI/pages/login/login_page.dart';
import 'package:my_movie_browser/UI/pages/home_page.dart';

void main() => runApp(MyApp());

final routes = {
  '/login': (BuildContext context) => new LoginPage(),
  '/home': (BuildContext context) => HomePage(),
  '/': (BuildContext context) => new LoginPage(),
};

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'My movie browser',
      theme: new ThemeData(primarySwatch: Colors.teal),
      routes: routes,
    );
  }
}
