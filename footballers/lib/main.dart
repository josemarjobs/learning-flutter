import 'package:flutter/material.dart';
import 'package:footballers/pages/home_page.dart';
import 'package:footballers/services/repository.dart';

void main() {
  PlayerRepository _repository = PlayerRepository();

  runApp(MyApp(playerRepository: _repository));
}

class MyApp extends StatelessWidget {
  final PlayerRepository playerRepository;

  MyApp({
    @required this.playerRepository,
  }); // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: HomePage(playerRepository: playerRepository),
    );
  }
}
