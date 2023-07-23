// ignore_for_file: file_names, unrelated_type_equality_checks
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class SubRoutine {
  static bool test = false;
  static String testDay = 'Mon';

  static date2string(DateTime dt) {
    String rtn = dt.year.toString();
    if (dt.month < 10) {
      rtn += '0${dt.month}';
    } else {
      rtn += dt.month.toString();
    }
    if (dt.day < 10) {
      rtn += '0${dt.day}';
    } else {
      rtn += dt.day.toString();
    }
    return rtn;
  }

  static String getday() {
    // ignore: unused_local_variable
    String rtn = '';
    DateTime dt = DateTime.now();
    switch (dt.weekday) {
      case 1:
        rtn = 'Mon';
        break;
      case 2:
        rtn = 'Tue';
        break;
      case 3:
        rtn = 'Wed';
        break;
      case 4:
        rtn = 'Thr';
        break;
      case 5:
        rtn = 'Fri';
        break;
      case 6:
        rtn = 'Sat';
        break;
      case 7:
        rtn = 'Sun';
        break;
    }
    return test ? testDay : rtn;
  }

  static String convertSeconds({required int q, required bool seconds}) {
    String s = '';
    int t = q;
    int x = 0;
    int hours = 0;
    int min = 0;
    if (t > 3600) {
      x = t ~/ 3600;
      if (x > 0) {
        t -= x * 3600;
        hours = x;
      }
      if (hours < 10) {
        s += ' ${hours.toInt()}:';
      } else {
        s += '${hours.toInt()}:';
      }
    } else {
      s = '0:';
    }
    if (t > 60) {
      x = t ~/ 60;
      if (x > 0) {
        t -= x * 60;
        min = x;
      }
      if (min == 0) {
        s += '00';
      } else {
        if (min < 10) {
          s += '0${min.toInt()}';
        } else {
          s += min.toInt().toString();
        }
      }
    } else {
      s += '00';
    }
    // ignore: curly_braces_in_flow_control_structures
    if (seconds) if (t < 10) {
      s += ':0${t.toInt()}';
    } else {
      s += ':${t.toInt()}';
    }
    s += ' ';

    // if (s == '00:') {
    //   s = '0:0';
    // }
    return s;
  }

  static String? prettyTime(String q) {
    int x = -1;
    String t = q;
    String rtn = '';
    if (t == '09:27') {
      t = t;
    }
    if (t.isNotEmpty) {
      x = t.indexOf(':');
      switch (x) {
        case 1:
          rtn = '0${t.substring(0, 1)}:';
          t = t.substring(x + 1);
          break;
        case 2:
          rtn = '${t.substring(0, 2)}:';
          t = t.substring(x + 1);
          break;
      }
    }
    if (t.isNotEmpty) {
      x = t.indexOf(':');
      switch (x) {
        case -1:
          if (t.length == 1) {
            rtn += '0$t';
            t = '';
          } else {
            rtn += t;
            t = '';
          }
          break;
        case 1:
          rtn += '0${t.substring(0, 1)}:';
          t = t.substring(x + 1);
          break;
        case 2:
          rtn += '${t.substring(0, 2)}:';
          t = t.substring(x + 1);
          break;
      }
    }
    if (t.isNotEmpty) {
      x = t.indexOf(':');
      switch (x) {
        case -1:
          if (t.length == 1) {
            rtn += '0$t';
          } else {
            rtn += t;
          }
          break;
        default:
          rtn += '00';
          break;
      }
    }
    return rtn;
  }

  static String clipTime(String s, bool seconds) {
    String rtn = ' ';
    switch (s.length) {
      case 5:
        rtn = s;
        break;
      case 8:
        if (seconds) {
          rtn = s;
        } else {
          rtn = s.substring(0, 5);
        }
        break;
    }
    return rtn;
  }

  // static String toTime(DateTime dt) {
  //   String ampm = '';
  //   String min;
  //   String sec;
  //   String hour;
  //   int tmp = dt.hour;
  //   // if (!Constants.hour24) {
  //   //   if (tmp > 12) {
  //   //     tmp -= 12;
  //   //     ampm = ' PM';
  //   //   } else {
  //   //     ampm = ' AM';
  //   //   }
  //   // }
  //   hour = tmp.toString() + ':';
  //   if (dt.minute < 10) {
  //     min = '0' + dt.minute.toString() + ':';
  //   } else {
  //     min = dt.minute.toString() + ':';
  //   }
  //   if (dt.second < 10) {
  //     sec = '0' + dt.second.toString() + ':';
  //   } else {
  //     sec = dt.second.toString() + ':';
  //   }
  //   // return Constants.hour24 ? hour + min + sec : hour + min + ampm;
  // }

  // static void clockOut() {
  //   Constants.clockedin = false;
  //   // update database
  // }

  // static String elapsedTime(int t) {
  //   String rtn = "";
  //   int hour;
  //   int mins;
  //   int secs;
  //   hour = t ~/ 3600;
  //   t -= hour * 3600;
  //   mins = t ~/ 60;
  //   t -= mins * 60;
  //   secs = t;
  //   if (!Constants.tenthhour) {
  //     rtn = hour.toString() + ':' + mkpretty(mins.toString()) + ':' + mkpretty(secs.toString());
  //   } else {
  //     rtn = hour.toString() + ':' + mkpretty(mins.toString()) + '.' + (secs / 6).truncate().toString();
  //   }
  //   return rtn;
  // }

  static String mkpretty(String s) {
    String year;
    String month;
    String day;
    if (s.length > 5) {
      year = s.substring(0, 4);
      month = s.substring(s.indexOf('-') + 1, s.lastIndexOf('-'));
      day = s.substring(s.lastIndexOf('-') + 1);
      s = '$year-';
      if (month.length == 1) {
        s += '0$month-';
      } else {
        s += '$month-';
      }
      if (day.length == 1) {
        s += '0$day';
      } else {
        s += day;
      }
    }
    String rtn = s;
    if (s.length == 1) {
      rtn = '0$s';
    }
    return rtn;
  }

  static String getDate(DateTime dt) {
    String rt = "";
    int month = dt.month;
    int day = dt.day;
    int year = dt.year;
    rt = '$year-';
    if (month < 10) {
      rt += '0$month-';
    } else {
      rt += '$month-';
    }
    if (day < 10) {
      rt += '0';
    }
    rt += day.toString();
    return rt;
  }

  static String getTime(DateTime dt, bool h12, bool seconds) {
    String rt = "";
    bool am = true;
    int hour = dt.hour;
    int min = dt.minute;
    int sec = dt.second;
    if (hour > 12) {
      if (h12) {
        hour -= 12;
        am = false;
      }
    }
    rt = '$hour:';
    if (min < 10) {
      rt += '0';
    }
    rt += min.toString();
    if (seconds) {
      if (sec < 10) {
        rt += ':0';
      }
      rt += ':$sec';
    }
    if (h12) {
      rt += am ? ' AM' : ' PM';
    }
    return rt;
  }

  static String date2String(DateTime dt) {
    String s = '';
    s = '${dt.year}-';
    if (dt.month < 10) {
      s += '0${dt.month}-';
    } else {
      s += '${dt.month}:';
    }
    if (dt.day < 10) {
      s += '0${dt.day}';
    } else {
      s += dt.day.toString();
    }
    // if (dt.hour < 10) {
    //   s += '0' + dt.hour.toString();
    // } else {
    //   s += dt.hour.toString();
    // }
    // if (dt.minute < 10) {
    //   s += ':0' + dt.minute.toString();
    // } else {
    //   s += ':' + dt.minute.toString();
    // }
    return s;
  }

  static Size calcTextSize(String text, TextStyle style) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: TextDirection.ltr,
      textScaleFactor: WidgetsBinding.instance.window.textScaleFactor,
    )..layout();
    return textPainter.size;
  }

  static double getFontSize(double size, TextEditingController tec, double maxSize) {
    double rtn = 25;
    if (maxSize != 0) {
      rtn = maxSize;
    }
    if (tec != '') {
      var stringsize = calcTextSize(tec.text, TextStyle(fontSize: rtn));
      while (stringsize.width > size) {
        rtn -= 0.05;
        stringsize = calcTextSize(tec.text, TextStyle(fontSize: rtn));
      }
    }
    return rtn;
  }

  static double getFontSizeString(double size, String tec) {
    double rtn = 25.0;
    if (tec != '') {
      var stringsize = calcTextSize(tec, TextStyle(fontSize: rtn));
      while (stringsize.width > size) {
        rtn -= 0.05;
        stringsize = calcTextSize(tec, TextStyle(fontSize: rtn));
      }
    }
    return rtn;
  }

  static double getFontSizeLength(double size, double len) {
    String s = '';
    for (int x = 0; x < len; x++) {
      if (x < 2) {
        s += 'A';
      } else {
        s += 'a';
      }
    }
    double rtn = 25.0;
    if (size != 0) {
      rtn = size;
    }
    if (len != '') {
      var stringsize = calcTextSize(s, TextStyle(fontSize: rtn));
      while (stringsize.width > size) {
        rtn -= 0.05;
        stringsize = calcTextSize(s, TextStyle(fontSize: rtn));
      }
    }
    return rtn;
  }

  static String getCurrentPeriod() {
    DateTime dt = DateTime.now();
    dt = dt.add(Duration(days: (dt.weekday - 1) * -1));
    return SubRoutine.getDate(dt);
  }

  static prettyphone(String p, bool old) {
    String s = p.replaceAll('-', '');
    s = s.replaceAll('(', '');
    s = s.replaceAll(')', '');
    s = s.replaceAll(' ', '');
    if (s.length == 10) {
      if (old) {
        s = '(${s.substring(0, 3)}) ${s.substring(3, 6)}-${s.substring(6)}';
      } else {
        s = '${s.substring(0, 3)}-${s.substring(3, 6)}-${s.substring(6)}';
      }
      return s;
    } else {
      return p;
    }
  }

  static String time2String(TimeOfDay t) {
    String rtn = '';
    if (t.hour < 10) {
      rtn = '0${t.hour}:';
    } else {
      rtn = '${t.hour}:';
    }
    if (t.minute < 10) {
      rtn += '0${t.minute}';
    } else {
      rtn += t.minute.toString();
    }
    return rtn;
  }
}
