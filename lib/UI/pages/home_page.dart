import 'package:flutter/material.dart';
import 'package:my_movie_browser/utils/database_helper.dart';
import 'package:my_movie_browser/data/user.dart';

class HomePage extends StatelessWidget {
  DatabaseHelper _db = new DatabaseHelper();
  User _currentUser;

  @override
  Widget build(BuildContext context) {
    setUser();
    return Scaffold(
      backgroundColor: Color(0xff595d6b),
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: Stack(
        children: <Widget>[
          Center(
              child: Column(
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.all(10.0), child: Text("user:")),
            ],
          )),

          //No sé
          //BottomAppBar,
        ],
      ),
    );
  }

  void setUser() async {
    _currentUser = await _db.getUser(0);
  }
}
