import 'package:flutter/material.dart';
import 'package:login_stateful/src/screens/login_screen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Log me in',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Log me in'),
          backgroundColor: Colors.teal,
        ),
        body: Center(
          child: LoginScreen(),
        ),
      ),
    );
  }
}
