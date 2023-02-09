import 'dart:async';
import 'dart:io';
import 'package:hacker_news/src/resources/repository.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/item_model.dart';

class NewsDbProvider implements Source, Cache {
  late Database db;

  NewsDbProvider() {
    init();
  }

  // Todo - store and fetch top ids
  @override
  Future<List<int>>? fetchTopIds() {
    return null;
  }

  void init() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'items.db');
    db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database newDb, int version) {
        newDb.execute("""
          CREATE TABLE Items(  id  INTEGER PRIMARY KEY,
    deleted  INTEGER ,
  type TEXT  ,
      by  TEXT ,
      time  INTEGER ,
      text  TEXT ,
      dead  INTEGER ,
      parent INTEGER  ,
      kids  BLOB ,
      url  TEXT ,
      score  INTEGER ,
     title  TEXT ,
      descendants  INTEGER 
      )
        
        """);
      },
    );
  }

  Future<ItemModel?> fetchItem(int id) async {
    final maps = await db.query(
      "Items",
      columns: null,
      where: "id = ?",
      whereArgs: [id],
    );

    if (maps.length > 0) {
      return ItemModel.fromDb(maps.first);
    }

    return null;
  }

  Future<int> addItem(ItemModel item) {
    return db.insert(
      "Items",
      item.toMap(),
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }

  Future<int> clear() {
    return db.delete('Items');
  }
}

final newsDbProvider = NewsDbProvider();
