
import 'package:flutter/material.dart';

class BottomAppBar extends StatefulWidget {
  @override
  BottomAppBarState createState() => BottomAppBarState();
}

//not functional

class BottomAppBarState extends State<BottomAppBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      width: MediaQuery.of(context).size.width,
      height: 56,
      child: Row(
        children: <Widget>[
          Icon(Icons.home),
          Icon(Icons.favorite_border),
          Icon(Icons.settings)
        ],
      )
    );
  }
}
