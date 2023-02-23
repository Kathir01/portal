import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:portal/models/models.dart';

Future getToken(
    String contactId, int limit, String lastId, String token) async {
  final response = await http.get(
    Uri.parse(
        'https://api.cargoez.dev/shipmentserver/api/v1/portal/shipments/paginate/$contactId/$limit/$lastId?form={}'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': token,
    },
  );
  print(response.request);
  List<String> fileNumber = [];
  String lastid;
  if (response.statusCode == 200) {
    dynamic responsedata = json.decode(response.body);
    var data = responsedata["data"];
    if (data.length == limit) {
      lastid = data[limit - 1]["_id"];
    } else {
      lastid = "stop";
    }
    for (int i = 0; i < limit - 1; i++) {
      if (data.length > i) {
        fileNumber.add(data[i]['fileNumber']);
      } else {
        break;
      }
    }
    return [fileNumber, lastid];
  } else {
    return false;
  }
}
