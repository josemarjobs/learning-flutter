import 'dart:convert';

import 'package:footballers/models/api_models.dart';
import 'package:http/http.dart' as http;

class PlayerApiProvider {
  final String baseUrl =
      'https://www.easports.com/fifa/ultimate-team/api/fut/item?country=';

  Future<List<Players>> fetchPlayerByCountry(String countryId) async {
    final String url = '$baseUrl$countryId';
    final response = await http.get(url);

    if (response.statusCode == 200) {
      Set<Players> uniquePlayers = Set<Players>();
      ApiResult
          .fromJson(json.decode(response.body))
          .items
          .forEach(uniquePlayers.add);

      return uniquePlayers.toList();
    } else {
      throw Exception('Failed to load players');
    }
  }
}
