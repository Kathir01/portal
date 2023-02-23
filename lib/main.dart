import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:portal/pages/pages.dart';
// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       home: SplashPage(),
//     );
//   }
// }

final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // const AndroidInitializationSettings initializationSettingsAndroid =
  //     AndroidInitializationSettings('@mipmap/ic_launcher');

  // final InitializationSettings initializationSettings =
  //     InitializationSettings(android: initializationSettingsAndroid);

  // await flutterLocalNotificationsPlugin.initialize(
  //   initializationSettings,
  //   // onSelectNotification: (String payload) async {
  //   //   if (payload != null) {
  //   //     debugPrint('notification payload: $payload');
  //   //   }
  //   // }
  // );
  runApp(ProviderScope(
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashPage(),
    );
  }
}

class ReceivedNotification {
  ReceivedNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.payload,
  });

  final int id;
  final String title;
  final String body;
  final String payload;
}
