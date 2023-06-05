import 'dart:html';

// import 'package:universal_html/html.dart';

class LocalStorageHelper {
  static Storage localStorage = window.localStorage;

  // Save Data
  static void saveValue(String key, String value) {
    localStorage[key] = value;
  }

  // get Key / value
  static String? getValue(String key) {
    return localStorage[key];
  }

  // Remove key
  static void removeValue(String key) {
    localStorage.remove(key);
  }

  // Clear All
  static void clearAll() {
    localStorage.clear();
  }
}

class SessionStorageHelper {
  static Storage sessionStorage = window.sessionStorage;

  // Save Data
  static void saveValue(String key, String value) {
    sessionStorage[key] = value;
  }

  // get Key / value
  static String? getValue(String key) {
    return sessionStorage[key];
  }

  // Remove key
  static void removeValue(String key) {
    sessionStorage.remove(key);
  }

  // Clear All
  static void clearAll() {
    sessionStorage.clear();
  }
}





// import 'package:flutter/material.dart';
// import 'package:localstorage/localstorage.dart';

// class storage {
//   LocalStorage stor = LocalStorage('driverId');
//   void saveId(String id) {
//     stor.setItem("userId", id);
//   }

//   String getId() {
//     var rtn = stor.getItem('userId');
//     return rtn ?? '';
//   }
// }
