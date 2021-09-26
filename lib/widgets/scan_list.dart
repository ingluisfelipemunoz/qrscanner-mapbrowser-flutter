import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrscanner/providers/scan_list_service.dart';
import 'package:qrscanner/utils/utils.dart';

class ScanListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final scanListService = Provider.of<ScanListService>(context, listen: true);
    final scans = scanListService.scans;
    return ListView.builder(
        itemCount: scans.length,
        itemBuilder: (_, i) => Dismissible(
            key: UniqueKey(),
            background: Container(color: Colors.red),
            onDismissed: (DismissDirection direction) {
              scanListService.borrarScanPorId(scans[i].id);
            },
            child: ListTile(
              leading: Icon(Icons.home_outlined,
                  color: Theme.of(context).primaryColor),
              title: Text(scans[i].valor),
              subtitle: Text(scans[i].id.toString()),
              trailing: Icon(Icons.keyboard_arrow_right, color: Colors.grey),
              onTap: () {
                print(scans[i].id);
                launchURL(context, scans[i]);
              },
            )));
  }
}
