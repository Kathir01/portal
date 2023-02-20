import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:developer' as developer;

Future createAlbum(String companyid, String email, String password) async {
  final response = await http.post(
    Uri.parse('https://api.cargoez.dev/iamserver/api/v1/portal-login'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      "companyId": companyid,
      "emailId": email,
      "password": password,
    }),
  );
  // print(response);
  // print(response.statusCode);
  if (response.statusCode == 200) {
    //print(response.body);
    var map = json.decode(response.body);
    //print(response.body);
    var data = map["data"];
    var rtoken = data["refreshToken"];
    var conId = data["contactId"];
    List<String> ids = [rtoken, conId];
    print("_________________________________________________________________");
    print(conId);
    print(ids);
    return ids;
  } else {
    return "false";
    //throw Exception('Failed to create album.');
  }
}

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

  if (response.statusCode == 200) {
    var map = json.decode(response.body);
    print(response.body);
    var token = map["data"];
    print(token);
    developer.log(token);
    String fileNumber = token["fileNumber"];
    print(fileNumber);
    return fileNumber;
    // return token;
  } else {
    return false;
  }
}
