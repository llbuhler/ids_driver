// ignore_for_file: file_names

import 'dart:html' as fct;

import 'package:flutter/material.dart';
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
  VoidCallback? upDateMe() {
    setState(() {});
    return null;
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
                  await db.getstops(variables.tableStops, '', variables.tablecurrentEmployee[0]['Employee_ID'], false);
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
      print('callback Called');
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

  int btnpending = 2;
  int btndelivered = 1;
  int btnpickup = 1;
  int btncancel = 1;
  int btnupdate = 0;

  List<Map<String, dynamic>> multi = [];

  int stopCount = 1;

  @override
  Widget build(BuildContext context) {
    Future getMainCompany(int idx) async {
      //await db.getMulii(multi);

      String time = SubRoutine.getTime(DateTime.now(), false, true);
      String date = SubRoutine.getDate(DateTime.now());
      variables.myStops.clear();
      variables.myStops.add({
        'recordid': variables.tableStops[idx]['recordid'],
        'company': variables.tableStops[idx]['company'],
        'deliverydriver': variables.tableStops[idx]['driver'],
        'deliverydate': date,
        'statustime': time,
        'status': variables.tableStops[idx]['status'],
        'pallets': variables.tableStops[idx]['pallets'],
        'boxes': variables.tableStops[idx]['boxes'],
        'bags': variables.tableStops[idx]['bags'],
        'tubs': variables.tableStops[idx]['tubs'],
        'request': variables.tableStops[idx]['request'],
        'note': variables.tableStops[idx]['note'],
      });

      //if (variables.tableStops[idx]['multi'].toString() == 'true') {
      for (var e in variables.tableMulti) {
        if (e['parent'] == variables.myStops[0]['recordid']) {
          print(e['company']);
          variables.myStops.add({
            'recordid': e['recordid'],
            'company': e['company'],
            'deliverydriver': variables.tableStops[widget.idx]['driver'],
            'deliverydate': date,
            'statustime': time,
            'status': 'Picked Up',
            'pallets': 0,
            'boxes': 0,
            'bags': 0,
            'tubs': 0,
            'request': '',
          });
        }
      }
      stopCount = variables.myStops.length;
    }

    return Material(
        child: variables.tableStops[widget.idx]['type'] != 'DDU'
            ? Padding(
                padding: const EdgeInsets.only(top: 15, right: 20),
                child: InkWell(
                    onTap: () {
                      if (variables.tableStops[widget.idx]['status'] != 'Picked Up') {
                        setState(() {
                          expand = !expand;
                          //print(SizeConfig.screenWidth - 20);
                        });
                      }
                    },
                    child: Column(children: [
                      Container(
                        height: expand
                            ? btnpickup == 2
                                ? 700 + 140 * stopCount.toDouble() //variables.myStops.length.toDouble()
                                : 184
                            : 104,
                        width: SizeConfig.screenWidth - 20,
                        decoration: BoxDecoration(
                          color: getBackColor(widget.idx, true),
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(20.0),
                            bottomRight: Radius.circular(20.0),
                          ),
                          border: Border.all(color: Color(variables.tableStops[widget.idx]['multi'] == 'true' ? Clrs.laser : Clrs.blue), width: 2.0),
                        ),
                        child: Column(children: [
                          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            SizedBox(
                              height: 100,
                              width: (SizeConfig.screenWidth - 20) * 0.422,
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
                                  width: ((SizeConfig.screenWidth - 20) * 0.422) - 15,
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
                                  width: ((SizeConfig.screenWidth - 20) * 0.422) - 15,
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      '${variables.tableStops[widget.idx]['start']} ${variables.tableStops[widget.idx]['end']}',
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: getBackColor(widget.idx, false),
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
                                    height: 30, // 'My Route'
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
                                  padding: const EdgeInsets.only(bottom: 20),
                                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                                    SizedBox(
                                        height: 60,
                                        width: ((SizeConfig.screenWidth - 80)) / 2,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            if (btnpending == 1) {
                                              setState(() {
                                                btnpending = 2;
                                                btnpickup = 1;
                                                btnupdate = 0;
                                              });
                                            }
                                          },
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: getBtnColor(btnpending, true, false),
                                              foregroundColor: getBtnColor(btnpending, false, false),
                                              textStyle: const TextStyle(fontSize: 25),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(30.0),
                                              )),
                                          child: const Text('Pending'),
                                        )),
                                    SizedBox(
                                        height: 60,
                                        width: ((SizeConfig.screenWidth - 50)) / 2,
                                        child: ElevatedButton(
                                          onPressed: () async {
                                            //if (btnpickup == 1) {
                                            await getMainCompany(widget.idx);
                                            print('Picked Up pressed');
                                            setState(() {
                                              btnpending = 1;
                                              btnpickup = 2;
                                              btnupdate = 0;
                                            });
                                            //}
                                          },
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: getBtnColor(btnpickup, true, false),
                                              foregroundColor: getBtnColor(btnpickup, false, false),
                                              textStyle: const TextStyle(fontSize: 25),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(30.0),
                                              )),
                                          child: const Text('Picked Up'),
                                        )),
                                  ]))
                              : const SizedBox.shrink(),
                          expand && btnpickup == 2
                              ? Padding(
                                  padding: const EdgeInsets.only(bottom: 20),
                                  child: Container(
                                    height: 490 + (140.00 * stopCount),
                                    width: SizeConfig.screenWidth,
                                    decoration: BoxDecoration(
                                      color: Color(Clrs.ltblue),
                                      borderRadius: const BorderRadius.only(bottomRight: Radius.circular(20)),
                                    ),
                                    child: Column(children: [
                                      Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 10),
                                          // child:
                                          // SizedBox(
                                          //     height: 180 * count.toDouble(),
                                          //     width: SizeConfig.screenWidth,
                                          child: Column(children: [
                                            DeliveryArray(0, stopCount, isValid as Function(String p1)),
                                            stopCount > 1 ? DeliveryArray(1, stopCount, isValid as Function(String p1)) : const SizedBox.shrink(),
                                            stopCount > 2 ? DeliveryArray(2, stopCount, isValid as Function(String p1)) : const SizedBox.shrink(),
                                            stopCount > 3 ? DeliveryArray(3, stopCount, isValid as Function(String p1)) : const SizedBox.shrink(),
                                            stopCount > 4 ? DeliveryArray(4, stopCount, isValid as Function(String p1)) : const SizedBox.shrink(),
                                            stopCount > 5 ? DeliveryArray(5, stopCount, isValid as Function(String p1)) : const SizedBox.shrink(),
                                            Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                                child: SizedBox(
                                                  height: 100,
                                                  width: SizeConfig.screenWidth - 60,
                                                  child: TextField(
                                                    controller: trequest,
                                                    maxLines: 5,
                                                    decoration: const InputDecoration(
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
                                                )),
                                          ])),
                                      Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 10),
                                          child: SizedBox(
                                            height: 100,
                                            width: SizeConfig.screenWidth - 60,
                                            child: TextField(
                                              controller: tnote,
                                              maxLines: 5,
                                              decoration: const InputDecoration(
                                                  labelText: 'Note',
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
                                          )),
                                      const SizedBox(height: 20),
                                      Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                                        Container(
                                            height: 60,
                                            width: ((SizeConfig.screenWidth - 80)) / 2,
                                            color: Color(Clrs.ltblue),
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
                                                  )),
                                              child: const Text('Cancel'),
                                            )),
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
                                                  variables.tableStops[widget.idx]['pallets'] = variables.myStops[0]['pallets'];
                                                  variables.tableStops[widget.idx]['boxes'] = variables.myStops[0]['boxes'];
                                                  variables.tableStops[widget.idx]['bags'] = variables.myStops[0]['bags'];
                                                  variables.tableStops[widget.idx]['tubs'] = variables.myStops[0]['tubs'];
                                                  variables.tableStops[widget.idx]['request'] = variables.myStops[0]['request'];
                                                  variables.tableStops[widget.idx]['note'] = variables.myStops[0]['note'];
                                                  variables.tableStops[widget.idx]['status'] = 'Picked Up';
                                                  // Update multi if needed
                                                  if (variables.myStops.length > 1) {
                                                    for (int x = 1; x < variables.myStops.length; x++) {
                                                      List<Map<String, dynamic>> lst = [];
                                                      lst.add({
                                                        'recordid': variables.myStops[x]['recordid'],
                                                        'status': 'Picked Up',
                                                        'time': SubRoutine.getTime(DateTime.now(), false, true),
                                                        'deliverydate': SubRoutine.getDate(DateTime.now()),
                                                        'pallets': variables.myStops[x]['pallets'],
                                                        'boxes': variables.myStops[x]['boxes'],
                                                        'bags': variables.myStops[x]['bags'],
                                                        'tubs': variables.myStops[x]['tubs'],
                                                      });
                                                      await db.dbUpdate(lst, 'Multi', 'recordid');
                                                    }
                                                  }
                                                  // update remote db
                                                  List<Map<String, dynamic>> lst = [];
                                                  lst.add({
                                                    'recordid': variables.myStops[0]['recordid'],
                                                    'status': 'Picked Up',
                                                    'statustime': SubRoutine.getTime(DateTime.now(), false, true),
                                                    'deliverydate': SubRoutine.getDate(DateTime.now()),
                                                    'pallets': variables.myStops[0]['pallets'],
                                                    'boxes': variables.myStops[0]['boxes'],
                                                    'bags': variables.myStops[0]['bags'],
                                                    'tubs': variables.myStops[0]['tubs'],
                                                  });
                                                  await db.dbUpdate(lst, 'Stops', 'recordid');
                                                  if (variables.myStops.length > 1) {
                                                    print('Multi need processing');
                                                  }
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
                                                  )),
                                              child: const Text('Update'),
                                            )),
                                      ])
                                    ]),
                                  ),
                                )
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
                    ])))
            : Padding(
                padding: const EdgeInsets.only(top: 15, left: 20),
                child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                  InkWell(
                      onTap: () {
                        if (variables.tableStops[widget.idx]['status'] != 'Delivered') {
                          setState(() {
                            expand = !expand;
                          });
                        }
                      },
                      child: Column(children: [
                        Container(
                          height: expand
                              ? btndelivered == 2
                                  ? 514
                                  : 180
                              : 104,
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
                                width: (SizeConfig.screenWidth - 20) * 0.422,
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
                                    width: ((SizeConfig.screenWidth - 20) * 0.422) - 15,
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
                                    width: ((SizeConfig.screenWidth - 20) * 0.422) - 15,
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        '${variables.tableStops[widget.idx]['start']} ${variables.tableStops[widget.idx]['end']}',
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: getBackColor(widget.idx, false),
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
                                              (variables.tableStops[widget.idx]['state'].toString().isNotEmpty
                                                  ? variables.tableStops[widget.idx]['state']
                                                  : ' '),
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
                                ? Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                                    SizedBox(
                                        height: 60,
                                        width: ((SizeConfig.screenWidth - 80)) / 2,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            setState(() {
                                              btnpending = 2;
                                              btndelivered = 1;
                                              btnupdate = 0;
                                            });
                                          },
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: getBtnColor(btnpending, true, false),
                                              foregroundColor: getBtnColor(btnpending, false, false),
                                              textStyle: const TextStyle(fontSize: 25),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(30.0),
                                              )),
                                          child: const Text('Pending'),
                                        )),
                                    SizedBox(
                                        height: 60,
                                        width: ((SizeConfig.screenWidth - 50)) / 2,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            setState(() {
                                              btnpending = 1;
                                              btndelivered = 2;
                                              btnupdate = 1;
                                            });
                                          },
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: getBtnColor(btndelivered, true, false),
                                              foregroundColor: getBtnColor(btndelivered, false, false),
                                              textStyle: const TextStyle(fontSize: 25),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(30.0),
                                              )),
                                          child: const Text('Delivered'),
                                        )),
                                  ])
                                : const SizedBox.shrink(),
                            expand && btndelivered == 2
                                ? Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                    child: SizedBox(
                                      height: 100,
                                      width: SizeConfig.screenWidth - 60,
                                      child: TextField(
                                        controller: trequest,
                                        maxLines: 5,
                                        decoration: const InputDecoration(
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
                            expand && btndelivered == 2
                                ? Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                    child: SizedBox(
                                      height: 100,
                                      width: SizeConfig.screenWidth - 60,
                                      child: TextField(
                                        controller: tnote,
                                        maxLines: 5,
                                        decoration: const InputDecoration(
                                            labelText: 'Note',
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
                            expand && btndelivered == 2
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
                                              )),
                                          child: const Text('Cancel'),
                                        )),
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
                                              )),
                                          child: const Text('Update'),
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
                ])));
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

  // updateLocal(int idx, List<Map<String, dynamic>> stp, String table) {
  //   if (idx == 0) {
  //     for (var e in variables.tableStops) {
  //       if (e['recordid'] == stp[0]['recordid']) {
  //         e['driver'] = stp[0]['driver'];
  //         e['deliverydate'] = stp[0]['deliverydate'];
  //         e['statustime'] = stp[0]['statustime'];
  //         e['status'] = stp[0]['status'];
  //         e['pallets'] = stp[0]['pallets'];
  //         e['boxes'] = stp[0]['boxes'];
  //         e['bags'] = stp[0]['bags'];
  //         e['tubs'] = stp[0]['tubs'];
  //         e['request'] = stp[0]['request'];
  //         e['dirty'] = stp[0]['dirty'];
  //       }
  //     }
  //   } else {
  //     for (var e in multi) {
  //       if (e['recordid'] == stp[0]['recordid']) {
  //         e['driver'] = stp[0]['driver'];
  //         e['deliverydate'] = stp[0]['deliverydate'];
  //         e['statustime'] = stp[0]['statustime'];
  //         e['status'] = stp[0]['status'];
  //         e['pallets'] = stp[0]['pallets'];
  //         e['boxes'] = stp[0]['boxes'];
  //         e['bags'] = stp[0]['bags'];
  //         e['tubs'] = stp[0]['tubs'];
  //         e['request'] = stp[0]['request'];
  //         e['dirty'] = stp[0]['dirty'];
  //       }
  //     }
  //   }
  //   setState(() {});
  // }

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
          rtn = Color(Clrs.dkgray);
          break;
        default:
          rtn = Color(Clrs.ltgray);
          break;
      }
    } else {
      switch (variables.tableStops[idx]['status']) {
        case 'Picked Up':
          rtn = Color(Clrs.dkblue);
          break;
        default:
          rtn = Color(Clrs.blue);
          break;
      }
    }
  } else {
    switch (variables.tableStops[idx]['type']) {
      case 'DDU':
        switch (variables.tableStops[idx]['status']) {
          case 'Pending':
            rtn = Color(Clrs.black);
            break;
          case 'Skipped':
            rtn = Color(Clrs.dkgray);
            break;
          case 'Delivered':
            rtn = Color(Clrs.white);
            break;
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
  Color rtn = Color(variables.tableStops[idx]['type'] == 'DDU' ? Clrs.black : Clrs.white);
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
