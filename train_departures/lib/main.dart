import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:traindepartures/providers/septa_provider.dart';
import 'package:traindepartures/screens/departures_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SeptaProvider>(
      create: (context) => SeptaProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Train Departures',
        theme: ThemeData(
          brightness: Brightness.dark,
          accentColor: Colors.deepOrangeAccent,
          textTheme: TextTheme(
            body1: GoogleFonts.orbitron(
              textStyle: TextStyle(
                color: Colors.cyan,
                fontSize: 16.0,
              ),
            ),
            body2: GoogleFonts.openSans(
              textStyle: TextStyle(
                color: Colors.deepOrangeAccent,
                fontSize: 12.0,
                fontWeight: FontWeight.w600
              ),
            ),
            title: GoogleFonts.orbitron(
              textStyle: TextStyle(
                color: Colors.cyan,
                fontSize: 20.0,
                fontWeight: FontWeight.w600
              ),
            ),
          ),
        ),
        home: DeparturesScreen(),
      ),
    );
  }
}
