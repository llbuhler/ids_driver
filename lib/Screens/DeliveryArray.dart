// ignore_for_file: non_constant_identifier_names, file_names

import 'package:flutter/material.dart';
import 'package:ids_driver/variables.dart';
import '../Subs/SizeConfig.dart';
import '../Subs/localColors.dart';
import 'myRoute.dart';

//List<Map<String, dynamic>> myStops = [];

class DeliveryArray extends StatefulWidget {
  const DeliveryArray(this.idx, this.count, this.callback, {super.key});
  final int idx;
  final int count;
  final Function(String) callback;

  @override
  State<DeliveryArray> createState() => DeliveryArrayState();
}

class DeliveryArrayState extends State<DeliveryArray> {
  int pallets = 0;
  int boxes = 0;
  int bags = 0;
  int tubs = 0;

  @override
  initState() {
    super.initState();
    // variables.myStops[widget.idx]['pallets'] = int.parse(variables.tableStops[widget.idx]['pallets']);
    // variables.myStops[widget.idx]['boxes'] = variables.tableStops[widget.idx]['boxes'];
    // variables.myStops[widget.idx]['bags'] = variables.tableStops[widget.idx]['bags'];
    // variables.myStops[widget.idx]['tubs'] = variables.tableStops[widget.idx]['tubs'];
    variables.myStops[widget.idx]['request'] = variables.tableStops[widget.idx]['request'];
    variables.myStops[widget.idx]['note'] = variables.tableStops[widget.idx]['note'];
  }

  List<Map<String, dynamic>> template = [];

  Verified() {
    bool rtn = false;
    for (var e in variables.myStops) {
      if (e['pallets'] > 0) {
        rtn = true;
      }
      if (e['boxes'] > 0) {
        rtn = true;
      }
      if (e['bags'] > 0) {
        rtn = true;
      }
      if (e['tubs'] > 0) {
        rtn = true;
      }
    }
    updateOk = rtn;
    widget.callback(rtn.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const SizedBox(height: 20),
      Container(
        height: 175,
        width: SizeConfig.screenWidth - 40,
        decoration: BoxDecoration(
            color: Color(Clrs.ltgray),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(widget.idx == 0 ? 15 : 0),
              topRight: Radius.circular(widget.idx == 0 ? 15 : 0),
              bottomLeft: Radius.circular(widget.count == widget.idx + 1 ? 15 : 0),
              bottomRight: Radius.circular(widget.count == widget.idx + 1 ? 15 : 0),
            )),
        child: Stack(children: [
          SizedBox(
            // Company
            height: 175,
            width: SizeConfig.screenWidth - 40,
            child: Padding(
              padding: const EdgeInsets.only(left: 10, top: 5),
              child: Text(
                widget.idx > 0 ? variables.tableMulti[widget.idx - 1]['company'] : variables.myStops[widget.idx]['company'],
                style: const TextStyle(fontSize: 20),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 35),
            child: Row(children: [
              Container(
                height: 175,
                width: (SizeConfig.screenWidth - 40) / 4,
                decoration: BoxDecoration(
                  //color: Color(Clrs.laser),
                  border: Border.all(color: Color(Clrs.black), width: 1),
                ),
                child: Stack(children: [
                  SizedBox(
                      height: 175,
                      width: (SizeConfig.screenWidth - 40) / 4,
                      child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.center, children: const [
                        Text('Pallets', style: TextStyle(fontSize: 15), textAlign: TextAlign.center),
                      ])),
                  SizedBox(
                      height: 175,
                      width: (SizeConfig.screenWidth - 40) / 4,
                      child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.center, children: [
                        SizedBox(
                            height: 138,
                            width: (SizeConfig.screenWidth - 40) / 4,
                            child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
                              Text(
                                variables.myStops[widget.idx]['pallets'].toString(),
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Color(Clrs.black),
                                ),
                              )
                            ])),
                      ])),
                  SizedBox(
                    height: 175,
                    width: (SizeConfig.screenWidth - 40) / 4,
                    child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.center, children: [
                      InkWell(
                          onTap: () {
                            setState(() {
                              variables.myStops[widget.idx]['pallets']++;
                              Verified();
                            });
                          },
                          child: SizedBox(
                            height: 69,
                            width: SizeConfig.screenWidth - 40,
                            child: Icon(
                              Icons.expand_less,
                              size: 30,
                              color: Color(Clrs.black),
                            ),
                            //color: Color(Clrs.red),
                          )),
                      InkWell(
                        onTap: () {
                          setState(() {
                            variables.myStops[widget.idx]['pallets']--;
                            variables.myStops[widget.idx]['pallets'] < 0 ? variables.myStops[widget.idx]['pallets'] = 0 : const SizedBox.shrink();
                            Verified();
                          });
                        },
                        child: SizedBox(
                          height: 69,
                          width: SizeConfig.screenWidth - 40,
                          child: Icon(
                            Icons.expand_more,
                            size: 30,
                            color: Color(Clrs.black),
                          ),
                          //color: Color(Clrs.green),
                        ),
                      ),
                    ]),
                  ),
                ]),
              ),
              Container(
                height: 175,
                width: (SizeConfig.screenWidth - 40) / 4,
                decoration: BoxDecoration(
                  //color: Color(Clrs.laser),
                  border: Border.all(color: Color(Clrs.black), width: 1),
                ),
                child: Stack(children: [
                  SizedBox(
                      height: 175,
                      width: (SizeConfig.screenWidth - 40) / 4,
                      child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.center, children: const [
                        Text('Boxes', style: TextStyle(fontSize: 15), textAlign: TextAlign.center),
                      ])),
                  SizedBox(
                      height: 175,
                      width: (SizeConfig.screenWidth - 40) / 4,
                      child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.center, children: [
                        SizedBox(
                            height: 138,
                            width: (SizeConfig.screenWidth - 40) / 4,
                            child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
                              Text(
                                variables.myStops[widget.idx]['boxes'].toString(),
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Color(Clrs.black),
                                ),
                              )
                            ])),
                      ])),
                  SizedBox(
                    height: 175,
                    width: (SizeConfig.screenWidth - 40) / 4,
                    child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.center, children: [
                      InkWell(
                          onTap: () {
                            setState(() {
                              variables.myStops[widget.idx]['boxes']++;
                              Verified();
                            });
                          },
                          child: SizedBox(
                            height: 69,
                            width: SizeConfig.screenWidth - 40,
                            child: Icon(
                              Icons.expand_less,
                              size: 30,
                              color: Color(Clrs.black),
                            ),
                            //color: Color(Clrs.red),
                          )),
                      InkWell(
                        onTap: () {
                          setState(() {
                            variables.myStops[widget.idx]['boxes']--;
                            variables.myStops[widget.idx]['boxes'] < 0 ? variables.myStops[widget.idx]['pallets'] = 0 : const SizedBox.shrink();
                            Verified();
                          });
                        },
                        child: SizedBox(
                          height: 69,
                          width: SizeConfig.screenWidth - 40,
                          child: Icon(
                            Icons.expand_more,
                            size: 30,
                            color: Color(Clrs.black),
                          ),
                          //color: Color(Clrs.green),
                        ),
                      ),
                    ]),
                  ),
                ]),
              ),
              Container(
                height: 175,
                width: (SizeConfig.screenWidth - 40) / 4,
                decoration: BoxDecoration(
                  //color: Color(Clrs.laser),
                  border: Border.all(color: Color(Clrs.black), width: 1),
                ),
                child: Stack(children: [
                  SizedBox(
                      height: 175,
                      width: (SizeConfig.screenWidth - 40) / 4,
                      child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.center, children: const [
                        Text('Bags', style: TextStyle(fontSize: 15), textAlign: TextAlign.center),
                      ])),
                  SizedBox(
                      height: 175,
                      width: (SizeConfig.screenWidth - 40) / 4,
                      child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.center, children: [
                        SizedBox(
                            height: 138,
                            width: (SizeConfig.screenWidth - 40) / 4,
                            child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
                              Text(
                                variables.myStops[widget.idx]['bags'].toString(),
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Color(Clrs.black),
                                ),
                              )
                            ])),
                      ])),
                  SizedBox(
                    height: 175,
                    width: (SizeConfig.screenWidth - 40) / 4,
                    child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.center, children: [
                      InkWell(
                          onTap: () {
                            setState(() {
                              variables.myStops[widget.idx]['bags']++;
                              Verified();
                            });
                          },
                          child: SizedBox(
                            height: 69,
                            width: SizeConfig.screenWidth - 40,
                            child: Icon(
                              Icons.expand_less,
                              size: 30,
                              color: Color(Clrs.black),
                            ),
                            //color: Color(Clrs.red),
                          )),
                      InkWell(
                        onTap: () {
                          setState(() {
                            variables.myStops[widget.idx]['bags']--;
                            variables.myStops[widget.idx]['bags'] < 0 ? variables.myStops[widget.idx]['pallets'] = 0 : const SizedBox.shrink();
                          });
                          Verified();
                        },
                        child: SizedBox(
                          height: 69,
                          width: SizeConfig.screenWidth - 40,
                          child: Icon(
                            Icons.expand_more,
                            size: 30,
                            color: Color(Clrs.black),
                          ),
                          //color: Color(Clrs.green),
                        ),
                      ),
                    ]),
                  ),
                ]),
              ),
              Container(
                height: 175,
                width: (SizeConfig.screenWidth - 40) / 4,
                decoration: BoxDecoration(
                  //color: Color(Clrs.laser),
                  border: Border.all(color: Color(Clrs.black), width: 1),
                ),
                child: Stack(children: [
                  SizedBox(
                      height: 175,
                      width: (SizeConfig.screenWidth - 40) / 4,
                      child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.center, children: const [
                        Text('Tubs', style: TextStyle(fontSize: 15), textAlign: TextAlign.center),
                      ])),
                  SizedBox(
                      height: 175,
                      width: (SizeConfig.screenWidth - 40) / 4,
                      child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.center, children: [
                        SizedBox(
                            height: 138,
                            width: (SizeConfig.screenWidth - 40) / 4,
                            child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
                              Text(
                                variables.myStops[widget.idx]['tubs'].toString(),
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Color(Clrs.black),
                                ),
                              )
                            ])),
                      ])),
                  SizedBox(
                    height: 175,
                    width: (SizeConfig.screenWidth - 40) / 4,
                    child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.center, children: [
                      InkWell(
                          onTap: () {
                            setState(() {
                              variables.myStops[widget.idx]['tubs']++;
                              Verified();
                            });
                          },
                          child: SizedBox(
                            height: 69,
                            width: SizeConfig.screenWidth - 40,
                            child: Icon(
                              Icons.expand_less,
                              size: 30,
                              color: Color(Clrs.black),
                            ),
                            //color: Color(Clrs.red),
                          )),
                      InkWell(
                        onTap: () {
                          setState(() {
                            variables.myStops[widget.idx]['tubs']--;
                            variables.myStops[widget.idx]['tubs'] < 0 ? variables.myStops[widget.idx]['pallets'] = 0 : const SizedBox.shrink();
                            Verified();
                          });
                        },
                        child: SizedBox(
                          height: 69,
                          width: SizeConfig.screenWidth - 40,
                          child: Icon(
                            Icons.expand_more,
                            size: 30,
                            color: Color(Clrs.black),
                          ),
                          //color: Color(Clrs.green),
                        ),
                      ),
                    ]),
                  ),
                ]),
              ),
            ]),
          ),
        ]),
      ),
    ]);
  }
}
