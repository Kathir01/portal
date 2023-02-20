import 'package:flutter/material.dart';
import 'package:portal/pages/pages.dart';
import 'package:portal/services/services.dart';

class PostData extends StatefulWidget {
  PostData({super.key, required this.iddata});
  List<String> iddata;
  @override
  State<PostData> createState() => _PostDataState();
}

class _PostDataState extends State<PostData> {
  void _shipment() async {
    setState(() {
      //String fileNo =
      getToken(widget.iddata[1], 20, "null", widget.iddata[0]);
    });
    Navigator.push(context, MaterialPageRoute(builder: (_) => DataFetch()));
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
