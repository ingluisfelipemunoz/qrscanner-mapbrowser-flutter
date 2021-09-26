import 'package:flutter/material.dart';
import 'package:qrscanner/models/scan_model.dart';
import 'package:url_launcher/url_launcher.dart';

void launchURL(BuildContext context, ScanModel scan) async {
  if (scan.tipo == 'http') {
    await _openBrowser(scan);
  } else {
    await _openMap(context, scan);
  }
}

_openBrowser(ScanModel scan) async {
  final url = scan.valor;
  if (await canLaunch(url)) {
    await launch(
      url,
      forceWebView: true,
    );
  } else {
    throw 'Could not launch $url';
  }
}

_openMap(BuildContext context, ScanModel scan) async {
  Navigator.pushNamed(context, 'mapa', arguments: scan);
}
