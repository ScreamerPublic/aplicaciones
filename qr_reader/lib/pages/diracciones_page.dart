import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/providers/scan_list_provider.dart';

class DireccionesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final scanListProvider = Provider.of<ScanListProvider>(context);

    final scans = scanListProvider.scans;

    return ListView.builder(
      itemBuilder: (_, i) => ListTile(
        leading: Icon(
          Icons.assistant_navigation,
          color: Theme.of(context).primaryColor,
        ),
        title: Text(scans[i].valor),
        subtitle: Text(scans[i].id.toString()),
        // ignore: prefer_const_constructors
        trailing: Icon(
          Icons.keyboard_arrow_right,
          color: Colors.grey,
        ),
        onTap: () => print(scans[i].id),
      ),
      itemCount: scans.length,
    );
  }
}
