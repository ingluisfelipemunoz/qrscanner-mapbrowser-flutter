import 'package:flutter/material.dart';
import 'package:qrscanner/models/scan_model.dart';
import 'package:qrscanner/providers/db_provider.dart';

class ScanListService extends ChangeNotifier {
  List<ScanModel> scans = [];
  String tipo = 'http';

  Future<ScanModel> nuevoScan(String valor) async {
    final scan = new ScanModel(valor: valor);
    final id = await DBProvider.db.nuevoScan(scan);
    scan.id = id!;
    if (this.tipo == scan.tipo) {
      scans.add(scan);
      notifyListeners();
    }
    return scan;
  }

  cargarScans() async {
    final scans = await DBProvider.db.getScans();
    this.scans = [...scans];
    notifyListeners();
  }

  cargarScansPorTipo(String tipo) async {
    final scans = await DBProvider.db.getScansPorTipo(tipo);
    this.scans = [...scans];
    print("""tipo $tipo, scans${scans.map((x) => x.valor)} """);
    notifyListeners();
  }

  borrarTodos() async {
    await DBProvider.db.deleteAllScans();
    this.scans = [];
    notifyListeners();
  }

  borrarScanPorId(int id) async {
    await DBProvider.db.deleteScanById(id);
    await this.cargarScansPorTipo(this.tipo);
  }
}
