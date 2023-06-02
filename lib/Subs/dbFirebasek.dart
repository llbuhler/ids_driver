// ignore_for_file: file_names, camel_case_types

import 'package:cloud_firestore/cloud_firestore.dart';
import '../Subs/SubRoutines.dart';
//import 'package:firebase_core/firebase_core.dart';

class db {
  static Future preLogLookup(List<Map<String, dynamic>> list, String sn) async {
    list.clear();
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance.collection('Employees').where('UserSN', isEqualTo: sn).get();
    List<QueryDocumentSnapshot> docs = snapshot.docs;
    for (var doc in docs) {
      if (doc.data() != null) {
        var data = doc.data() as Map<String, dynamic>;
        list.add(data);
      }
    }
    return null;
  }

  static Future getMulii(List<Map<String, dynamic>> list) async {
    list.clear();
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance.collection('Multi').get();
    List<QueryDocumentSnapshot> docs = snapshot.docs;
    for (var doc in docs) {
      if (doc.data() != null) {
        var data = doc.data() as Map<String, dynamic>;
        list.add(data);
      }
    }
    return null;
  }

  static Future getRoutes(List<Map<String, dynamic>> list) async {
    list.clear();
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance.collection('Routes101').get();
    List<QueryDocumentSnapshot> docs = snapshot.docs;
    for (var doc in docs) {
      if (doc.data() != null) {
        var data = doc.data() as Map<String, dynamic>;
        list.add(data);
      }
    }
    return null;
  }

  static Future getEmps(List<Map<String, dynamic>> list, String email) async {
    list.clear();
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance.collection('Employees').get();
    List<QueryDocumentSnapshot> docs = snapshot.docs;
    for (var doc in docs) {
      if (doc.data() != null) {
        var data = doc.data() as Map<String, dynamic>;
        if (data['Active'] == true) {
          if (email.isEmpty) {
            list.add(data);
          } else {
            if (data['Email'] == email) {
              list.add(data);
            }
          }
        }
      }
    }
    return null;
  }

  static Future getstops(List<Map<String, dynamic>> list, String routeid, String driverid, bool all) async {
    String day = SubRoutine.getday().toString().toLowerCase();
    list.clear();
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance.collection('Stops').where(day, isEqualTo: true).orderBy('routeidx').get();
    List<QueryDocumentSnapshot> docs = snapshot.docs;
    for (var doc in docs) {
      if (doc.data() != null) {
        var data = doc.data() as Map<String, dynamic>;
        if (data['active'] && !all) {
          switch (day) {
            case 'sat':
              if (data['satdriver'] == driverid) {
                list.add(data);
              }
              break;
            case 'sun':
              if (data['sundriver'] == driverid) {
                list.add(data);
              }
              break;
            default:
              if (data['driver'] == driverid) {
                list.add(data);
              }
              break;
          }
        } else if (all) {
          list.add(data);
        }
      }
    }
    return null;
  }

  // ignore: non_constant_identifier_names
  static Future getDrivers(List<Map<String, dynamic>> list, String driver_Id) async {
    list.clear();
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance.collection('Employees').get();
    List<QueryDocumentSnapshot> docs = snapshot.docs;
    for (var doc in docs) {
      if (doc.data() != null) {
        var data = doc.data() as Map<String, dynamic>;
        if (data['Active'] == true) {
          if (driver_Id.isNotEmpty) {
            if (data['Employee_ID'] == driver_Id) {
              list.add(data);
            }
          } else {
            list.add(data);
          }
        }
      }
    }
    return null;
  }

  static Future getsettings(
    List<Map<String, dynamic>> list,
    String type,
    String id,
  ) async {
    list.clear();
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance.collection('Settings').orderBy('idx').get();
    List<QueryDocumentSnapshot> docs = snapshot.docs;
    for (var doc in docs) {
      if (doc.data() != null) {
        var data = doc.data() as Map<String, dynamic>;
        if (id.isNotEmpty) {
          if (data['recordid'] == id) {
            list.add(data);
          }
        } else if (data['type'] == type) {
          list.add(data);
        }
      }
    }
    return null;
  }

  static Future<void> dbUpdate(List<Map<String, dynamic>> lst, String table, String recID) async {
    // ignore: no_leading_underscores_for_local_identifiers
    FirebaseFirestore _db = FirebaseFirestore.instance;
    var options = SetOptions(merge: true);
    return _db.collection(table).doc(lst[0][recID]).set(lst[0], options);
  }

  static Future<void> recordDelete(List<Map<String, dynamic>> lst, String table, String recID) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    return db.collection(table).doc(lst[0][recID]).delete();
  }
}
