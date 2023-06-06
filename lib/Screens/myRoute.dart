// ignore_for_file: file_names, avoid_web_libraries_in_flutter, no_leading_underscores_for_local_identifiers, unused_local_variable, non_constant_identifier_names, prefer_interpolation_to_compose_strings, unused_field, prefer_final_fields

import 'dart:async';
import 'dart:html' as fct;
//import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'package:ids_driver/main.dart';
import 'package:ids_driver/variables.dart';
import 'package:ids_driver/Subs/SizeConfig.dart';
import 'package:ids_driver/Subs/SubRoutines.dart';
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
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  VoidCallback? upDateMe() {
    setState(() {});
    return null;
  }

  //Timer _timer;
  int _start = 10;
  // int _ticks = 0;

  void startTimer() {
    const oneSec = Duration(seconds: 3);
    Timer _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          timer.cancel();
        } else {
          setState(() {
            upDateMe();
            //timeUpdate();
            // print('tick');
          });
        }
      },
    );
  }

  void despose() {
    super.dispose();
    _start = 0;
    startTimer();
  }

  void timeUpdate() {
    // print('tick');
    //setState(() {});
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
              child: IconButton(
                onPressed: () async {
                  //  Navigator.push<void>(context, MaterialPageRoute<void>(builder: (BuildContext context) => ItemsWidget()));
                  //ItemsWidget();
                  // await db.getstops(variables.tableStops, '', variables.tablecurrentEmployee[0]['Employee_ID'], false);
                  setState(() {});
                },
                icon: Icon(Icons.update, color: Color(Clrs.white), size: 30),
              ),
            ),
            Container(
                height: 50,
                width: SizeConfig.screenWidth - 100,
                color: Color(Clrs.blue),
                child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        'IDS Drivers App',
                        style: TextStyle(fontSize: 30, color: Color(Clrs.white)),
                      )),
                ])),
            Container(
                height: 50,
                width: 50,
                color: Color(Clrs.blue),
                child: IconButton(
                    onPressed: () {
                      _start = 0;
                      startTimer();
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
          Container(
              height: SizeConfig.screenHeight - 80,
              width: SizeConfig.screenWidth,
              color: Color(Clrs.ltblue),
              child: Column(children: [
                Expanded(
                    child: ListView.builder(
                  itemCount: variables.tableStops.length,
                  itemBuilder: (context, index) {
                    return StopItem(index);
                  },
                )),
              ])),
        ]),
      ),
    );
  }
}

class StopItem extends StatefulWidget {
  const StopItem(this.idx, {super.key});
  final int idx;

  @override
  State<StopItem> createState() => StopItemState();
}

class StopItemState extends State<StopItem> {
  bool expand = false;

  fct.FunctionStringCallback? isValid(String s) {
    setState(() {
      // print('callback Called');
      btnupdate = s == 'true' ? 1 : 0;
    });
    return null;
  }

  bool? isVerified(bool i) {
    setState(() {});
    return null;
  }

  @override
  initState() {
    super.initState();
    tnote.text = variables.tableStops[widget.idx]['note'];
    trequest.text = variables.tableStops[widget.idx]['request'];
  }

  List<Map<String, dynamic>> del = [];

  TextEditingController tnote = TextEditingController();
  TextEditingController trequest = TextEditingController();

  int btnpending = 0;
  int btnclosed = 1;
  int btndelivered = 1;
  int btnpickup = 1;
  int btncancel = 1;
  int btnupdate = 0;
  int btnnone = 1;

  List<Map<String, dynamic>> multi = [];
  int count = 0;

  int stopCount = 1;

  @override
  Widget build(BuildContext context) {
    Future getMainCompany(int idx) async {
      String time = SubRoutine.getTime(DateTime.now(), false, true);
      String date = SubRoutine.getDate(DateTime.now());
      variables.myStops.clear();
      try {
        variables.myStops.add({
          'recordid': variables.tableStops[idx]['recordid'],
          'company': variables.tableStops[idx]['company'],
          'deliverydriver': variables.tableStops[idx]['driver'],
          'deliverydate': date,
          'statustime': time,
          'status': variables.tableStops[idx]['status'],
          'pallets': int.parse(variables.tableStops[idx]['pallets']),
          'boxes': int.parse(variables.tableStops[idx]['boxes']),
          'bags': int.parse(variables.tableStops[idx]['bags']),
          'tubs': int.parse(variables.tableStops[idx]['tubs']),
          'request': variables.tableStops[idx]['request'],
          'note': variables.tableStops[idx]['note'],
        });
      } catch (e) {
        variables.myStops.add({
          'recordid': variables.tableStops[idx]['recordid'],
          'company': variables.tableStops[idx]['company'],
          'deliverydriver': variables.tableStops[idx]['driver'],
          'deliverydate': date,
          'statustime': time,
          'status': variables.tableStops[idx]['status'],
          'pallets': int.parse(variables.tableStops[idx]['pallets']),
          'boxes': int.parse(variables.tableStops[idx]['boxes']),
          'bags': int.parse(variables.tableStops[idx]['bags']),
          'tubs': int.parse(variables.tableStops[idx]['tubs']),
          'request': variables.tableStops[idx]['request'],
          'note': variables.tableStops[idx]['note'],
        });
      }
      if (variables.tableStops[idx]['multi'].toString() == 'true') {
        for (var e in variables.tableMulti) {
          if (e['parent'] == variables.myStops[0]['recordid']) {
            variables.myStops.add({
              'recordid': e['recordid'],
              'company': e['company'],
              'deliverydriver': variables.tableStops[widget.idx]['driver'],
              'deliverydate': '',
              'statustime': '',
              'status': 'Picked Up',
              'pallets': 0,
              'boxes': 0,
              'bags': 0,
              'tubs': 0,
              'request': '',
              'note': '',
            });
          }
        }
        stopCount = variables.myStops.length;
      }
    }

    return Material(
      child: variables.tableStops[widget.idx]['type'] != 'DDU'
          ? Padding(
              padding: const EdgeInsets.only(top: 15, right: 20),
              child: InkWell(
                  onTap: () async {
                    if (variables.tableStops[widget.idx]['status'] != 'Picked Up') {
                      // print(variables.tableStops[widget.idx]['status']);
                      await getMainCompany(widget.idx);
                      await db.getMulii(variables.tableMulti);
                      myStop.clear();
                      myStop.add(variables.tableStops[widget.idx]);
                      for (var e in variables.tableMulti) {
                        if (e['parent'] == variables.tableStops[widget.idx]['recordid']) {
                          count++;
                          myStop.add(e);
                          print(count.toString() + '  ' + e['company']);
                        }
                      }
                      setState(() {
                        btnpending = 1;
                        btnpickup = 2;
                        btnupdate = 0;
                        expand = !expand;
                      });
                    }
                  },
                  child: Column(children: [
                    Container(
                      height: expand
                          ? btnpickup == 2
                              ? 490 + 200 * count.toDouble() //variables.myStops.length.toDouble()
                              : 184
                          : 104,
                      width: SizeConfig.screenWidth - 20,
                      decoration: BoxDecoration(
                        color: getBackColor(widget.idx, true),
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(20.0), // expand

                          bottomRight: Radius.circular(20.0),
                        ),
                        border: Border.all(color: Color(variables.tableStops[widget.idx]['multi'] == 'true' ? Clrs.laser : Clrs.blue), width: 2.0),
                      ),
                      child: Column(children: [
                        Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          SizedBox(
                            height: 100,
                            width: (SizeConfig.screenWidth - 22) * 0.422,
                            child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [
                              SizedBox(
                                height: 30,
                                width: ((SizeConfig.screenWidth - 22) * 0.422) - 15,
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    variables.tableStops[widget.idx]['type'],
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: getBackColor(widget.idx, false),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 30,
                                width: ((SizeConfig.screenWidth - 22) * 0.422) - 15,
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    variables.tableStops[widget.idx]['status'],
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: getstatusColor(widget.idx),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 30,
                                width: ((SizeConfig.screenWidth - 22) * 0.422) - 15,
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    '${variables.tableStops[widget.idx]['start']} ${variables.tableStops[widget.idx]['end']}',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Color(statusColor(widget.idx)),
                                    ),
                                  ),
                                ),
                              ),
                            ]),
                          ),
                          SizedBox(
                              height: 100,
                              width: (SizeConfig.screenWidth - 22) * 0.566,
                              child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [
                                SizedBox(
                                  height: 30,
                                  width: ((SizeConfig.screenWidth - 22) * 0.422) - 15,
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      variables.tableStops[widget.idx]['company'],
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: getBackColor(widget.idx, false),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 30,
                                  width: ((SizeConfig.screenWidth - 22) * 0.422) - 15,
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      variables.tableStops[widget.idx]['street'].toString().isNotEmpty ? variables.tableStops[widget.idx]['street'] : ' ',
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: getBackColor(widget.idx, false),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 30, // 'My Route'
                                  width: ((SizeConfig.screenWidth - 22) * 0.422) - 15,
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      (variables.tableStops[widget.idx]['city'].toString().isNotEmpty ? variables.tableStops[widget.idx]['city'] : ' ') +
                                          ', ' +
                                          (variables.tableStops[widget.idx]['state'].toString().isNotEmpty ? variables.tableStops[widget.idx]['state'] : ' '),
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: getBackColor(widget.idx, false),
                                      ),
                                    ),
                                  ),
                                ),
                              ])),
                        ]),

                        expand
                            ? Container(
                                height: 200,
                                width: SizeConfig.screenWidth - 20,
                                color: Color(Clrs.dkblue),
                                child: DeliveryArray(0, stopCount, isValid),
                              )
                            : const SizedBox.shrink(),
                        expand && myStop.length > 1
                            ? Container(
                                height: 200,
                                width: SizeConfig.screenWidth - 20,
                                color: Color(Clrs.dkblue),
                                child: DeliveryArray(1, stopCount, isValid),
                              )
                            : const SizedBox.shrink(),
                        expand && myStop.length > 2
                            ? Container(
                                height: 200,
                                width: SizeConfig.screenWidth - 20,
                                color: Color(Clrs.dkblue),
                                child: DeliveryArray(2, stopCount, isValid),
                              )
                            : const SizedBox.shrink(),
                        expand && myStop.length > 3
                            ? Container(
                                height: 200,
                                width: SizeConfig.screenWidth - 20,
                                color: Color(Clrs.dkblue),
                                child: DeliveryArray(3, stopCount, isValid),
                              )
                            : const SizedBox.shrink(),
                        // expand && count > 5
                        //     ? Container(
                        //         height: 200,
                        //         width: SizeConfig.screenWidth - 20,
                        //         color: Color(Clrs.dkblue),
                        //         child: DeliveryArray(0, stopCount, isValid),
                        //       )
                        //     : const SizedBox.shrink(),
                        // expand && count > 4
                        //     ? Container(
                        //         height: 200,
                        //         width: SizeConfig.screenWidth - 20,
                        //         color: Color(Clrs.dkblue),
                        //         child: DeliveryArray(0, stopCount, isValid),
                        //       )
                        //     : const SizedBox.shrink(),
                        // expand && count > 3
                        //     ? Container(
                        //         height: 200,
                        //         width: SizeConfig.screenWidth - 20,
                        //         color: Color(Clrs.dkblue),
                        //         child: DeliveryArray(0, count, isValid),
                        //       )
                        //     : const SizedBox.shrink(),
                        // expand && count > 2
                        //     ? Container(
                        //         height: 200,
                        //         width: SizeConfig.screenWidth - 20,
                        //         color: Color(Clrs.dkblue),
                        //         child: DeliveryArray(3, count, isValid),
                        //       )
                        //     : const SizedBox.shrink(),
                        // expand && count > 1
                        //     ? Container(
                        //         height: 200,
                        //         width: SizeConfig.screenWidth - 20,
                        //         color: Color(Clrs.dkblue),
                        //         child: DeliveryArray(0, count, isValid),
                        //       )
                        //     : const SizedBox.shrink(),
                        // expand && count > 0
                        //     ? Container(
                        //         height: 200,
                        //         width: SizeConfig.screenWidth - 20,
                        //         color: Color(Clrs.dkblue),
                        //         child: DeliveryArray(0, count, isValid),
                        //       )
                        //     : const SizedBox.shrink(),
                        // expand
                        //     ? Container(
                        //         height: 200,
                        //         width: SizeConfig.screenWidth - 20,
                        //         color: Color(Clrs.dkblue),
                        //         child: DeliveryArray(0, count, isValid),
                        //       )
                        //     : const SizedBox.shrink(),

                        // expand
                        //     ? Padding(
                        //         padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        //         child: SizedBox(
                        //           height: 100,
                        //           width: SizeConfig.screenWidth - 60,
                        //           child: TextFormField(
                        //             controller: trequest,
                        //             style: const TextStyle(color: Colors.white),
                        //             maxLines: 5,
                        //             decoration: const InputDecoration(
                        //                 // filled: true,
                        //                 // fillColor: Colors.white,

                        //                 labelText: 'Request',
                        //                 labelStyle: TextStyle(color: Colors.white),
                        //                 enabledBorder: OutlineInputBorder(
                        //                   borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        //                   borderSide: BorderSide(width: 2.0, color: Colors.white),
                        //                 ),
                        //                 focusedBorder: OutlineInputBorder(
                        //                   borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        //                   borderSide: BorderSide(width: 2.0, color: Colors.white),
                        //                 )),
                        //             onTap: () {},
                        //           ),
                        //         ),
                        //       )
                        //     : const SizedBox.shrink(),
                        // expand
                        //     ? Padding(
                        //         padding: const EdgeInsets.symmetric(horizontal: 10),
                        //         child: SizedBox(
                        //           height: 100,
                        //           width: SizeConfig.screenWidth - 60,
                        //           child: TextField(
                        //             controller: tnote,
                        //             style: const TextStyle(color: Colors.white),
                        //             maxLines: 5,
                        //             decoration: const InputDecoration(
                        //                 labelText: 'Note',
                        //                 labelStyle: TextStyle(color: Colors.white),
                        //                 enabledBorder: OutlineInputBorder(
                        //                   borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        //                   borderSide: BorderSide(width: 2.0, color: Colors.white),
                        //                 ),
                        //                 focusedBorder: OutlineInputBorder(
                        //                   borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        //                   borderSide: BorderSide(width: 2.0, color: Colors.black),
                        //                 )),
                        //             onTap: () {},
                        //           ),
                        //         ))
                        //     : const SizedBox.shrink(),

                        expand ? const SizedBox(height: 20) : const SizedBox.shrink(),
                        expand
                            ? Padding(
                                padding: const EdgeInsets.only(bottom: 20),
                                child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                                  SizedBox(
                                      height: 60,
                                      width: ((SizeConfig.screenWidth - 80)) / 2,
                                      child: ElevatedButton(
                                          onPressed: () {
                                            setState(() {
                                              if (btnclosed == 1) {
                                                btnclosed = 2;
                                                btnnone = 1;
                                                btnupdate = 1;
                                              } else if (btnclosed == 2) {
                                                btnclosed = 1;
                                                btnupdate = 0;
                                              }
                                            });
                                          },
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: getBtnColor(btnclosed, true, false),
                                              foregroundColor: getBtnColor(btnclosed, false, false),
                                              textStyle: const TextStyle(fontSize: 25),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(30.0),
                                                side: BorderSide(color: Color(Clrs.green), width: 2.0),
                                              )),
                                          child: const FittedBox(
                                            fit: BoxFit.scaleDown,
                                            child: Text('Closed'),
                                          ))),
                                  SizedBox(
                                      height: 60,
                                      width: ((SizeConfig.screenWidth - 50)) / 2,
                                      child: ElevatedButton(
                                          onPressed: () async {
                                            setState(() {
                                              if (btnnone == 1) {
                                                btnclosed = 1;
                                                btnnone = 2;
                                                btnupdate = 1;
                                              } else if (btnnone == 2) {
                                                btnnone = 1;
                                                btnupdate = 0;
                                              }
                                            });
                                          },
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: getBtnColor(btnnone, true, false),
                                              foregroundColor: getBtnColor(btnnone, false, false),
                                              textStyle: const TextStyle(fontSize: 25),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(30.0),
                                                side: BorderSide(color: Color(Clrs.green), width: 2.0),
                                              )),
                                          child: const FittedBox(
                                            fit: BoxFit.scaleDown,
                                            child: Text('Nothing'),
                                          ))),
                                ]))
                            : const SizedBox.shrink(),
                        expand
                            ? Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                                Container(
                                    height: 60,
                                    width: ((SizeConfig.screenWidth - 80)) / 2,
                                    color: Color(Clrs.transparent),
                                    child: ElevatedButton(
                                        onPressed: () async {
                                          setState(() {
                                            btnpending = 2;
                                            btnpickup = 1;
                                            btnupdate = 0;
                                            btncancel = 1;
                                            expand = false;
                                          });
                                        },
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: getBtnColor(btncancel, true, true),
                                            foregroundColor: getBtnColor(btncancel, false, true),
                                            textStyle: const TextStyle(fontSize: 25),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(30.0),
                                              side: BorderSide(color: Color(Clrs.red), width: 2.0),
                                            )),
                                        child: const FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: Text('Cancel'),
                                        ))),
                                SizedBox(
                                    height: 60,
                                    width: ((SizeConfig.screenWidth - 50)) / 2,
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        if (btnupdate == 1) {
                                          setState(() {
                                            btnupdate = 2;
                                          });
                                          // Update Local db
                                          variables.tableStops[widget.idx]['pallets'] = myStop[0]['pallets'];
                                          variables.tableStops[widget.idx]['boxes'] = myStop[0]['boxes'];
                                          variables.tableStops[widget.idx]['bags'] = myStop[0]['bags'];
                                          variables.tableStops[widget.idx]['tubs'] = myStop[0]['tubs'];
                                          variables.tableStops[widget.idx]['request'] = myStop[0]['request'];
                                          variables.tableStops[widget.idx]['note'] = myStop[0]['note'];
                                          variables.tableStops[widget.idx]['status'] = btnclosed == 2
                                              ? 'Late'
                                              : btnnone == 2
                                                  ? 'Picked Up'
                                                  : 'Picked Up';
                                          // Update multi if needed
                                          if (variables.myStops.length > 1) {
                                            for (int x = 1; x < variables.myStops.length; x++) {
                                              List<Map<String, dynamic>> lst = [];
                                              lst.add({
                                                'recordid': myStop[x]['recordid'],
                                                'status': 'Picked Up',
                                                'time': SubRoutine.getTime(DateTime.now(), false, true),
                                                'deliverydate': SubRoutine.getDate(DateTime.now()),
                                                'pallets': myStop[x]['pallets'],
                                                'boxes': myStop[x]['boxes'],
                                                'bags': myStop[x]['bags'],
                                                'tubs': myStop[x]['tubs'],
                                              });
                                              await db.dbUpdate(lst, 'Multi', 'recordid');
                                            }
                                            await db.getMulii(variables.tableMulti);
                                          }
                                          // update remote db
                                          List<Map<String, dynamic>> lst = [];
                                          lst.add({
                                            'recordid': variables.myStops[0]['recordid'],
                                            'status': btnclosed == 2
                                                ? 'Late'
                                                : btnnone == 2
                                                    ? 'Picked Up'
                                                    : 'Picked Up',
                                            'statustime': SubRoutine.getTime(DateTime.now(), false, true),
                                            'deliverydate': SubRoutine.getDate(DateTime.now()),
                                            'pallets': variables.myStops[0]['pallets'].toString(),
                                            'boxes': variables.myStops[0]['boxes'].toString(),
                                            'bags': variables.myStops[0]['bags'].toString(),
                                            'tubs': variables.myStops[0]['tubs'].toString(),
                                          });
                                          await db.dbUpdate(lst, 'Stops', 'recordid');
                                          if (variables.myStops.length > 1) {}
                                          setState(() {
                                            btnupdate = 1;

                                            expand = false;
                                          });
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: getBtnColor(btnupdate, true, false),
                                          foregroundColor: getBtnColor(btnupdate, false, false),
                                          textStyle: const TextStyle(fontSize: 25),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(30.0),
                                            side: BorderSide(color: Color(btnupdate == 1 ? Clrs.green : Clrs.black), width: 2.0),
                                          )),
                                      child: const Text('Save'),
                                    )),
                              ])
                            : const SizedBox.shrink(),
                        //           SizedBox(height: 40),
                        //         ]),
                        //       ),
                        //     )
                        //   : const SizedBox.shrink(),
                      ]),
                    ),
                    widget.idx == variables.tableStops.length - 1
                        ? Container(
                            height: 500,
                            width: SizeConfig.screenWidth,
                            color: Color(Clrs.transparent),
                          )
                        : const SizedBox.shrink(),
                  ])))
          : Padding(
              padding: const EdgeInsets.only(top: 15, left: 20),
              child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                InkWell(
                    onTap: () {
                      if (variables.tableStops[widget.idx]['status'] != 'Delivered') {
                        setState(() {
                          // btndelivered = 2;
                          btnupdate = 0;
                          expand = !expand;
                        });
                      }
                    },
                    child: Column(children: [
                      Container(
                        height: expand
                            //  ? btndelivered == 2
                            ? 514
                            // : 180,
                            : 124,
                        width: SizeConfig.screenWidth - 20,
                        decoration: BoxDecoration(
                          color: getBackColor(widget.idx, true),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20.0),
                            bottomLeft: Radius.circular(20.0),
                          ),
                          border: Border.all(color: Color(Clrs.blue), width: 2.0),
                        ),
                        child: Column(children: [
                          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Container(
                              height: 100,
                              width: (SizeConfig.screenWidth - 40) * 0.422,
                              color: Color(Clrs.transparent),
                              child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [
                                SizedBox(
                                  height: 30,
                                  width: ((SizeConfig.screenWidth - 20) * 0.422) - 15,
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      variables.tableStops[widget.idx]['type'],
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: getBackColor(widget.idx, false),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 30,
                                  width: ((SizeConfig.screenWidth - 22) * 0.422) - 15,
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      variables.tableStops[widget.idx]['status'],
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: getstatusColor(widget.idx),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 30,
                                  width: ((SizeConfig.screenWidth - 22) * 0.422) - 15,
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      getTimes(widget.idx),
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Color(
                                          statusColor(widget.idx),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ]),
                            ),
                            SizedBox(
                                height: 100,
                                width: (SizeConfig.screenWidth - 20) * 0.566,
                                child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [
                                  SizedBox(
                                    height: 30,
                                    width: ((SizeConfig.screenWidth - 20) * 0.422) - 15,
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        variables.tableStops[widget.idx]['company'],
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: getBackColor(widget.idx, false),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30,
                                    width: ((SizeConfig.screenWidth - 20) * 0.422) - 15,
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        variables.tableStops[widget.idx]['street'].toString().isNotEmpty ? variables.tableStops[widget.idx]['street'] : ' ',
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: getBackColor(widget.idx, false),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30,
                                    width: ((SizeConfig.screenWidth - 20) * 0.422) - 15,
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        (variables.tableStops[widget.idx]['city'].toString().isNotEmpty ? variables.tableStops[widget.idx]['city'] : ' ') +
                                            ', ' +
                                            (variables.tableStops[widget.idx]['state'].toString().isNotEmpty ? variables.tableStops[widget.idx]['state'] : ' '),
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: getBackColor(widget.idx, false),
                                        ),
                                      ),
                                    ),
                                  ),
                                ])),
                          ]),
                          expand
                              ? Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                  child: SizedBox(
                                    height: 100,
                                    width: SizeConfig.screenWidth - 60,
                                    child: TextFormField(
                                      controller: trequest,
                                      maxLines: 5,
                                      cursorColor: Color(Clrs.white),
                                      decoration: const InputDecoration(
                                          labelStyle: TextStyle(fontSize: 20, color: Colors.white),
                                          filled: true,
                                          fillColor: Colors.grey,
                                          labelText: 'Request',
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                            borderSide: BorderSide(width: 2.0, color: Colors.black),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                            borderSide: BorderSide(width: 2.0, color: Colors.black),
                                          )),
                                      onTap: () {},
                                    ),
                                  ))
                              : const SizedBox.shrink(),
                          expand //&& btndelivered == 2
                              ? Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                  child: SizedBox(
                                    height: 100,
                                    width: SizeConfig.screenWidth - 60,
                                    child: TextField(
                                      controller: tnote,
                                      maxLines: 5,
                                      cursorColor: Color(Clrs.white),
                                      style: TextStyle(fontSize: 24, color: Color(Clrs.white)),
                                      decoration: const InputDecoration(
                                          labelText: 'Note',
                                          labelStyle: TextStyle(fontSize: 20, color: Colors.white),
                                          filled: true,
                                          fillColor: Colors.grey,
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                            borderSide: BorderSide(width: 2.0, color: Colors.black),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                            borderSide: BorderSide(width: 2.0, color: Colors.black),
                                          )),
                                      onTap: () {},
                                    ),
                                  ))
                              : const SizedBox.shrink(),
                          expand
                              ? Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                                  SizedBox(
                                      height: 60,
                                      width: ((SizeConfig.screenWidth - 80)) / 2,
                                      child: ElevatedButton(
                                          onPressed: () {
                                            setState(() {
                                              if (btnclosed == 1) {
                                                btnclosed = 2;
                                                btnupdate = 1;

                                                btndelivered = 1;
                                              } else {
                                                btnclosed = 1;
                                                btnupdate = 0;
                                              }
                                            });
                                          },
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: getBtnColor(btnclosed, true, false),
                                              foregroundColor: getBtnColor(btnclosed, false, false),
                                              textStyle: const TextStyle(fontSize: 25),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(30.0),
                                                side: BorderSide(color: Color(Clrs.green), width: 2),
                                              )),
                                          child: const FittedBox(
                                            fit: BoxFit.scaleDown,
                                            child: Text('Closed'),
                                          ))),
                                  const SizedBox(height: 20),
                                  SizedBox(
                                      height: 60,
                                      width: ((SizeConfig.screenWidth - 50)) / 2,
                                      child: ElevatedButton(
                                          onPressed: () {
                                            setState(() {
                                              if (btndelivered == 1) {
                                                btnpending = 1;
                                                btndelivered = 2;
                                                btnclosed = 1;
                                                btnupdate = 1;
                                              } else {
                                                btnpending = 1;
                                                btndelivered = 1;
                                                btnupdate = 0;
                                              }
                                            });
                                          },
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: getBtnColor(btndelivered, true, false),
                                              foregroundColor: getBtnColor(btndelivered, false, false),
                                              textStyle: const TextStyle(fontSize: 25),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(30.0),
                                                side: BorderSide(color: Color(Clrs.green), width: 2),
                                              )),
                                          child: const FittedBox(
                                            fit: BoxFit.scaleDown,
                                            child: Text('Delivered'),
                                          ))),
                                ])
                              : const SizedBox.shrink(),
                          const SizedBox(height: 20),
                          expand //&& btndelivered == 2
                              ? Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                                  SizedBox(
                                      height: 60,
                                      width: ((SizeConfig.screenWidth - 80)) / 2,
                                      child: ElevatedButton(
                                          onPressed: () async {
                                            setState(() {
                                              btnpending = 2;
                                              btndelivered = 1;
                                              btnupdate = 0;
                                              btncancel = 2;
                                              expand = false;
                                            });
                                            await Future.delayed(
                                              const Duration(seconds: 2),
                                            );
                                            setState(() {
                                              btncancel = 1;
                                              expand = false;
                                            });
                                          },
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: getBtnColor(btncancel, true, true),
                                              foregroundColor: getBtnColor(btncancel, false, true),
                                              textStyle: const TextStyle(fontSize: 25),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(30.0),
                                                side: BorderSide(color: Color(Clrs.red), width: 2),
                                              )),
                                          child: const FittedBox(
                                            fit: BoxFit.scaleDown,
                                            child: Text('Cancel'),
                                          ))),
                                  SizedBox(
                                      height: 60,
                                      width: ((SizeConfig.screenWidth - 50)) / 2,
                                      child: ElevatedButton(
                                        onPressed: () async {
                                          setState(() {
                                            btnupdate = 2;
                                          });
                                          // update local db
                                          variables.tableStops[widget.idx]['status'] = 'Delivered';
                                          variables.tableStops[widget.idx]['deliverydate'] = SubRoutine.getDate(DateTime.now());
                                          variables.tableStops[widget.idx]['statustime'] = SubRoutine.getTime(DateTime.now(), false, true);
                                          variables.tableStops[widget.idx]['request'] = trequest.text;
                                          variables.tableStops[widget.idx]['note'] = tnote.text;
                                          // update remote db
                                          List<Map<String, dynamic>> lst = [];
                                          lst.add({
                                            'recordid': variables.tableStops[widget.idx]['recordid'],
                                            'status': variables.tableStops[widget.idx]['status'],
                                            'deliverydate': variables.tableStops[widget.idx]['deliverydate'],
                                            'statustime': variables.tableStops[widget.idx]['statustime'],
                                            'request': variables.tableStops[widget.idx]['request'],
                                            'note': variables.tableStops[widget.idx]['note'],
                                            // 'pallets': variables.tableStops[widget.idx]['pallets'],
                                            // 'boxes': variables.tableStops[widget.idx]['boxes'],
                                            // 'bags': variables.tableStops[widget.idx]['bags'],
                                            // 'tubs': variables.tableStops[widget.idx]['tubs'],
                                          });
                                          await db.dbUpdate(lst, 'Stops', 'recordid');

                                          setState(() {
                                            btnupdate = 1;
                                            expand = false;
                                          });
                                        },
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: getBtnColor(btnupdate, true, false),
                                            foregroundColor: getBtnColor(btnupdate, false, false),
                                            textStyle: const TextStyle(fontSize: 25),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(30.0),
                                              side: BorderSide(color: Color(btnupdate == 1 ? Clrs.green : Clrs.grey), width: 2),
                                            )),
                                        child: const Text('Save'),
                                      )),
                                ])
                              : const SizedBox.shrink(),
                        ]),
                      ),
                      widget.idx == variables.tableStops.length - 1
                          ? Container(
                              height: 500,
                              width: SizeConfig.screenWidth,
                              color: Color(Clrs.transparent),
                            )
                          : const SizedBox.shrink(),
                    ])),
              ])),
      // : const SizedBox.shrink(),
    );
  }

  String getTimes(int idx) {
    String rtn = '';
    switch (SubRoutine.getday()) {
      case 'Sat':
        rtn = variables.tableStops[widget.idx]['satstart'] + ' ' + variables.tableStops[widget.idx]['satend'];
        break;
      case 'Sun':
        rtn = variables.tableStops[widget.idx]['sunstart'] + ' ' + variables.tableStops[widget.idx]['sunend'];
        break;
      default:
        rtn = variables.tableStops[widget.idx]['start'] + ' ' + variables.tableStops[widget.idx]['end'];
        break;
    }
    return rtn;
  }

  int statusColor(int idx) {
    int rtn = Clrs.black;
    bool ddu = variables.tableStops[idx]['start'] == 'DDU' ? true : false;
    String d = getTimes(idx);
    switch (statusTime(d.substring(0, 4), d.substring(5), variables.tableStops[idx]['type'] == 'DDU')) {
      case 0:
        rtn = ddu ? Clrs.black : Clrs.white;
        break;
      case 1:
        rtn = ddu ? Clrs.dkgreen : Clrs.green;
        break;
      case 2:
        rtn = ddu ? Clrs.yellow : Clrs.yellow;
        break;
      case 3:
        rtn = Clrs.red;
        break;
    }
    return rtn;
  }

  int statusTime(String start, String end, bool DDU) {
    const int notOpen = 0;
    const int open = 1;
    const int warning = 2;
    const int closed = 3;
    int rtn = 0;
    String dateToday = DateTime.now().toString();
    dateToday = '${dateToday.substring(0, dateToday.indexOf(' '))}T';
    DateTime dduTime = timeConvert(dduReadyTime);
    DateTime startTime = timeConvert(start);
    DateTime endTime = timeConvert(end);
    if (DDU) {
      if (DateTime.now().compareTo(startTime) == 1) {
        rtn = open;
        if (DateTime.now().compareTo(endTime) == 1) {
          rtn = closed;
        } else if (DateTime.now().add(const Duration(minutes: 30)).compareTo(endTime) == 1) {
          rtn = warning;
        }
      }
    } else if (DateTime.now().compareTo(startTime) == 1) {
      rtn = open;
      if (DateTime.now().compareTo(endTime) == 1) {
        rtn = closed;
      } else if (DateTime.now().add(const Duration(minutes: 30)).compareTo(endTime) == 1) {
        rtn = warning;
      }
    }
    return rtn;
  }

  DateTime timeConvert(String time) {
    String t = '';
    String dateToday = DateTime.now().toString();
    if (time.isEmpty) {
      return DateTime.now();
    }
    time = time.replaceAll(':', '');
    if (time.length == 3 || time.length == 5) {
      time = '0' + time;
    }
    t = time.substring(0, 2) + ':';
    t += time.substring(2, 4) + ':00';

    return DateTime.parse(dateToday.substring(0, dateToday.indexOf(' ')) + 'T' + t);
  }

  Color getBtnColor(int button, bool backColor, bool cancel) {
    Color rtn = Color(Clrs.transparent);
    if (backColor) {
      switch (button) {
        case 0:
          rtn = Color(Clrs.grey);
          break;
        case 1:
          rtn = Color(cancel ? Clrs.ltred : Clrs.ltgreen);
          break;
        case 2:
        case 3:
          rtn = Color(cancel ? Clrs.red : Clrs.green);
          break;
      }
    } else {
      switch (button) {
        case 0:
          rtn = Color(Clrs.white);
          break;
        case 1:
          rtn = Color(Clrs.black);
          break;
        case 2:
          rtn = Color(Clrs.black);
          break;
      }
    }
    return rtn;
  }

  String configureTime(String t) {
    String rtn = t;
    int idx = t.indexOf(':');

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

Color getBackColor(int idx, bool complete) {
  Color rtn = Color(Clrs.white);
  if (complete) {
    if (variables.tableStops[idx]['type'] == 'DDU') {
      switch (variables.tableStops[idx]['status']) {
        case 'Delivered':
          rtn = Color(Clrs.grey);
          break;
        default:
          rtn = Color(Clrs.dkgray);
          break;
      }
    } else {
      switch (variables.tableStops[idx]['status']) {
        case 'Picked Up':
          rtn = Color(Clrs.blue);
          break;
        default:
          rtn = Color(Clrs.dkblue);
          break;
      }
    }
  } else {
    switch (variables.tableStops[idx]['type']) {
      case 'DDU':
        switch (variables.tableStops[idx]['status']) {
          case 'Pending':
            rtn = Color(Clrs.white);
            break;
          case 'Skipped':
            rtn = Color(Clrs.white);
            break;
          case 'Delivered':
            rtn = Color(Clrs.black);
            break;
          case 'Picked Up':
            rtn = Color(Clrs.black);
            break;
          case 'Cancelled':
            rtn = Color(Clrs.black);
            break;
        }
        break;
      case 'Pickup':
      case 'MI Pickup':
        rtn = Color(Clrs.white);
        break;
    }
  }
  return rtn;
}

Color getForeColor(int idx) {
  Color rtn = Color(Clrs.white);
  switch (variables.tableStops[idx]['type']) {
    case 'DDU':
      switch (variables.tableStops[idx]['status']) {
        case 'Pending':
          rtn = Color(Clrs.white);
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
  Color rtn = Color(variables.tableStops[idx]['type'] == 'DDU' ? Clrs.white : Clrs.black);
  switch (variables.tableStops[idx]['status']) {
    case 'Pending':
      rtn = Color(Clrs.white);
      break;
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
