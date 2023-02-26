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
  final VoidCallback? callback;

  @override
  State<DeliveryArray> createState() => DeliveryArrayState();
}

class DeliveryArrayState extends State<DeliveryArray> {
  int pallets = 0;
  int boxes = 0;
  int bags = 0;
  int tubs = 0;

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
    widget.callback!();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(height: 20),
      Container(
        height: 135,
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
            height: 135,
            width: SizeConfig.screenWidth - 40,
            child: Padding(
              padding: const EdgeInsets.only(left: 10, top: 5),
              child: Text(
                variables.myStops[widget.idx]['company'],
                style: const TextStyle(fontSize: 20),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 35),
            child: Row(children: [
              Container(
                  height: 100,
                  width: (SizeConfig.screenWidth - 40) / 4,
                  decoration: BoxDecoration(
                    //color: Color(Clrs.laser),
                    border: Border.all(color: Color(Clrs.black), width: 1),
                  ),
                  child: Stack(children: [
                    SizedBox(
                      height: 100,
                      width: (SizeConfig.screenWidth - 40) / 4,
                      child: const Padding(
                        padding: EdgeInsets.only(top: 3),
                        child: Text('Pallets', style: TextStyle(fontSize: 15), textAlign: TextAlign.center),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(top: 10, left: ((SizeConfig.screenWidth - 40) / 4) / 4 - 5),
                        child: IconButton(
                            onPressed: () {
                              setState(() {
                                variables.myStops[widget.idx]['pallets']++;
                              });
                              Verified();
                            },
                            icon: const Icon(
                              Icons.expand_less,
                              size: 34,
                            ))),
                    // ),
                    SizedBox(
                        height: 70,
                        width: (SizeConfig.screenWidth - 40) / 4,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 47),
                          child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                            Text(variables.myStops[widget.idx]['pallets'].toString(), style: const TextStyle(fontSize: 20)),
                          ]),
                        )),
                    Padding(
                        padding: EdgeInsets.only(
                          top: 60,
                          left: ((SizeConfig.screenWidth - 40) / 4) / 4 - 5,
                        ),
                        child: IconButton(
                            onPressed: () {
                              setState(() {
                                variables.myStops[widget.idx]['pallets']--;
                                if (variables.myStops[widget.idx]['pallets'] < 0) {
                                  variables.myStops[widget.idx]['pallets'] = 0;
                                }
                              });
                              Verified();
                            },
                            icon: const Icon(Icons.expand_more, size: 34))),
                    // ),
                  ])),
              Container(
                  height: 100,
                  width: (SizeConfig.screenWidth - 40) / 4,
                  decoration: BoxDecoration(
                    //color: Color(Clrs.laser),
                    border: Border.all(color: Color(Clrs.black), width: 1),
                  ),
                  child: Stack(children: [
                    SizedBox(
                      height: 100,
                      width: (SizeConfig.screenWidth - 40) / 4,
                      child: Padding(
                          padding: const EdgeInsets.only(top: 3), child: Text('Boxes', style: const TextStyle(fontSize: 15), textAlign: TextAlign.center)),
                    ),
                    Padding(
                        padding: EdgeInsets.only(top: 10, left: ((SizeConfig.screenWidth - 40) / 4) / 4 - 5),
                        child: IconButton(
                            onPressed: () {
                              setState(() {
                                variables.myStops[widget.idx]['boxes']++;
                              });
                              Verified;
                            },
                            icon: const Icon(
                              Icons.expand_less,
                              size: 34,
                            ))),
                    SizedBox(
                        height: 70,
                        width: (SizeConfig.screenWidth - 40) / 4,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 47),
                          child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                            Text(variables.myStops[widget.idx]['boxes'].toString(), style: const TextStyle(fontSize: 20)),
                          ]),
                        )),
                    Padding(
                        padding: EdgeInsets.only(
                          top: 60,
                          left: ((SizeConfig.screenWidth - 40) / 4) / 4 - 5,
                        ),
                        child: IconButton(
                            onPressed: () {
                              setState(() {
                                variables.myStops[widget.idx]['boxes']--;
                                if (variables.myStops[widget.idx]['boxes'] < 0) {
                                  variables.myStops[widget.idx]['boxes'] = 0;
                                }
                              });
                              Verified;
                            },
                            icon: const Icon(Icons.expand_more, size: 34))),
                  ])),
              Container(
                  height: 100,
                  width: (SizeConfig.screenWidth - 40) / 4,
                  decoration: BoxDecoration(
                    //color: Color(Clrs.laser),
                    border: Border.all(color: Color(Clrs.black), width: 1),
                  ),
                  child: Stack(children: [
                    SizedBox(
                      height: 100,
                      width: (SizeConfig.screenWidth - 40) / 4,
                      child: Padding(
                          padding: const EdgeInsets.only(top: 3), child: Text('Bags', style: const TextStyle(fontSize: 15), textAlign: TextAlign.center)),
                    ),
                    Padding(
                        padding: EdgeInsets.only(top: 10, left: ((SizeConfig.screenWidth - 40) / 4) / 4 - 5),
                        child: IconButton(
                            onPressed: () {
                              setState(() {
                                variables.myStops[widget.idx]['bags']++;
                              });
                              Verified;
                            },
                            icon: const Icon(
                              Icons.expand_less,
                              size: 34,
                            ))),
                    // ),
                    SizedBox(
                        height: 70,
                        width: (SizeConfig.screenWidth - 40) / 4,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 47),
                          child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                            Text(variables.myStops[widget.idx]['bags'].toString(), style: const TextStyle(fontSize: 20)),
                          ]),
                        )),
                    Padding(
                        padding: EdgeInsets.only(
                          top: 60,
                          left: ((SizeConfig.screenWidth - 40) / 4) / 4 - 5,
                        ),
                        child: IconButton(
                            onPressed: () {
                              setState(() {
                                variables.myStops[widget.idx]['bags']--;
                                if (variables.myStops[widget.idx]['bags'] < 0) {
                                  variables.myStops[widget.idx]['bags'] = 0;
                                }
                              });
                              Verified;
                            },
                            icon: const Icon(Icons.expand_more, size: 34))),
                    // ),
                  ])),
              Container(
                  height: 100,
                  width: (SizeConfig.screenWidth - 40) / 4,
                  decoration: BoxDecoration(
                    //color: Color(Clrs.laser),
                    border: Border.all(color: Color(Clrs.black), width: 1),
                  ),
                  child: Stack(children: [
                    SizedBox(
                      height: 100,
                      width: (SizeConfig.screenWidth - 40) / 4,
                      child: Padding(
                          padding: const EdgeInsets.only(top: 3), child: Text('Tubs', style: const TextStyle(fontSize: 15), textAlign: TextAlign.center)),
                    ),
                    Padding(
                        padding: EdgeInsets.only(top: 10, left: ((SizeConfig.screenWidth - 40) / 4) / 4 - 5),
                        child: IconButton(
                            onPressed: () {
                              setState(() {
                                variables.myStops[widget.idx]['tubs']++;
                              });
                              Verified;
                            },
                            icon: const Icon(
                              Icons.expand_less,
                              size: 34,
                            ))),
                    // ),
                    SizedBox(
                        height: 70,
                        width: (SizeConfig.screenWidth - 40) / 4,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 47),
                          child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                            Text(variables.myStops[widget.idx]['tubs'].toString(), style: const TextStyle(fontSize: 20)),
                          ]),
                        )),
                    Padding(
                        padding: EdgeInsets.only(
                          top: 60,
                          left: ((SizeConfig.screenWidth - 40) / 4) / 4 - 5,
                        ),
                        child: IconButton(
                            onPressed: () {
                              setState(() {
                                variables.myStops[widget.idx]['tubs']--;
                                if (variables.myStops[widget.idx]['tubs'] < 0) {
                                  variables.myStops[widget.idx]['tubs'] = 0;
                                }
                              });
                              Verified;
                            },
                            icon: const Icon(Icons.expand_more, size: 34))),
                    // ),
                  ])),
            ]),
          ),
        ]),
      ),
    ]);
  }
}
