import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:traindepartures/models/train.dart';

class SeptaService {
  final baseUrl = 'http://www3.septa.org/hackathon/Arrivals';

  Future<List<Train>> loadStationData(String station) async {
    final response = await http.get('$baseUrl/$station/10/');
    // replace dynamic key and decode
    final int startIndex = response.body.indexOf('[');
    var json = convert.jsonDecode(
      '{"Departures": ${response.body.substring(startIndex)}',
    );

    // build the train list
    var trains = List<Train>();
    try {
      var north = json['Departures'][0]['Northbound'];
      var south = json['Departures'][1]['Southbound'];

      (north + south).forEach((train) => trains.add(Train.fromJson(train)));
      print('done loading...');
    } catch (e) {
      print('error loading trains: $e');
    }

    // sort
    trains.sort((a, b) => a.departTime.compareTo(b.departTime));

    // update the stream
    return trains;
  }
}
