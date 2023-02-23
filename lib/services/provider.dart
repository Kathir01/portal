import 'package:flutter/material.dart';

class shipments extends ChangeNotifier {
  String token = '';
  String id = '';
  void refreshtoken(String newRefreshToken) {
    token = newRefreshToken;
  }

  void contactid(String newcontactid) {
    id = newcontactid;
  }
}
