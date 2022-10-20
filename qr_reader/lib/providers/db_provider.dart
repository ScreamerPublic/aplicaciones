import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'package:qr_reader/models/scan_model.dart';
export 'package:qr_reader/models/scan_model.dart';

class DBProvider {
  static Database? _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database?> get database async {
    if (_database != null) return _database;
    return _database = await initDB();
  }

  Future<Database> initDB() async {
    //path de donde almacenaresmo la db
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'ScansDB.db');
    print('Url: ' + path);
    //crear db
    return await openDatabase(
      path,
      version: 10,
      onOpen: (db) {},
      onCreate: (db, version) async {
        await db.execute('''
        CREATE TABLE Scans(
          id INTEGER PRIMARY KEY,
          tipo TEXT,
          valores TEXT
        )
      ''');
      },
    );
  }

  Future<int> nuevoScanRaw(ScanModel nuevoScan) async {
    final id = nuevoScan.id;
    final tipo = nuevoScan.tipo;
    final valor = nuevoScan.valor;

    //verificar la sb
    final db = await database;

    int res = await db!.rawInsert('''
        INSERT INTO Scans(id,tipo,valor) VALUES($id,'$tipo','$valor')
      ''');
    return res;
  }

  Future<int> nuevoScan(ScanModel nuevoScan) async {
    final db = await database;
    final res = await db!.insert('Scans', nuevoScan.toJson());

    // Es el id del ultimo id insertado
    return res;
  }

  Future<ScanModel?> getScanById(int id) async {
    final db = await database;
    final res = await db!.query('Scans', where: 'id = ?', whereArgs: [id]);

    return res.isNotEmpty ? ScanModel.fromJson(res.first) : null;
  }

  Future<List<ScanModel>?> getTodosScans() async {
    final db = await database;
    final res = await db!.query('Scans');

    return res.isNotEmpty ? res.map((e) => ScanModel.fromJson(e)).toList() : [];
  }

  Future<List<ScanModel>?> getScansPorTipo(String tipo) async {
    final db = await database;
    final res = await db!.rawQuery('''
      SELECT * FROM Scans WHERE tipo = '$tipo'
    ''');

    return res.isNotEmpty ? res.map((e) => ScanModel.fromJson(e)).toList() : [];
  }

  Future<int?> updateScan(ScanModel nuevoScan) async {
    final db = await database;
    final res = db!.update('Scans', nuevoScan.toJson(),
        where: 'id = ?', whereArgs: [nuevoScan.id]);
    return res;
  }

  Future<int?> deleteScan(int id) async {
    final db = await database;
    final res = await db!.delete('Scans', where: 'id = ?', whereArgs: [id]);
    return res;
  }

  Future<int?> deleteAllScan() async {
    final db = await database;
    final res = await db!.rawDelete('''DELETE FROM Scans''');
    return res;
  }
}
