import 'dart:async';

import 'package:cars_sample/domain/carro.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class CarroDB {
  static final CarroDB _instance = CarroDB.getInstance();

  factory CarroDB() => _instance;

  CarroDB.getInstance();

  static Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();

    return _db;
  }

  initDb() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'carros.db');
    print('db $path');

    // para testes - deletar o banco
    // await deleteDatabase(path);
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE carro(id INTEGER PRIMARY KEY, tipo TEXT, nome TEXT'
        ', desc TEXT, urlFoto TEXT, urlVideo TEXT, lat TEXT, lng TEXT)');
  }

  Future<int> saveCarro(Carro carro) async {
    var dbClient = await db;
    final sql =
        'insert or replace into carro (id,tipo,nome,desc,urlFoto,urlVideo,lat,lng) VALUES '
        '(?,?,?,?,?,?,?,?)';
    print(sql);
    var id = await dbClient.rawInsert(sql, [
      carro.id,
      carro.tipo,
      carro.nome,
      carro.desc,
      carro.urlFoto,
      carro.urlVideo,
      carro.latitude,
      carro.longitude,
    ]);
    print('id: $id');
    return id;
  }

  Future<List<Map>> getAllCarros() async {
    final dbClient = await db;
    final result = await dbClient.rawQuery('select * from carro');

    return result.toList();
  }

  Future<int> getCount() async {
    var dbClient = await db;
    final result = await dbClient.rawQuery('select count(*) from carro');

    return Sqflite.firstIntValue(result);
  }

  Future<Carro> getCarro(int id) async {
    var dbClient = await db;
    final result =
        await dbClient.rawQuery('select * from carro where id = ?', [id]);

    if (result.length > 0) {
      return Carro.fromJson(result.first);
    }

    return null;
  }

  Future<bool> exists(Carro carro) async {
    Carro c = await getCarro(carro.id);
    var exists = c != null;

    return exists;
  }

  Future<int> deleteCarro(int id) async {
    var dbClient = await db;
    return await dbClient.rawDelete('delete from carro where id = ?', [id]);
  }

  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }
}
