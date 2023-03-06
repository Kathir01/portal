import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:portal/main.dart';

Future<void> downloadFile() async {
  String url =
      "https://commons.wikimedia.org/wiki/File:Sunflower_from_Silesia2.jpg";
  Directory directory = await getApplicationDocumentsDirectory();
  String filePath = '${directory.path}/file_name.ext';
  final request = await HttpClient().getUrl(Uri.parse(url));
  final response = await request.close();
  var bytes = await consolidateHttpClientResponseBytes(response);
  await File(filePath).writeAsBytes(bytes);
  await _showProgressNotification(filePath);
}

Future<dynamic> _showProgressNotification(String filePath) async {
  const int maxProgress = 5;
  for (int i = 0; i <= maxProgress; i++) {
    await Future<void>.delayed(const Duration(seconds: 1), () async {
      if (i == maxProgress) {
        final AndroidNotificationDetails androidPlatformChannelSpecifics =
            AndroidNotificationDetails(
          'completed channel',
          'completed channel description',
          '',
          channelShowBadge: false,
          importance: Importance.max,
          priority: Priority.high,
        );
        final NotificationDetails platformChannelSpecifics =
            NotificationDetails(android: androidPlatformChannelSpecifics);

        await flutterLocalNotificationsPlugin.show(
            0,
            'Download complete',
            'The file has been downloaded successfully',
            platformChannelSpecifics,
            payload: filePath);

        // await openDownloadedFile(filePath);
      } else {
        final AndroidNotificationDetails androidPlatformChannelSpecifics =
            AndroidNotificationDetails(
                'progress channel', 'progress channel description', '',
                channelShowBadge: false,
                importance: Importance.max,
                priority: Priority.high,
                onlyAlertOnce: true,
                showProgress: true,
                maxProgress: maxProgress,
                progress: i);
        final NotificationDetails platformChannelSpecifics =
            NotificationDetails(android: androidPlatformChannelSpecifics);

        await flutterLocalNotificationsPlugin.show(
            0,
            'progress notification title',
            'progress notification body',
            platformChannelSpecifics,
            payload: null);
      }
    });
  }
}

Future<void> openDownloadedFile(String filePath) async {
  final result = await OpenFile.open(filePath);
  print("********************");
  print(result);
}
