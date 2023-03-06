import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:portal/models/models.dart';

Future<List<ShipmentList>> getToken(String contactId, int limit, String lastId,
    String token, String chosenValue) async {
  print("***************in the method ******************");
  print(lastId);
  String filterString;
  if (chosenValue != "null") {
    final data = {
      'status': {
        'searchText': chosenValue,
        'field': 'internals.status',
        'enabled': true
      }
    };
    filterString = jsonEncode(data);
  } else {
    filterString = "{}";
  }

  final response = await http.get(
    Uri.parse(
        'https://api.cargoez.dev/shipmentserver/api/v1/portal/shipments/paginate/$contactId/$limit/$lastId?form=$filterString'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': token,
    },
  );

  if (response.statusCode == 200) {
    dynamic responseData = json.decode(response.body);
    print(responseData);
    var data = responseData["data"];
    print(data);

    List<ShipmentList> shipList = [];
    for (int i = 0; i < limit; i++) {
      if (data.length > i) {
        shipList.add(ShipmentList(
            fileNumber: data[i]['fileNumber'],
            id: data[i]['_id'],
            status: data[i]['internals']['status']));
      } else {
        break;
      }
    }
    return shipList;
  } else {
    throw Exception('Failed to get shipments');
  }
}
