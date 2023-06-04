// ignore_for_file: file_names, camel_case_types, unused_field, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class getUserId extends StatefulWidget {
  const getUserId({super.key});

  @override
  State<getUserId> createState() => getUserIdState();
}

class getUserIdState extends State<getUserId> {
  final StorageService _storageService = StorageService();
  List<StorageItem> _items = [];
  bool _loading = true;

  String key = '';
  String value = '';

  void initList() async {
    _items = await _storageService.readAllSecureData();
    _loading = false;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    initList();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }

  void setUserID(String id) {
    key = 'driver';
    value = id;
    // saveId();
  }

  String GetUserID() {
    // initList();

    return ''; //'bb4c2670-fd7e-11ed-b7f7-eb4c5e28cea4';
  }

  Future saveId() async {
    // 1
    final StorageItem newItem = StorageItem(key, value);
    // ignore: unnecessary_null_comparison
    if (newItem != null) {
      // 2
      _storageService.writeSecureData(newItem).then((value) {
        setState(() {
          _loading = true;
        });
        // 3
        initList();
      });
    }
  }
}

class StorageService {
  final _secureStorage = const FlutterSecureStorage();

  AndroidOptions _getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
      );

  Future<void> writeSecureData(StorageItem newItem) async {
    await _secureStorage.write(key: newItem.key, value: newItem.value, aOptions: _getAndroidOptions());
  }

  Future<String?> readSecureData(String key) async {
    var readData = await _secureStorage.read(key: key, aOptions: _getAndroidOptions());
    return readData;
  }

  Future<void> deleteSecureData(StorageItem item) async {
    await _secureStorage.delete(key: item.key, aOptions: _getAndroidOptions());
  }

  Future<bool> containsKeyInSecureData(String key) async {
    var containsKey = await _secureStorage.containsKey(key: key, aOptions: _getAndroidOptions());
    return containsKey;
  }

  Future<List<StorageItem>> readAllSecureData() async {
    var allData = await _secureStorage.readAll(aOptions: _getAndroidOptions());
    List<StorageItem> list = allData.entries.map((e) => StorageItem(e.key, e.value)).toList();
    return list;
  }

  Future<void> deleteAllSecureData() async {
    await _secureStorage.deleteAll(aOptions: _getAndroidOptions());
  }
}

class StorageItem {
  StorageItem(this.key, this.value);

  final String key;
  final String value;
}
