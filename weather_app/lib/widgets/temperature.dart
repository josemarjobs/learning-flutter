import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class Temperature extends StatelessWidget {
  final double temperature;
  final double high;
  final double low;

  Temperature({
    @required this.temperature,
    @required this.high,
    @required this.low,
  }) : assert(temperature != null);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.only(right: 20.0),
          child: Text(
            '${_formattedTemperature(temperature)}°',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
        Column(
          children: [
            Text(
              'max: ${_formattedTemperature(high)}°',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w300,
                color: Colors.white,
              ),
            ),
            Text(
              'min: ${_formattedTemperature(low)}°',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w300,
                color: Colors.white,
              ),
            )
          ],
        )
      ],
    );
  }

  int _formattedTemperature(double t) => t.round();
}
