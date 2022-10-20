// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/providers/scan_list_provider.dart';

import 'package:qr_reader/widgets/custom_navigatorbar.dart';
import 'package:qr_reader/widgets/scan_buttonbar.dart';

import 'mapas_pages.dart';
import 'package:qr_reader/pages/diracciones_page.dart';
import 'package:qr_reader/providers/ui_provider.dart';
import 'package:qr_reader/providers/db_provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Historial'),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.delete_forever))
        ],
      ),
      body: _HomePageBody(),
      bottomNavigationBar: CustomNavigatorBar(),
      floatingActionButton: ScanButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class _HomePageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Obtener el selected menu opt
    final uiProvider = Provider.of<UiProvider>(context);
    //Cambiar  para mostrar la pagina respectiva
    final int currentIndex = uiProvider.selectedMenuOpt;

    // todo temporal leer la db
    // final tempScan = ScanModel(valor: 'http://holis.com');
    // DBProvider.db.nuevoScan(tempScan).then((value) => print(value));

    // DBProvider.db.getScanById(16).then((value) => print(value!.valor));
    // DBProvider.db.getTodosScans().then(print);
    // DBProvider.db.deleteAllScan();

    /// Usar el ScanListProvider
    final scanListProvider =
        Provider.of<ScanListProvider>(context, listen: false);

    switch (currentIndex) {
      case 0:
        scanListProvider.cargarScansPorTipo('geo');
        return MapasPage();
      case 1:
        scanListProvider.cargarScansPorTipo('http');
        return DireccionesPage();
      default:
        return MapasPage();
    }
  }
}
