import 'dart:convert';
import 'package:http/http.dart' as http;

Future<String> getRequest(cpy) async {
  String url = "https://api.cargoez.dev/iamserver/api/v1/companies/jio/url";
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    Map<String, dynamic> map = json.decode(response.body);
    Map<String, dynamic> data1 = map["data"];
    List<dynamic> data2 = data1["company"];
    dynamic filteredList = data2
        .singleWhere((val) => val["portal_url_id"] == cpy, orElse: () => null);
    if (filteredList != null) {
      String id = filteredList["id"];
      return id;
    } else {
      return "null";
    }
  } else {
    throw Exception('Failed to fetch data');
  }
}
