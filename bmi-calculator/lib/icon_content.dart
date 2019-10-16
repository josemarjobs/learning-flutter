import 'package:flutter/material.dart';

const labelStyle = TextStyle(
  fontSize: 18.0,
  color: Color(0xFF8D8E98),
);

class IconContent extends StatelessWidget {
  final String label;
  final IconData icon;

  const IconContent({this.label, this.icon});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          icon,
          size: 80.0,
        ),
        SizedBox(height: 15.0),
        Text(
          label,
          style: labelStyle,
        )
      ],
    );
  }
}
