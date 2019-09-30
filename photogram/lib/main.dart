import 'package:flutter/material.dart';
import 'package:photogram/pages/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Photogram',
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}
