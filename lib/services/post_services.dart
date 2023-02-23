import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

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
  if (response.statusCode == 200) {
    var map = json.decode(response.body);
    var data = map["data"];
    var rtoken = data["refreshToken"];
    var conId = data["contactId"];
    List<String> ids = [rtoken, conId];
    return ids;
  } else {
    return "false";
  }
}
