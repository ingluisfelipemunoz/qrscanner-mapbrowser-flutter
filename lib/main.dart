import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrscanner/pages/home_page.dart';
import 'package:qrscanner/pages/mapa_page.dart';
import 'package:qrscanner/providers/scan_list_service.dart';
import 'package:qrscanner/providers/ui_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => new UiProvider()),
        ChangeNotifierProvider(create: (_) => new ScanListService())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'QrReqder',
        initialRoute: 'home',
        routes: {'home': (_) => HomePage(), 'mapa': (_) => MapaPage()},
        theme: ThemeData(
            primaryColor: Colors.red,
            floatingActionButtonTheme: FloatingActionButtonThemeData(
                backgroundColor: Colors.deepPurple)),
      ),
    );
  }
}
