import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:qr_reader/pages/home_page.dart';
import 'package:qr_reader/pages/mapas_pages.dart';

import 'package:qr_reader/providers/ui_provider.dart';
import 'package:qr_reader/providers/scan_list_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UiProvider()),
        ChangeNotifierProvider(create: (_) => ScanListProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'QR Reader',
        initialRoute: 'home',
        routes: {'home': (_) => HomePage(), 'mapa': (_) => MapasPage()},
        theme: ThemeData(
            primarySwatch: Colors.amber,
            floatingActionButtonTheme:
                FloatingActionButtonThemeData(backgroundColor: Colors.green)),
      ),
    );
  }
}
