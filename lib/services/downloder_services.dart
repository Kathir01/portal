import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:portal/models/models.dart';

// Future<String> download(
//   String contactId,
//   String token,
// ) async {
//   final response = await http.post(
//     Uri.parse(
//         'https://api.cargoez.dev/shipmentserver/api/v1/filesystem/file/list'),
//     headers: <String, String>{
//       'Content-Type': 'application/json; charset=UTF-8',
//       'Authorization': token,
//     },
//   );

//   if (response.statusCode == 200) {
//   } else {
//     throw Exception('Failed to get shipments');
//   }
// }
