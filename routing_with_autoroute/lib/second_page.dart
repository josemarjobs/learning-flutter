import 'package:flutter/material.dart';

class SecondPage extends StatelessWidget {
  final String userId;

  SecondPage({@required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Second Page',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 60.0),
            ),
            Text(userId),
          ],
        ),
      ),
    );
  }
}
