import 'dart:async';

import 'package:news/src/models/item_model.dart';
import 'package:news/src/resources/news_api_provider.dart';
import 'package:news/src/resources/news_db_provider.dart';

abstract class Cache {
  Future<int> addItem(ItemModel item);
}

abstract class Source {
  Future<List<int>> fetchTopIds();
  Future<ItemModel> fetchItem(int id);
}
class Repository {
  List<Source> sources = <Source>[
    NewsApiProvider(),
    newDbProvider,
  ];

  List<Cache> caches = <Cache>[newDbProvider];

  NewsDbProvider dbProvider = NewsDbProvider();
  NewsApiProvider apiProvider = NewsApiProvider();

  Future<List<int>> fetchTopIds() {
    return sources[1].fetchTopIds();
  }

  Future<ItemModel> fetchItem(int id) async {
    ItemModel item;
    Source source;

    for (source in sources) {
      item = await source.fetchItem(id);
      if (item != null) {
        break;
      }
    }

    for (var cache in caches) {
      cache.addItem(item);
    }

    return item;
  }
}
