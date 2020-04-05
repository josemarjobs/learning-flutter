import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waxapp/providers/settings_provider.dart';
import 'package:waxapp/screens/home_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SettingsProvider>(
      create: (context) => SettingsProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          accentColor: Colors.deepOrangeAccent,
        ),
        home: HomeScreen(),
      ),
    );
  }
}
