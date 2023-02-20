// import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
// import 'package:flutter/material.dart';

// class PdfViewPage extends StatefulWidget {
//   final String url;
//   final String name;
//   PdfViewPage({required this.url, required this.name});
//   @override
//   _PdfViewPageState createState() => _PdfViewPageState();
// }

// class _PdfViewPageState extends State<PdfViewPage> {
//   bool loading = true;
//   late PDFDocument pdfDocumnet;

//   loadPdf() async {
//     pdfDocumnet = await PDFDocument.fromURL(widget.url);
//     setState(() {
//       loading = false;
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//     loadPdf();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.name),
//       ),
//       body: loading
//           ? Center(
//               child: CircularProgressIndicator(),
//             )
//           : PDFViewer(document: pdfDocumnet),
//     );
//   }
// }


// import 'dart:convert';
// import 'dart:io';

// import 'package:dio/dio.dart';
// import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:open_file/open_file.dart';
// import 'package:path/path.dart' as path;
// import 'package:path_provider/path_provider.dart';
// import 'package:permission_handler/permission_handler.dart';

// import '../../main.dart';

// class PostData extends StatefulWidget {
//   const PostData({super.key});

//   @override
//   State<PostData> createState() => _PostDataState();
// }

// class _PostDataState extends State<PostData> {
//   final String _fileUrl = "http://lot.services/blog/files/DSCF0277.jpg";
//   final String _fileName = "DSCF0277.jpg";
//   final Dio _dio = Dio();

//   String _progress = "-";

//   late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

//   @override
//   void initState() {
//     super.initState();

//     flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//     final android = AndroidInitializationSettings('@mipmap/ic_launcher');

//     final initSettings = InitializationSettings(android: android);

//     flutterLocalNotificationsPlugin.initialize(
//       initSettings,
//       // onSelectNotification: _onSelectNotification
//     );
//   }

//   Future<void> _onSelectNotification(String json) async {
//     final obj = jsonDecode(json);

//     if (obj['isSuccess']) {
//       OpenFile.open(obj['filePath']);
//     } else {
//       showDialog(
//         context: context,
//         builder: (_) => AlertDialog(
//           title: Text('Error'),
//           content: Text('${obj['error']}'),
//         ),
//       );
//     }
//   }

//   Future<void> _showNotification(Map<String, dynamic> downloadStatus) async {
//     final android = AndroidNotificationDetails('channel id', 'channel name',
//         priority: Priority.high, importance: Importance.max);
//     final platform = NotificationDetails(android: android);
//     final json = jsonEncode(downloadStatus);
//     final isSuccess = downloadStatus['isSuccess'];

//     await flutterLocalNotificationsPlugin.show(
//         0,
//         isSuccess ? 'Success' : 'Failure',
//         isSuccess
//             ? 'File has been downloaded successfully!'
//             : 'There was an error while downloading the file.',
//         platform,
//         payload: json);
//   }

//   Future<Directory?> _getDownloadDirectory() async {
//     if (Platform.isAndroid) {
//       return await DownloadsPathProvider.downloadsDirectory;
//     }

//     return await getApplicationDocumentsDirectory();
//   }

//   // Future<bool> _requestPermissions() async {
//   //   var permission = await PermissionHandler()
//   //       .checkPermissionStatus(PermissionGroup.storage);

//   //   if (permission != PermissionStatus.granted) {
//   //     await PermissionHandler().requestPermissions([PermissionGroup.storage]);
//   //     permission = await PermissionHandler()
//   //         .checkPermissionStatus(PermissionGroup.storage);
//   //   }

//   //   return permission == PermissionStatus.granted;
//   // }

//   void _onReceiveProgress(int received, int total) {
//     if (total != -1) {
//       setState(() {
//         _progress = (received / total * 100).toStringAsFixed(0) + "%";
//       });
//     }
//   }

//   Future<void> _startDownload(String savePath) async {
//     Map<String, dynamic> result = {
//       'isSuccess': false,
//       'filePath': null,
//       'error': null,
//     };

//     try {
//       final response = await _dio.download(_fileUrl, savePath,
//           onReceiveProgress: _onReceiveProgress);
//       result['isSuccess'] = response.statusCode == 200;
//       result['filePath'] = savePath;
//     } catch (ex) {
//       result['error'] = ex.toString();
//     } finally {
//       await _showNotification(result);
//     }
//   }

//   Future<void> _download() async {
//     final dir = await _getDownloadDirectory();
//     //final isPermissionStatusGranted = await _requestPermissions();
//     final savePath = path.join(dir!.path, _fileName);
//     await _startDownload(savePath);
//     //   if (isPermissionStatusGranted) {

//     //   } else {
//     //     // handle the scenario when user declines the permissions
//     //   }
//     // }

//     @override
//     Widget build(BuildContext context) {
//       return Scaffold(
//         body: Center(
//           child: FloatingActionButton(
//             onPressed: () async {
//               await _download();
//             },
//             tooltip: 'Download Notification',
//             child: Icon(Icons.download_sharp),
//           ),
//         ),
//       );
//     }
//   }

//   Future<void> _showProgressNotification() async {
//     const int maxProgress = 5;
//     for (int i = 0; i <= maxProgress; i++) {
//       await Future<void>.delayed(const Duration(seconds: 1), () async {
//         final AndroidNotificationDetails androidPlatformChannelSpecifics =
//             AndroidNotificationDetails(
//                 'progress channel', 'progress channel description',
//                 channelShowBadge: false,
//                 importance: Importance.max,
//                 priority: Priority.high,
//                 onlyAlertOnce: true,
//                 showProgress: true,
//                 maxProgress: maxProgress,
//                 progress: i);
//         final NotificationDetails platformChannelSpecifics =
//             NotificationDetails(android: androidPlatformChannelSpecifics);

//         await flutterLocalNotificationsPlugin.show(
//             0,
//             'progress notification title',
//             'progress notification body',
//             platformChannelSpecifics,
//             payload: 'item x');
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     throw UnimplementedError();
//   }
// }
