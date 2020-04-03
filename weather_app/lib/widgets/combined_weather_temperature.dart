import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:weatherapp/models/models.dart';
import 'package:weatherapp/widgets/temperature.dart';
import 'package:weatherapp/widgets/weather_conditions.dart';

class CombinedWeatherTemperature extends StatelessWidget {
  final Weather weather;

  CombinedWeatherTemperature({@required this.weather})
      : assert(weather != null);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: WeatherConditions(condition: weather.condition),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Temperature(
                temperature: weather.temp,
                high: weather.maxTemp,
                low: weather.minTemp,
              ),
            )
          ],
        ),
        Center(
          child: Text(
            weather.formattedCondition,
            style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.w200,
              color: Colors.white,
            ),
          ),
        )
      ],
    );
  }
}


