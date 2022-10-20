import 'package:flutter/material.dart';
import 'package:qr_reader/providers/db_provider.dart';

class ScanListProvider extends ChangeNotifier {
  List<ScanModel> scans = [];

  String tipoSeleccionado = 'http';

  nuevoScan(String valor) async {
    final nuevoScan = new ScanModel(valor: valor);
    final id = await DBProvider.db.nuevoScan(nuevoScan);

    //=== Asignar el ID de la db al modelo
    nuevoScan.id = id;

    if (tipoSeleccionado == nuevoScan.tipo) {
      scans.add(nuevoScan);
      notifyListeners();
    }
  }

  cargarScans() async {
    final scans = await DBProvider.db.getTodosScans();
    this.scans = [...?scans];
    notifyListeners();
  }

  cargarScansPorTipo(String tipo) async {
    final scans = await DBProvider.db.getScansPorTipo(tipo);
    this.scans = [...?scans];
    tipoSeleccionado == tipo;
    notifyListeners();
  }

  borrarTodos() async {
    final scans = await DBProvider.db.deleteAllScan();
    this.scans = [];
    notifyListeners();
  }

  borrarScanPorId(int id) async {
    final scans = await DBProvider.db.deleteScan(id);
    cargarScansPorTipo(tipoSeleccionado);
  }
}
