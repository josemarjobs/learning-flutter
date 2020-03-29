import 'package:http/http.dart' show Client;
import 'dart:convert';
import 'dart:async';
import 'package:news/src/models/item_model.dart';
import 'package:news/src/resources/repository.dart';

final _rootUrl = 'https://hacker-news.firebaseio.com/v0';

class NewsApiProvider implements Source{
  Client client = Client();

  @override
  Future<List<int>> fetchTopIds() async {
    final response = await client.get('$_rootUrl/v0/topstories.json');
    final ids = json.decode(response.body);

    return ids.cast<int>();
  }

  @override
  Future<ItemModel> fetchItem(int id) async {
    final response = await client.get('$_rootUrl/v0/item/$id');
    final parsedJson = json.decode(response.body);
    return ItemModel.fromJson(parsedJson);
  }
}
