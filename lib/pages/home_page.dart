import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrscanner/models/scan_model.dart';
import 'package:qrscanner/pages/direcciones_page.dart';
import 'package:qrscanner/pages/mapas_page.dart';
import 'package:qrscanner/providers/db_provider.dart';
import 'package:qrscanner/providers/scan_list_service.dart';
import 'package:qrscanner/providers/ui_provider.dart';
import 'package:qrscanner/widgets/custom_navigatorbar.dart';
import 'package:qrscanner/widgets/scan_button.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final scanListService =
        Provider.of<ScanListService>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Historial'),
        actions: [
          IconButton(
              onPressed: () => scanListService.borrarTodos(),
              icon: Icon(Icons.delete_forever))
        ],
      ),
      body: _HomePageBody(),
      bottomNavigationBar: CustomNavigationBar(),
      floatingActionButton: ScanButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class _HomePageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //TODO: temporal leer la base de datos
    // DBProvider.db.nuevoScan(
    //     new ScanModel(valor: 'hola' + new DateTime.now().toString()));

    final scanListService =
        Provider.of<ScanListService>(context, listen: false);

    // obtener el selected menu opt
    final uiProvider = Provider.of<UiProvider>(context);
    final currentIndex = uiProvider.selectedMenuOpt;
    print('current index $currentIndex');
    switch (currentIndex) {
      case 0:
        scanListService.cargarScansPorTipo('geo');
        return MapasPage();
      case 1:
        scanListService.cargarScansPorTipo('http');
        return DireccionesPage();
      default:
        return MapasPage();
    }
  }
}
