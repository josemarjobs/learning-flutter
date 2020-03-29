import 'package:news/src/resources/news_api_provider.dart';
import 'package:news/src/resources/repository.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'dart:async';
import 'package:news/src/models/item_model.dart';

class NewsDbProvider implements Source, Cache {
  Database db;
  
  NewsDbProvider() {
    init();
  }

  void init() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, "items.db");
    db = await openDatabase(path, version: 1,
        onCreate: (Database newDb, int version) {
      newDb.execute("""
        CREATE TABLE Items
          (
            id INTEGER PRIMARY KEY,
            type TEXT,
            by TEXT,
            time INTEGER,
            text TEXT,
            parent INTEGER,
            kids BLOB,
            dead INTEGER,
            deleted INTEGER,
            url TEXT,
            score INTEGER,
            title TEXT,
            descendants INTEGER
          );
        """);
    });
  }

  @override
  Future<ItemModel> fetchItem(int id) async {
    final maps = await db.query(
      "Items",
      columns: null,
      where: "id = ?",
      whereArgs: [id],
    );

    if (maps.isEmpty) {
      return null;
    }

    return ItemModel.fromDb(maps.first);
  }

  @override
  Future<int> addItem(ItemModel item) {
    return db.insert("Items", item.toMap());
  }

  @override
  Future<List<int>> fetchTopIds() {
    return null;
  }
}

NewsDbProvider newDbProvider = NewsDbProvider();
