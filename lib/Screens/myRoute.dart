import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:ids_driver/Subs/SizeConfig.dart';
import 'package:ids_driver/Subs/SubRoutines.dart';
import 'package:ids_driver/variables.dart';
import 'package:ids_driver/Subs/dbFirebasek.dart';
import '../Subs/localColors.dart';
import 'DeliveryArray.dart';

bool updateOk = false;

class MyRoute extends StatefulWidget {
  const MyRoute({super.key});

  @override
  State<MyRoute> createState() => MyRouteState();
}

class MyRouteState extends State<MyRoute> {
  VoidCallback? upDateMe() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SizedBox(
        height: SizeConfig.screenHeight,
        width: SizeConfig.screenWidth,
        child: Column(children: [
          Row(children: [
            Container(
              height: 50,
              width: 50,
              color: Color(Clrs.blue),
            ),
            Container(
                height: 50,
                width: SizeConfig.screenWidth - 100,
                color: Color(Clrs.blue),
                child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(
                    'IDS Drivers App',
                    style: TextStyle(fontSize: 30, color: Color(Clrs.white)),
                  )
                ])),
            Container(
                height: 50,
                width: 50,
                color: Color(Clrs.blue),
                child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.menu,
                      size: 30,
                      color: Color(Clrs.white),
                    ))),
          ]),
          Container(
            height: 30,
            width: SizeConfig.screenWidth,
            decoration: BoxDecoration(border: Border.all(color: Color(Clrs.blue), width: 2.0)),
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: const [
              Text(
                'My Route',
                style: TextStyle(fontSize: 18),
              ),
            ]),
          ),
          Expanded(
              child: ListView.builder(
            itemCount: variables.tableStops.length,
            itemBuilder: (context, index) {
              return StopItem(index, upDateMe);
            },
          ))
        ]),
      ),
    );
  }
}

class StopItem extends StatefulWidget {
  const StopItem(this.idx, this.isVerified(), {super.key});
  final int idx;
  final VoidCallback isVerified;

  @override
  State<StopItem> createState() => StopItemState();
}

class StopItemState extends State<StopItem> {
  bool expand = false;

  VoidCallback? isVerified() {
    setState(() {});
  }

  List<Map<String, dynamic>> del = [];

  TextEditingController tnote = TextEditingController();

  // int pallets = 0;
  // int boxes = 0;
  // int bags = 0;
  // int tubs = 0;

  bool pending = true;
  bool pickedup = false;
  bool pictureEnabled = false;
  bool picture = false;
  int pictureIdx = 0;
  // String image1 = '';
  String image2 = '';

  bool delivered = false;
  bool skipped = false;
  bool submit = false;

  List<Map<String, dynamic>> multi = [];

  int stopCount = 2;

  @override
  Widget build(BuildContext context) {
    // if (del.isEmpty) {
    //   del.add({
    //     'recordid': '',
    //     'deliverydate': '',
    //     'statustime': '',
    //     'status': '',
    //     'pallets': 0,
    //     'boxes': 0,
    //     'bags': 0,
    //     'tubs': 0,
    //     'dirty': false,
    //   });
    // }

    Future getMainCompany(int idx) async {
      await db.getMulii(multi);
      String _time = SubRoutine.getTime(DateTime.now(), false, true);
      String _date = SubRoutine.getDate(DateTime.now());
      variables.myStops.clear();
      variables.myStops.add({
        'recordid': variables.tableStops[idx]['recordid'],
        'company': variables.tableStops[idx]['company'],
        'deliverydriver': variables.tableStops[idx]['driver'],
        'deliverydate': _date,
        'statustime': _time,
        'status': variables.tableStops[idx]['status'],
        'pallets': 0,
        'boxes': 0,
        'bags': 0,
        'tubs': 0,
        'request': '',
      });
      for (var e in multi) {
        if (e['parent'] == variables.myStops[0]['recordid']) {
          variables.myStops.add({
            'recordid': e['recordid'],
            'company': e['company'],
            'deliverydriver': variables.tableStops[widget.idx]['driver'],
            'deliverydate': _date,
            'statustime': _time,
            'status': 'Picked Up',
            'pallets': 0,
            'boxes': 0,
            'bags': 0,
            'tubs': 0,
            'request': '',
          });
        }
      }
    }

    return Material(
        child: Padding(
            padding: EdgeInsets.only(
                left: variables.tableStops[widget.idx]['status'] == 'Pending' ? 0 : 20,
                top: 30,
                right: variables.tableStops[widget.idx]['status'] == 'Pending' ? 20 : 0),
            child: Container(
              height: expand
                  ? 444 + 153 * variables.myStops.length.toDouble()
                  : variables.tableStops[widget.idx]['status'] == 'Pending'
                      ? 124
                      : 104,
              width: SizeConfig.screenWidth - 36,
              decoration: BoxDecoration(
                color: getBackColor(widget.idx),
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(variables.tableStops[widget.idx]['status'] == 'Pending' ? 20 : 0),
                  topRight: Radius.circular(variables.tableStops[widget.idx]['status'] == 'Pending' ? 20 : 0),
                  bottomLeft: Radius.circular(variables.tableStops[widget.idx]['status'] != 'Pending' ? 20 : 0),
                  topLeft: Radius.circular(variables.tableStops[widget.idx]['status'] != 'Pending' ? 20 : 0.0),
                ),
                border: Border.all(color: Color(Clrs.blue), width: 2.0),
              ),
              child: Column(children: [
                InkWell(
                  onTap: (() async {
                    await getMainCompany(widget.idx);
                    expand = true;
                    setState(() {});
                  }),
                  child:
                      //child: Column(children: [
                      Container(
                    height: variables.tableStops[widget.idx]['status'] == 'Pending' ? 100 : 80,
                    width: SizeConfig.screenWidth,
                    child: Row(children: [
                      Container(
                        height: variables.tableStops[widget.idx]['status'] == 'Pending' ? 100 : 80,
                        width: 120,
                        // color: Color(Clrs.ltgreen),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 0),
                          child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.center, children: [
                            //  Text(Stops[widget.idx]['status'], style: TextStyle(fontSize: 20, color: getForeColor(widget.idx))),
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(variables.tableStops[widget.idx]['type'], style: TextStyle(fontSize: 25, color: getForeColor(widget.idx))),
                            ),
                            variables.tableStops[widget.idx]['status'] == 'Pending'
                                ? Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(variables.tableStops[widget.idx]['start'] + '-' + variables.tableStops[widget.idx]['end'],
                                          style: TextStyle(color: getForeColor(widget.idx))),
                                    ))
                                : const SizedBox.shrink(),
                          ]),
                        ),
                      ),
                      Container(
                        height: variables.tableStops[widget.idx]['status'] == 'Pending' ? 100 : 80,
                        width: SizeConfig.screenWidth - 144,
                        child: Column(children: [
                          Container(
                              height: 32,
                              width: SizeConfig.screenWidth - 120,
                              child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, children: [
                                FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      variables.tableStops[widget.idx]['company'],
                                      style: TextStyle(fontSize: 20, color: getForeColor(widget.idx)),
                                      textAlign: TextAlign.start,
                                    ))
                              ])),
                          Container(
                              height: 32,
                              width: SizeConfig.screenWidth - 120,
                              child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, children: [
                                FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      variables.tableStops[widget.idx]['status'] == 'Pending'
                                          ? variables.tableStops[widget.idx]['street']
                                          : variables.tableStops[widget.idx]['status'] + '   ' + configureTime(variables.tableStops[widget.idx]['statustime']),
                                      style: TextStyle(
                                          fontSize: 20,
                                          color:
                                              variables.tableStops[widget.idx]['status'] == 'Pending' ? getForeColor(widget.idx) : getstatusColor(widget.idx)),
                                      textAlign: TextAlign.start,
                                    ))
                              ])),
                          variables.tableStops[widget.idx]['status'] == 'Pending'
                              ? Container(
                                  height: 32,
                                  width: SizeConfig.screenWidth - 120,
                                  child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, children: [
                                    FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: Text(
                                          variables.tableStops[widget.idx]['city'] +
                                              ', ' +
                                              variables.tableStops[widget.idx]['state'] +
                                              '  ' +
                                              variables.tableStops[widget.idx]['zipcode'],
                                          style: TextStyle(fontSize: 20, color: getForeColor(widget.idx)),
                                          textAlign: TextAlign.start,
                                        ))
                                  ]))
                              : const SizedBox.shrink(),
                        ]),
                      ),
                    ]),
                  ),
                ),
                expand
                    ? Container(
                        height: 340 + (135 * variables.myStops.length.toDouble()), //120
                        width: SizeConfig.screenWidth - 40,
                        //color: Colors.amber[100],
                        child: Column(children: [
                          Container(
                              height: 60,
                              width: SizeConfig.screenWidth - 40,
                              color: Color(Clrs.transparent),
                              child: variables.tableStops[widget.idx]['type'] != 'DDU'
                                  ? Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                                      SizedBox(
                                          height: 50,
                                          width: (SizeConfig.screenWidth - 45) / 3,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              setState(() {
                                                pickedup = false;
                                                pending = true;
                                                picture = false;
                                              });
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Color(pending ? Clrs.green : Clrs.ltgray),
                                              foregroundColor: Color(Clrs.black),
                                            ),
                                            child: const Text('Pending', style: TextStyle(fontSize: 15)),
                                          )),
                                      SizedBox(
                                        height: 50,
                                        width: (SizeConfig.screenWidth - 45) / 3,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            setState(() {
                                              pickedup = true;
                                              pending = false;
                                              updateOk = true;
                                              picture = false;
                                            });
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Color(pickedup ? Clrs.green : Clrs.ltgray),
                                            foregroundColor: Color(Clrs.black),
                                          ),
                                          child: const Text('Picked Up', style: TextStyle(fontSize: 15)),
                                        ),
                                      ),
                                    ])
                                  : Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                                      SizedBox(
                                          height: 50,
                                          width: (SizeConfig.screenWidth - 45) / 3,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              setState(() {
                                                pending = true;
                                                delivered = false;
                                                skipped = false;
                                                picture = false;
                                              });
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Color(pending ? Clrs.green : Clrs.ltgray),
                                              foregroundColor: Color(Clrs.black),
                                            ),
                                            child: const Text('Pending', style: TextStyle(fontSize: 15)),
                                          )),
                                      // mySettings[0]['picture']
                                      //     ? SizedBox(
                                      //         height: 50,
                                      //         width: (SizeConfig.screenWidth - 45) / 3,
                                      //         child: ElevatedButton(
                                      //           onPressed: () {
                                      //             setState(() {
                                      //               pending = true;
                                      //               delivered = false;
                                      //               picture = true;
                                      //             });
                                      //             Navigator.push(
                                      //                 context, MaterialPageRoute(builder: (context) => CameraApp())); //TakePictureScreen(camera: cameras[0])));
                                      //           },
                                      //           style: ElevatedButton.styleFrom(
                                      //             backgroundColor: Color(picture ? Clrs.green : Clrs.ltgray),
                                      //             foregroundColor: Color(Clrs.black),
                                      //           ),
                                      //           child: const Text('Pictures', style: TextStyle(fontSize: 15)),
                                      //         ))
                                      //     : const SizedBox.shrink(),
                                      SizedBox(
                                          height: 50,
                                          width: (SizeConfig.screenWidth - 45) / 3,
                                          child: ElevatedButton(
                                            onPressed: () async {
                                              setState(() {
                                                pending = false;
                                                delivered = true;
                                                picture = false;
                                                updateOk = true;
                                              });
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Color(delivered ? Clrs.green : Clrs.ltgray),
                                              foregroundColor: Color(Clrs.black),
                                            ),
                                            child: const Text('Delivered', style: TextStyle(fontSize: 15)),
                                          )),
                                    ])),
                          variables.tableStops[widget.idx]['type'] == 'DDU'
                              ? Container(
                                  height: 60,
                                  width: SizeConfig.screenWidth - 100,
                                  child: Column(mainAxisAlignment: MainAxisAlignment.center, children: const [
                                    Text(
                                      'Don\'t forget returns',
                                      style: TextStyle(fontSize: 25),
                                      textAlign: TextAlign.center,
                                    )
                                  ]),
                                )
                              : const SizedBox.shrink(),
                          // images.isNotEmpty
                          //     ? Container(
                          //         height: 250,
                          //         width: SizeConfig.screenWidth - 40,
                          //         color: Color(Clrs.blue),
                          //         //  child: Image.file(images[0]),
                          //       )
                          //     : const SizedBox(height: 20),
                          variables.tableStops[widget.idx]['type'] != 'DDU'
                              ? Container(
                                  height: 155 * variables.myStops.length.toDouble(),
                                  width: SizeConfig.screenWidth - 40,
                                  //color: Colors.amber[300],
                                  child: Column(children: [
                                    variables.tableStops[widget.idx]['type'] != 'DDU'
                                        ? DeliveryArray(0, variables.myStops.length, isVerified())
                                        : const SizedBox.shrink(),
                                    variables.myStops.length >= 2 && variables.tableStops[widget.idx]['type'] != 'DDU'
                                        ? DeliveryArray(1, variables.myStops.length, isVerified())
                                        : const SizedBox.shrink(),
                                    variables.myStops.length >= 3 && variables.tableStops[widget.idx]['type'] != 'DDU'
                                        ? DeliveryArray(2, variables.myStops.length, isVerified())
                                        : const SizedBox.shrink(),
                                    variables.myStops.length >= 4 && variables.tableStops[widget.idx]['type'] != 'DDU'
                                        ? DeliveryArray(3, variables.myStops.length, isVerified())
                                        : const SizedBox.shrink(),
                                    //
                                    variables.myStops.length >= 5 && variables.tableStops[widget.idx]['type'] != 'DDU'
                                        ? DeliveryArray(4, variables.myStops.length, isVerified())
                                        : const SizedBox.shrink(),
                                    variables.myStops.length >= 6 && variables.tableStops[widget.idx]['type'] != 'DDU'
                                        ? DeliveryArray(5, variables.myStops.length, isVerified())
                                        : const SizedBox.shrink(),
                                    variables.myStops.length >= 7 && variables.tableStops[widget.idx]['type'] != 'DDU'
                                        ? DeliveryArray(6, variables.myStops.length, isVerified())
                                        : const SizedBox.shrink(),
                                    variables.myStops.length >= 8 && variables.tableStops[widget.idx]['type'] != 'DDU'
                                        ? DeliveryArray(7, variables.myStops.length, isVerified())
                                        : const SizedBox.shrink(),
                                  ]))
                              : SizedBox.shrink(),
                          const SizedBox(height: 20),
                          SizedBox(
                            height: 120,
                            width: SizeConfig.screenWidth - 100,
                            child: TextField(
                              controller: tnote,
                              maxLines: 3,
                              minLines: 3,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
                                filled: true,
                                fillColor: Color(Clrs.ltgray),
                                hintText: 'Notes: ',
                              ),
                            ),
                          ),
                          //     : const SizedBox.shrink(),
                          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                            SizedBox(
                                height: 60,
                                width: SizeConfig.screenWidth / 3,
                                child: ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      updateOk = false;
                                      pickedup = false;
                                      expand = false;
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    backgroundColor: Color(Clrs.red),
                                    foregroundColor: Color(Clrs.black),
                                  ),
                                  child: const Text('Cancel', style: TextStyle(fontSize: 25)),
                                )),
                            SizedBox(
                                height: 60,
                                width: SizeConfig.screenWidth / 3,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    if (updateOk) {
                                      int idx = 0;
                                      for (var e in variables.myStops) {
                                        List<Map<String, dynamic>> stp = [];
                                        stp.add({
                                          'recordid': e['recordid'],
                                          'deliverydriver': e['driver'],
                                          'deliverydate': e['deliverydate'],
                                          'statustime': e['statustime'],
                                          'status': variables.tableStops[widget.idx]['type'] == 'DDU' ? 'Delivered' : 'Picked Up',
                                          'pallets': e['pallets'],
                                          'boxes': e['boxes'],
                                          'bags': e['bags'],
                                          'tubs': e['tubs'],
                                          'request': tnote.text,
                                          'dirty': true,
                                        });
                                        await db.dbUpdate(stp, idx == 0 ? 'Stops' : 'Multi', 'recordid');
                                        // update local db tables test
                                        await updateLocal(idx, stp, idx == 0 ? 'Stops' : 'Multi');
                                        idx++;
                                      }

                                      setState(() {
                                        expand = false;
                                      });
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    backgroundColor: Color(updateOk && (pickedup || delivered) ? Clrs.green : Clrs.grey),
                                    foregroundColor: Color(updateOk && (pickedup || delivered) ? Clrs.black : Clrs.white),
                                  ),
                                  child: const Text('Submit', style: TextStyle(fontSize: 25)),
                                )),
                          ])
                        ]),
                      )
                    : const SizedBox.shrink(),
              ]),
            )));
  }

  updateLocal(int idx, List<Map<String, dynamic>> stp, String table) {
    if (idx == 0) {
      for (var e in variables.tableStops) {
        if (e['recordid'] == stp[0]['recordid']) {
          e['driver'] = stp[0]['driver'];
          e['deliverydate'] = stp[0]['deliverydate'];
          e['statustime'] = stp[0]['statustime'];
          e['status'] = stp[0]['status'];
          e['pallets'] = stp[0]['pallets'];
          e['boxes'] = stp[0]['boxes'];
          e['bags'] = stp[0]['bags'];
          e['tubs'] = stp[0]['tubs'];
          e['request'] = stp[0]['request'];
          e['dirty'] = stp[0]['dirty'];
        }
      }
    } else {
      for (var e in multi) {
        if (e['recordid'] == stp[0]['recordid']) {
          e['driver'] = stp[0]['driver'];
          e['deliverydate'] = stp[0]['deliverydate'];
          e['statustime'] = stp[0]['statustime'];
          e['status'] = stp[0]['status'];
          e['pallets'] = stp[0]['pallets'];
          e['boxes'] = stp[0]['boxes'];
          e['bags'] = stp[0]['bags'];
          e['tubs'] = stp[0]['tubs'];
          e['request'] = stp[0]['request'];
          e['dirty'] = stp[0]['dirty'];
        }
      }
    }
    setState(() {});
  }

  // upDateLocalRecord() {
  //   if (Stops[widget.idx]['type'] != 'DDU') {
  //     Stops[widget.idx]['pallets'] = del[0]['pallets'];
  //     Stops[widget.idx]['boxes'] = del[0]['boxes'];
  //     Stops[widget.idx]['bags'] = del[0]['bags'];
  //     Stops[widget.idx]['tubs'] = del[0]['tubs'];
  //   }
  //   Stops[widget.idx]['deliveryDate'] = del[0]['deliveryDate'];
  //   Stops[widget.idx]['statustime'] = del[0]['statustime'];
  //   Stops[widget.idx]['dirty'] = del[0]['dirty'];
  // }

  String configureTime(String t) {
    String rtn = t;
    int idx = t.indexOf(':');
    //  print(t);
    if (idx != -1) {
      switch (t.length) {
        case 2:
          break;
        case 3:
          break;
        case 4:
          break;
        case 5:
          if (idx == 2) {
            rtn = variables.tableMySettings[0]['seconds'] ? '$t:00' : t;
          }
          break;
        case 6:
          break;
        case 7:
          rtn = idx == 1 ? rtn = '0$t' : t;
          rtn = variables.tableMySettings[0]['seconds'] ? rtn : rtn.substring(0, 5);
          break;
        case 8:
          variables.tableMySettings[0]['seconds'] ? rtn = t : rtn = t.substring(0, 5);
          break;
      }
    } else {
      switch (t.length) {
        case 3:
          break;
        case 4:
          rtn = '${t.substring(0, 2)}:${t.substring(2)}';
          rtn += variables.tableMySettings[0]['seconds'] ? ':00' : '';
          break;
        case 5:
          break;
        case 6:
          break;
        case 7:
          break;
        case 8:
          break;
      }
    }
    return rtn;
  }
}

Color getBackColor(int idx) {
  Color rtn = Color(Clrs.white);
  switch (variables.tableStops[idx]['type']) {
    case 'DDU':
      switch (variables.tableStops[idx]['status']) {
        case 'Pending':
          rtn = Color(Clrs.ltgray);
          break;
        case 'Skipped':
          rtn = Color(Clrs.dkgray);
          break;
        case 'Delivered':
        case 'Picked Up':
          rtn = Color(Clrs.dkgray);
          break;
        case 'Cancelled':
          rtn = Color(Clrs.dkgray);
          break;
      }
      break;
    case 'Pickup':
    case 'MI Pickup':
      rtn = Color(Clrs.blue);
      break;
  }
  return rtn;
}

Color getForeColor(int idx) {
  Color rtn = Color(Clrs.white);
  switch (variables.tableStops[idx]['type']) {
    case 'DDU':
      switch (variables.tableStops[idx]['status']) {
        case 'Pending':
          rtn = Color(Clrs.black);
          break;
        case 'Skipped':
          rtn = Color(Clrs.white);
          break;
        case 'Picked Up':
          rtn = Color(Clrs.white);
          break;
        case 'Cancelled':
          rtn = Color(Clrs.white);
          break;
      }
      break;
    case 'Pickup':
    case 'MI Pickup':
      rtn = Color(Clrs.white);
      break;
  }
  return rtn;
}

Color getstatusColor(int idx) {
  Color rtn = Color(Clrs.white);
  switch (variables.tableStops[idx]['status']) {
    case 'Picked Up':
    case 'Delivered':
    case 'On Schedule':
      rtn = Color(Clrs.laser);
      break;
    case 'Cancelled':
    case 'Late':
      rtn = Color(Clrs.red);
      break;
    case 'Skipped':
      rtn = Color(Clrs.taco);
      break;
  }
  return rtn;
}

// class TakePictureScreen extends StatefulWidget {
//   TakePictureScreen({
//     super.key,
//     required this.camera,
//   });

//   final CameraDescription camera;

//   @override
//   TakePictureScreenState createState() => TakePictureScreenState();
// }

// class TakePictureScreenState extends State<TakePictureScreen> {
//   late CameraController _controller;
//   late Future<void> _initializeControllerFuture;

//   @override
//   void initState() {
//     super.initState();
//     // To display the current output from the Camera,
//     // create a CameraController.
//     _controller = CameraController(
//       // Get a specific camera from the list of available cameras.
//       widget.camera,
//       // Define the resolution to use.
//       ResolutionPreset.medium,
//     );

//     // Next, initialize the controller. This returns a Future.
//     _initializeControllerFuture = _controller.initialize();
//   }

//   @override
//   void dispose() {
//     // Dispose of the controller when the widget is disposed.
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(title: const Text('Take a picture')),
//         // You must wait until the controller is initialized before displaying the
//         // camera preview. Use a FutureBuilder to display a loading spinner until the
//         // controller has finished initializing.
//         body: FutureBuilder<void>(
//           future: _initializeControllerFuture,
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.done) {
//               // If the Future is complete, display the preview.
//               return CameraPreview(_controller);
//             } else {
//               // Otherwise, display a loading indicator.
//               return const Center(child: CircularProgressIndicator());
//             }
//           },
//         ),
//         floatingActionButton: FloatingActionButton(
//           // Provide an onPressed callback.
//           onPressed: () async {
//             // Take the Picture in a try / catch block. If anything goes wrong,
//             // catch the error.
//             try {
//               // Ensure that the camera is initialized.
//               await _initializeControllerFuture;

//               // Attempt to take a picture and get the file `image`
//               // where it was saved.
//               final image = await _controller.takePicture();

//               if (!mounted) return;
//               image1 = image.path;
//               //print(image1.toString());
//               //images.add(image.path);
//               // If the picture was taken, display it on a new screen.
//               await Navigator.of(context).push(
//                 MaterialPageRoute(
//                   builder: (context) => DisplayPictureScreen(
//                     // Pass the automatically generated path to
//                     // the DisplayPictureScreen widget.
//                     imagePath: image.path,
//                   ),
//                 ),
//               );
//             } catch (e) {
//               //   // If an error occurs, log the error to the console.
//             }
//             //},

//             const Icon(Icons.camera_alt);
//             //Navigator.pop(context);
//           },
//         ));
//   }
// }

// // A widget that displays the picture taken by the user.
// class DisplayPictureScreen extends StatelessWidget {
//   final String imagePath;

//   const DisplayPictureScreen({super.key, required this.imagePath});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Display the Picture')),
//       // The image is stored as a file on the device. Use the `Image.file`
//       // constructor with the given path to display the image.
//       body: Image.file(File(imagePath)),
//     );
//   }
// }
//           ),
//         ]),
//       ),
//     );
//  }

