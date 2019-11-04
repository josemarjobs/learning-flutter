import 'package:news/src/models/item_model.dart';
import 'package:news/src/resources/news_api_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:http/testing.dart';

void main() {
  test('FetchTopIds returns a list of ids', () async {
    final newsApi = NewsApiProvider();
    newsApi.client = MockClient((request) async {
      final ids = [1, 2, 3, 4];
      return Response(json.encode(ids), 200);
    });

    final topIds = await newsApi.fetchTopIds();
    expect(topIds, equals([1, 2, 3, 4]));
  });

  test('FetchItem returns an ItemModel', () async {
    final newsApi = NewsApiProvider();
    newsApi.client = MockClient((request) async {
      final itemMap = {
        "by": "minimaxir",
        "descendants": 74,
        "id": 21,
        "kids": [1, 2, 3],
        "score": 143,
        "time": 123,
        "title": "Designing the Facebook Company Brand",
        "type": "story",
        "url": "https://facebook.design/companybrand"
      };
      return Response(json.encode(itemMap), 200);
    });

    final item = await newsApi.fetchItem(21);

    expect(item.id, equals(21));
    expect(item.title, equals("Designing the Facebook Company Brand"));
    expect(item.kids.length, equals(3));
  });
}
