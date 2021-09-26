import 'dart:io';

import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qrscanner/models/scan_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBProvider {
  static Database? _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  Future<Database> initDB() async {
    //donde se almacenara la db
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'ScansDB.db');
    print(path);
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
        CREATE TABLE Scans(
          id INTEGER PRIMARY KEY,
          tipo TEXT,
          valor TEXT
        );
      ''');
    });
  }

  nuevoScanRaw(ScanModel scan) async {
    final db = await database;
    final id = scan.id;
    final tipo = scan.tipo;
    final valor = scan.valor;

    final res = await db?.rawInsert('''
      INSERT INTO Scans(id, tipo, valor)
      VALUES($id, '$tipo', '$valor')
    ''');
    return res;
  }

  Future<int?> nuevoScan(ScanModel scan) async {
    final db = await database;
    final res = await db?.insert('Scans', scan.toJson());
    print("new id $res");
    return res;
  }

  Future<ScanModel?> getScanById(int id) async {
    final db = await database;
    final res = await db!.query('Scans', where: 'id = ?', whereArgs: [id]);
    return res.isNotEmpty ? ScanModel.fromJson(res.first) : null;
  }

  Future<List<ScanModel>> getScansPorTipo(String tipo) async {
    final db = await database;
    final res = await db!.query('Scans', where: 'tipo = ?', whereArgs: [tipo]);
    return res.isNotEmpty ? res.map((s) => ScanModel.fromJson(s)).toList() : [];
  }

  Future<List<ScanModel>> getScans() async {
    final db = await database;
    final res = await db!.query('Scans');
    return res.isNotEmpty ? res.map((s) => ScanModel.fromJson(s)).toList() : [];
  }

  Future<int?> updateScan(ScanModel scan) async {
    final db = await database;
    final res = await db!
        .update('Scans', scan.toJson(), where: 'id = ?', whereArgs: [scan.id]);
    return res;
  }

  Future<int> deleteScan(int id) async {
    final db = await database;
    final res = await db!.delete('Scans', where: 'id = ?', whereArgs: [id]);
    return res;
  }

  Future<int> deleteAllScans() async {
    final db = await database;
    final res = await db!.delete('Scans');
    return res;
  }

  Future<int> deleteScanById(int id) async {
    final db = await database;
    final res = await db!.delete('Scans', where: 'id = ?', whereArgs: [id]);
    return res;
  }
}
