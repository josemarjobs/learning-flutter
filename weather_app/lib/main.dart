import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp/blocs/blocs.dart';
import 'package:weatherapp/repositories/repositories.dart';
import 'package:http/http.dart' as http;
import 'package:weatherapp/widgets/weather_page.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();

  final WeatherRepository weatherRepository = WeatherRepository(
    weatherApiClient: WeatherApiClient(
      httpClient: http.Client(),
    ),
  );

  runApp(App(weatherRepository: weatherRepository));
}

class App extends StatelessWidget {
  final WeatherRepository weatherRepository;

  App({@required this.weatherRepository}) : assert(weatherRepository != null);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.red,
        accentColor: Colors.tealAccent,
      ),
      home: BlocProvider(
        create: (context) => WeatherBloc(weatherRepository: weatherRepository),
        child: WeatherPage(),
      ),
    );
  }
}
