import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

class storage {
  LocalStorage stor = LocalStorage('driverId');
  void saveId(String id) {
    stor.setItem("userId", id);
  }

  String getId() {
    var rtn = stor.getItem('userId');
    return rtn ?? '';
  }
}
