import 'package:flutter/material.dart';

class ThirdPage extends StatelessWidget {
  final String username;
  final int points;

  ThirdPage({this.username, this.points});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Third Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Third Page',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 60.0),
            ),
            Text(
              'Username: $username',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
            ),
            Text(
              'Points: $points',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }
}
