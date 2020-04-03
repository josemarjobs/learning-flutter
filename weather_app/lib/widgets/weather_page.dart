import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp/blocs/blocs.dart';
import 'package:weatherapp/models/models.dart';
import 'package:weatherapp/widgets/city_selection_page.dart';
import 'package:weatherapp/widgets/combined_weather_temperature.dart';
import 'package:weatherapp/widgets/last_updated.dart';
import 'package:weatherapp/widgets/location.dart';

class WeatherPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App'),
        backgroundColor: Colors.black,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () => _getCityName(context),
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.black, Colors.grey.shade800]
          )
        ),
        child: BlocBuilder<WeatherBloc, WeatherState>(
          builder: (context, state) {
            if (state is WeatherEmpty) {
              return Center(
                child: Text(
                  'Please select a city',
                  style: TextStyle(
                    fontSize: 22.0,
                    color: Colors.white
                  ),
                ),
              );
            }
            if (state is WeatherLoading) {
              return Center(child: CircularProgressIndicator());
            }
            if (state is WeatherLoaded) {
              final weather = state.weather;

              return ListView(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 100.0),
                    child: Center(child: Location(location: weather.location)),
                  ),
                  Center(
                    child: LastUpdated(dateTime: weather.lastUpdated),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 50.0),
                    child: Center(
                      child: CombinedWeatherTemperature(weather: weather),
                    ),
                  )
                ],
              );
            }
            if (state is WeatherError) {
              return Text(
                'Something went wrong!',
                style: TextStyle(color: Colors.red),
              );
            }
            return Center(child: Text('Something went wrong'));
          },
        ),
      ),
    );
  }

  void _getCityName(BuildContext context) async {
    final city = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CitySelectionPage(),
      ),
    );
    if (city != null) {
      BlocProvider.of<WeatherBloc>(context).add(
        FetchWeather(city: city),
      );
    }
  }
}
