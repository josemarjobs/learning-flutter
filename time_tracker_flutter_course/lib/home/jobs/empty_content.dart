import 'package:flutter/material.dart';

class EmptyContent extends StatelessWidget {
  final String title;
  final String message;

  EmptyContent({
    this.title = 'Nothing here',
    this.message = 'Add a new item to get started',
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(fontSize: 32.0, color: Colors.black54),
          textAlign: TextAlign.center,
        ),
        Text(
          message,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18.0, color: Colors.black54),
        ),
      ],
    );
  }
}
