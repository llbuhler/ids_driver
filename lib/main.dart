// ignore_for_file: unrelated_type_equality_checks, library_private_types_in_public_api, non_constant_identifier_names, prefer_typing_uninitialized_variables, use_key_in_widget_constructors, unused_local_variable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:ids_driver/Screens/Fyi/Training.dart';
import 'package:ids_driver/Screens/MyRoute.dart';
import 'package:ids_driver/Subs/SubRoutines.dart';
import 'package:ids_driver/variables.dart';
import 'package:intl/intl.dart';

import 'Screens/profile.dart';
import 'Subs/SizeConfig.dart';
import 'Subs/localColors.dart';
import 'Subs/dbFirebasek.dart';

int Test = 0;

loadTable() {
  variables.tableMySettings.add({
    'recordid': '',
    'idx': 0,
    'seconds': false,
    'autoupdate': false,
    'updatedelay': 5,
    'picture': false,
    'messages': false,
    'loadboard': false,
    'test': true,
  });
}

TextEditingController logEmail = TextEditingController();
TextEditingController logPass = TextEditingController();

bool kDebugMode = true;

main() async {
  WidgetsFlutterBinding.ensureInitialized();
//  cameras = await availableCameras();
//  final firstCamera = cameras.first;
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyCEOZ9vg6tGa6bKmV-VCt0ZwiPjY8_g894",
          authDomain: "ids-5-80a20.firebaseapp.com",
          databaseURL: "https://ids-5-80a20-default-rtdb.firebaseio.com",
          projectId: "ids-5-80a20",
          storageBucket: "ids-5-80a20.appspot.com",
          messagingSenderId: "442532211592",
          appId: "1:442532211592:web:b8b0d3f4c812801f3e283d"));
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'IDS Web interface',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  FirebaseAuth auth = FirebaseAuth.instance;
  DateFormat dateformat = DateFormat('EEEE MM/dd      hh:mm');
  //final _newStopState ss = _newStopState();
  TextEditingController logEmail = TextEditingController();
  TextEditingController logPass = TextEditingController();
  bool passError = false;
  bool emailError = false;
  bool isVerified = false;
  int ticks = 0;
  bool authorized = true;

  String mtoken = '';
  String title = '';
  String body = '';

  void emailVerify() {
    if (logEmail.text.isEmpty) {
      emailError = false;
    } else {
      // ignore: prefer_contains
      if (logEmail.text.toString().indexOf('@') != -1) {
        emailError = false;
      } else {
        emailError = true;
      }
    }
    if (logEmail.text.isNotEmpty && logPass.text.length == 4 && !emailError & !passError) {
      isVerified = true;
    }
  }

  void passVerify() {
    if (logPass.text.isEmpty || logPass.text.length == 4) {
      passError = false;
    } else {
      passError = true;
    }
    if (logEmail.text.isNotEmpty && logPass.text.length == 4 && !emailError & !passError) {
      isVerified = true;
    }
  }

  @override
  void dispose() {
    super.dispose();
    logEmail.dispose();
    logPass.dispose();
  }

  void doSomthing(String cmd) {}

  VoidCallback? updateMe() {
    setState(() {});
    return null;
  }

  @override
  void initState() {
    super.initState();
    loadTable();
    if (Test == 1) {
      logEmail.text = 'larry.buhler9290@gmail.com';
      logPass.text = '1489';
      passVerify();
    } else if (Test == 2) {
      logEmail.text = 'smoder78@gmail.com';
      logPass.text = '1234';
      passVerify();
    }
    getPermission();
    getToken();
    messageListener(context);
  }

  Future<void> getPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }

  void getToken() async {
    await FirebaseMessaging.instance.getToken().then((token) {
      setState(() {
        mtoken = token.toString();
        if (kDebugMode) {}
      });
    });
  }

  void UpdateTokens() async {
    List<Map<String, dynamic>> lst = [];
    lst.add({
      'recordid': variables.tablecurrentEmployee[0]['Employee_ID'],
      'token': mtoken,
      'date': SubRoutine.getDate(DateTime.now()),
      'time': SubRoutine.getTime(DateTime.now(), false, true),
      'ddu': isDDU().toString() == 'true' ? 'true' : 'false',
      'sent': 'false',
    });
    await db.dbUpdate(lst, 'Tokens', 'recordid');
  }

  bool isDDU() {
    bool rtn = false;
    for (var x in variables.tableStops) {
      if (x['type'] == 'DDU') {
        rtn = true;
      }
    }
    return rtn;
  }

  void messageListener(BuildContext context) {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (kDebugMode) {}
      if (message.notification != null) {
        if (kDebugMode) {}
        showDialog(
            context: context,
            builder: ((BuildContext context) {
              return DynamicDialog(title: message.notification!.title, body: message.notification!.body);
            }));
      }
    });
  }

  DateTime dt = DateTime.now();
  bool validated = false;
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Material(
        child: SizedBox(
      height: SizeConfig.screenHeight,
      width: SizeConfig.screenWidth,
      child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        Container(
            height: 50,
            width: SizeConfig.screenWidth,
            color: Color(Clrs.blue),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'IDS Drivers App',
                  style: TextStyle(fontSize: 30, color: Color(Clrs.white)),
                ),
              ],
            )),
        variables.isLoggedin
            ? Expanded(
                child: ListView(children: [
                Padding(
                  padding: const EdgeInsets.only(top: 30, left: 15, right: 15),
                  child: SizedBox(
                    height: 50,
                    width: SizeConfig.screenWidth - 30,
                    child: ElevatedButton(
                      onPressed: () async {
                        //await db.getMulii(variables.tableMulti);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MyRoute(),
                            ));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(Clrs.blue),
                        foregroundColor: Color(Clrs.white),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          side: BorderSide(color: Color(Clrs.dkblue), width: 2.0),
                        ),
                      ),
                      child: const Text(
                        'My Route',
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30, left: 15, right: 15),
                  child: SizedBox(
                    height: 50,
                    width: SizeConfig.screenWidth - 30,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Profile(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(Clrs.blue),
                        foregroundColor: Color(Clrs.white),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          side: BorderSide(color: Color(Clrs.dkblue), width: 2.0),
                        ),
                      ),
                      child: const Text(
                        'Profile',
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                  ),
                ),
                // variables.tableMySettings[0]['messages']
                //     ? Padding(
                //         padding: const EdgeInsets.only(top: 30, left: 15, right: 15),
                //         child: SizedBox(
                //           height: 50,
                //           width: SizeConfig.screenWidth - 30,
                //           child: ElevatedButton(
                //             onPressed: () {},
                //             style: ElevatedButton.styleFrom(
                //               backgroundColor: Color(Clrs.blue),
                //               foregroundColor: Color(Clrs.white),
                //               shape: RoundedRectangleBorder(
                //                 borderRadius: BorderRadius.circular(20.0),
                //                 side: BorderSide(color: Color(Clrs.dkblue), width: 2.0),
                //               ),
                //             ),
                //             child: const Text(
                //               'Messages',
                //               style: TextStyle(fontSize: 30),
                //             ),
                //           ),
                //         ),
                //       )
                //     : const SizedBox.shrink(),
                Padding(
                  padding: const EdgeInsets.only(top: 30, left: 15, right: 15),
                  child: SizedBox(
                    height: 50,
                    width: SizeConfig.screenWidth - 30,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const training(),
                            ));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(Clrs.blue),
                        foregroundColor: Color(Clrs.white),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          side: BorderSide(color: Color(Clrs.dkblue), width: 2.0),
                        ),
                      ),
                      child: const Text(
                        'FYI / Training',
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                  ),
                ),
                // variables.tableMySettings[0]['loadboard']
                //     ? Padding(
                //         padding: const EdgeInsets.only(top: 30, left: 15, right: 15),
                //         child: SizedBox(
                //           height: 50,
                //           width: SizeConfig.screenWidth - 30,
                //           child: ElevatedButton(
                //             onPressed: () {},
                //             style: ElevatedButton.styleFrom(
                //               backgroundColor: Color(Clrs.blue),
                //               foregroundColor: Color(Clrs.taco),
                //               shape: RoundedRectangleBorder(
                //                 borderRadius: BorderRadius.circular(20.0),
                //                 side: BorderSide(color: Color(Clrs.dkblue), width: 2.0),
                //               ),
                //             ),
                //             child: const Text(
                //               'Load Board',
                //               style: TextStyle(fontSize: 30),
                //             ),
                //           ),
                //         ),
                //       )
                //     : const SizedBox.shrink(),
                Padding(
                  padding: const EdgeInsets.only(top: 70, left: 15, right: 15),
                  child: SizedBox(
                    height: 50,
                    width: SizeConfig.screenWidth - 30,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          variables.isLoggedin = false;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(Clrs.blue),
                        foregroundColor: Color(Clrs.taco),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          side: BorderSide(color: Color(Clrs.dkblue), width: 2.0),
                        ),
                      ),
                      child: const Text(
                        'Log Out',
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                  ),
                ),
                // variables.tablecurrentEmployee[0]['Clearance'] == 'Admin'
                //     ? Padding(
                //         padding: const EdgeInsets.only(top: 30, left: 15, right: 15),
                //         child: SizedBox(
                //           height: 50,
                //           width: SizeConfig.screenWidth - 30,
                //           child: ElevatedButton(
                //             onPressed: () {
                //               Navigator.push(
                //                   context,
                //                   MaterialPageRoute(
                //                     builder: (context) => const Settings(),
                //                   ));
                //             },
                //             style: ElevatedButton.styleFrom(
                //               backgroundColor: Color(Clrs.blue),
                //               foregroundColor: Color(Clrs.taco),
                //               shape: RoundedRectangleBorder(
                //                 borderRadius: BorderRadius.circular(20.0),
                //                 side: BorderSide(color: Color(Clrs.dkblue), width: 2.0),
                //               ),
                //             ),
                //             child: const Text(
                //               'Settings',
                //               style: TextStyle(fontSize: 30),
                //             ),
                //           ),
                //         ),
                //       )
                //     : const SizedBox.shrink(),
                SizedBox(height: 400, width: SizeConfig.screenWidth),
              ]))
            : Column(children: [
                Container(
                  height: 30,
                  width: SizeConfig.screenWidth,
                  decoration: BoxDecoration(border: Border.all(color: Color(Clrs.blue), width: 2.0)),
                  child: Column(mainAxisAlignment: MainAxisAlignment.center, children: const [
                    Text(
                      'Log In',
                      style: TextStyle(fontSize: 18),
                    ),
                  ]),
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: Container(
                      height: 300,
                      width: SizeConfig.screenWidth - 30,
                      decoration: BoxDecoration(
                        color: Color(Clrs.ltblue),
                        borderRadius: BorderRadius.circular(15.0),
                        border: Border.all(color: Color(Clrs.dkblue), width: 2.0),
                      ),
                      child: Padding(
                          padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                            TextFormField(
                              controller: logEmail,
                              decoration: InputDecoration(
                                labelText: 'Email',
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(width: 2.0, color: Color(emailError ? Clrs.red : Clrs.dkblue))),
                                errorBorder:
                                    OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(width: 2.0, color: Color(Clrs.red))),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(width: 2.0, color: Color(emailError ? Clrs.red : Clrs.green))),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  emailVerify();
                                });
                              },
                            ),
                            Padding(
                                padding: const EdgeInsets.only(top: 30),
                                child: TextFormField(
                                  controller: logPass,
                                  decoration: InputDecoration(
                                    labelText: 'Passcode',
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                                        borderSide: BorderSide(width: 2.0, color: Color(passError ? Clrs.red : Clrs.dkblue))),
                                    errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(width: 2.0, color: Color(Clrs.red))),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                                        borderSide: BorderSide(width: 2.0, color: Color(passError ? Clrs.red : Clrs.green))),
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      passVerify();
                                    });
                                  },
                                )),
                            Padding(
                              padding: const EdgeInsets.only(top: 50),
                              child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                                SizedBox(
                                    height: 60,
                                    width: 150,
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        try {
                                          UserCredential userCredential =
                                              await FirebaseAuth.instance.signInWithEmailAndPassword(email: logEmail.text, password: '93${logPass.text}');
                                          variables.isLoggedin = true;
                                        } catch (e) {
                                          setState(() {
                                            emailError = false;
                                            passError = false;
                                            if (e.toString().indexOf('user-not-found') > 0) {
                                              emailError = true;
                                            }
                                            if (e.toString().indexOf('password is invalid') > 0) {
                                              passError = true;
                                            }
                                          });
                                          variables.isLoggedin = false;
                                        }
                                        variables.isLoggedin ? await getAllTables() : const SizedBox.shrink();
                                        //UpdateTokens();
                                        // variables.tablecurrentEmployee.clear();
                                        // int i = 0;
                                        // for (i = 0; i < variables.tableEmps.length; i++) {
                                        //   if (variables.tableEmps[i]['Email]'].toString() == logEmail.text.toString()) {
                                        //     variables.tablecurrentEmployee.add(variables.tableEmps[i]);
                                        //   }
                                        // }
                                        setState(() {});
                                      },
                                      style: ElevatedButton.styleFrom(
                                        foregroundColor: Color(Clrs.black),
                                        backgroundColor: Color(isVerified ? Clrs.green : Clrs.grey),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(20.0),
                                          side: BorderSide(color: Color(Clrs.dkblue), width: 2.0),
                                        ),
                                      ),
                                      child: Text(
                                        'Login',
                                        style: TextStyle(
                                          fontSize: 30,
                                          color: Color(Clrs.black),
                                        ),
                                      ),
                                    )),
                              ]),
                            ),
                          ])),
                    )),
              ]),
      ]),
    ));
  }

  Future getAllTables() async {
    await db.getEmps(variables.tablecurrentEmployee, logEmail.text);
    await db.getEmps(variables.tableEmps, '');
    await db.getRoutes(variables.tableRoute);
    await db.getDrivers(variables.tableDrivers, '');
    await db.getstops(variables.tableStops, '', variables.tablecurrentEmployee[0]['Employee_ID'], false);
    await db.getsettings(variables.tableMySettings, '', variables.tablecurrentEmployee[0]['Employee_ID']);
    await db.getMulii(variables.tableMulti);
  }
}

class DynamicDialog extends StatefulWidget {
  final title;
  final body;
  const DynamicDialog({this.title, this.body});
  @override
  _DynamicDialogState createState() => _DynamicDialogState();
}

class _DynamicDialogState extends State<DynamicDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      actions: <Widget>[
        OutlinedButton.icon(
            label: const Text('Close'),
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.close))
      ],
      content: Text(widget.body),
    );
  }
}
