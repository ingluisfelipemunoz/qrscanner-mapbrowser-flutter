import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';
import 'package:qrscanner/providers/scan_list_service.dart';
import 'package:qrscanner/utils/utils.dart';

class ScanButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        elevation: 0,
        child: Icon(Icons.filter_center_focus),
        onPressed: () async {
          String res = await FlutterBarcodeScanner.scanBarcode(
              '#3d8ebf', 'Cancelar', false, ScanMode.QR);
          if (res != '-1') {
            final scanListService =
                Provider.of<ScanListService>(context, listen: false);
            final nuevoScan = await scanListService.nuevoScan(res);
            launchURL(context, nuevoScan);
            //scanListService.nuevoScan('geo:19.225043,-70.343280');
          }

          print(res);
        });
  }
}
