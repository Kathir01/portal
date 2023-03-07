import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:portal/pages/pages.dart';

import '../../services/services.dart';

class Shipments extends StatefulWidget {
  Shipments({required this.iddata});
  List<String> iddata;

  @override
  State<Shipments> createState() => _ShipmentsState();
}

class _ShipmentsState extends State<Shipments> {
  late Future filenumbers;
  String? filePath;

  void _shipment() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => MyHomePage(
                  iddata2: widget.iddata,
                )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _shipment,
              child: Text("Shipments"),
            ),
            ElevatedButton(
              onPressed: () async {
                await downloadFile();
                // final directory = await getApplicationDocumentsDirectory();
                // setState(() {
                //   filePath = '${directory.path}/file_name.jpg';
                // });
              },
              child: Text("Download"),
            ),
          ],
        ),
      ),
    );
  }
}
