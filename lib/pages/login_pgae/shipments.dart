import 'package:flutter/material.dart';
import 'package:portal/pages/pages.dart';

class Shipments extends StatefulWidget {
  Shipments({super.key, required this.iddata});
  List<String> iddata;

  @override
  State<Shipments> createState() => _ShipmentsState();
}

class _ShipmentsState extends State<Shipments> {
  late Future filenumbers;

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
        child: ElevatedButton(
          onPressed: _shipment,
          child: Text("Shipments"),
        ),
      ),
    );
  }
}

// Future<void> _showProgressNotification() async {
//   const int maxProgress = 5;
//   for (int i = 0; i <= maxProgress; i++) {
//     await Future<void>.delayed(const Duration(seconds: 1), () async {
//       final AndroidNotificationDetails androidPlatformChannelSpecifics =
//           AndroidNotificationDetails(
//               'progress channel', 'progress channel description',
//               channelShowBadge: false,
//               importance: Importance.max,
//               priority: Priority.high,
//               onlyAlertOnce: true,
//               showProgress: true,
//               maxProgress: maxProgress,
//               progress: i);
//       final NotificationDetails platformChannelSpecifics =
//           NotificationDetails(android: androidPlatformChannelSpecifics);

//       await flutterLocalNotificationsPlugin.show(
//           0,
//           'progress notification title',
//           'progress notification body',
//           platformChannelSpecifics,
//           payload: 'item x');
//     });
//   }
// }
