// ignore_for_file: file_names, camel_case_types

import 'package:flutter/material.dart';
import 'package:ids_driver/Subs/SizeConfig.dart';

import '../../Subs/SubRoutines.dart';
import '../../Subs/localColors.dart';

class training extends StatefulWidget {
  const training({super.key});

  @override
  State<training> createState() => trainingState();
}

class trainingState extends State<training> {
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
                    'Training',
                    style: TextStyle(fontSize: 18),
                  ),
                ]),
              ),
              Expanded(
                  child: ListView(children: [
                // Container(
                //     height: 125,
                //     width: SizeConfig.screenWidth,
                //     color: Color(Clrs.dkblue),
                //     child: Column(children: [
                //       const SizedBox(height: 10),
                //       Row(children: [
                //         Container(height: 35, width: 55, color: Colors.transparent),
                //         Container(
                //             height: 35,
                //             width: SizeConfig.screenWidth - 110,
                //             color: Colors.transparent,
                //             child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                //               Text('IDS Driver App',
                //                   style: TextStyle(
                //                       fontSize: SubRoutine.getFontSizeString(SizeConfig.screenWidth - 130, 'Ideal Delivery Services'), color: Colors.white),
                //                   textAlign: TextAlign.center)
                //             ])),
                //         Container(
                //           height: 35,
                //           width: 55,
                //           color: Colors.transparent,
                //           child: IconButton(
                //               onPressed: () {
                //                 Navigator.pop(context);
                //               },
                //               icon: const Icon(Icons.menu, color: Colors.white)),
                //         )
                //       ]),
                //       Row(children: [
                //         Container(
                //             height: 35,
                //             width: SizeConfig.screenWidth,
                //             child: Text('Ideal Delivery Services',
                //                 style: TextStyle(
                //                     fontSize: SubRoutine.getFontSizeString(SizeConfig.screenWidth - 120, 'Ideal Delivery Services'), color: Colors.white),
                //                 textAlign: TextAlign.center)),
                //       ]),
                //       Row(children: [
                //         Container(
                //             height: 35,
                //             width: SizeConfig.screenWidth,
                //             child: Text('FAQ / Training',
                //                 style: TextStyle(
                //                     fontSize: SubRoutine.getFontSizeString(SizeConfig.screenWidth - 120, 'Ideal Delivery Services'), color: Colors.white),
                //                 textAlign: TextAlign.center)),
                //       ]),
                //     ])),
                Row(children: [
                  Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: TextButton(
                          onPressed: () {},
                          child: Text('Terms - DDU\'s, Pick-up, etc,',
                              style: TextStyle(
                                  fontSize: SubRoutine.getFontSizeString(SizeConfig.screenWidth - 120, 'Ideal Delivery Services'), color: Color(Clrs.dkblue)))))
                ]),
                Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: TextButton(
                        onPressed: () {},
                        child: Text('Understanding the Operation DDU\'s to Post Office, ect.',
                            style: TextStyle(
                                fontSize: SubRoutine.getFontSizeString(SizeConfig.screenWidth - 120, 'Ideal Delivery Services'), color: Color(Clrs.dkblue))))),
                Row(children: [
                  Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: TextButton(
                          onPressed: () {},
                          child: Text('Logging Hours',
                              style: TextStyle(
                                  fontSize: SubRoutine.getFontSizeString(SizeConfig.screenWidth - 120, 'Ideal Delivery Services'),
                                  color: Color(Clrs.dkblue))))),
                ]),
                Row(children: [
                  Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: TextButton(
                          onPressed: () {},
                          child: Text('Truck Inspection',
                              style: TextStyle(
                                  fontSize: SubRoutine.getFontSizeString(SizeConfig.screenWidth - 120, 'Ideal Delivery Services'),
                                  color: Color(Clrs.dkblue))))),
                ]),
                Row(children: [
                  Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: TextButton(
                          onPressed: () {},
                          child: Text('Payroll',
                              style: TextStyle(
                                  fontSize: SubRoutine.getFontSizeString(SizeConfig.screenWidth - 120, 'Ideal Delivery Services'),
                                  color: Color(Clrs.dkblue))))),
                ]),
                Row(children: [
                  Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: TextButton(
                          onPressed: () {},
                          child: Text('Job Expectations',
                              style: TextStyle(
                                  fontSize: SubRoutine.getFontSizeString(SizeConfig.screenWidth - 120, 'Ideal Delivery Services'),
                                  color: Color(Clrs.dkblue))))),
                ]),
                Row(children: [
                  Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: TextButton(
                          onPressed: () {},
                          child: Text('Terms and Conditions',
                              style: TextStyle(
                                  fontSize: SubRoutine.getFontSizeString(SizeConfig.screenWidth - 120, 'Ideal Delivery Services'),
                                  color: Color(Clrs.dkblue))))),
                ]),
                Padding(
                    padding: const EdgeInsets.only(top: 10, left: 15),
                    child: Text('Terms',
                        style: TextStyle(
                            fontSize: SubRoutine.getFontSizeString(SizeConfig.screenWidth - 120, 'Ideal Delivery Services'), color: Color(Clrs.dkblue)))),
                Padding(
                    padding: const EdgeInsets.only(top: 20, left: 25, right: 10),
                    child: Container(
                      height: 245,
                      width: SizeConfig.screenWidth - 64,
                      color: Colors.transparent,
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text('DDU\'s',
                                style: TextStyle(
                                    fontSize: SubRoutine.getFontSizeString(SizeConfig.screenWidth - 120, 'Ideal Delivery Services'), color: Color(Clrs.taco)))),
                        Padding(
                            padding: const EdgeInsets.only(top: 10, left: 20, right: 10),
                            child: Text(
                                'DDU Stands for Direct Delivery Unit. These are Gaylords\' that are delivered to specific post offices. They are labels with destination name and ZIP code.',
                                style: TextStyle(fontSize: SubRoutine.getFontSizeString(SizeConfig.screenWidth - 120, 'Ideal Delivery Services')))),
                      ]),
                    )),
                Padding(
                    padding: const EdgeInsets.only(top: 20, left: 25, right: 10),
                    child: Container(
                      height: 160,
                      width: SizeConfig.screenWidth - 64,
                      color: Colors.transparent,
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Text('Gaylord',
                                style: TextStyle(
                                    fontSize: SubRoutine.getFontSizeString(SizeConfig.screenWidth - 120, 'Ideal Delivery Services'), color: Color(Clrs.taco)))),
                        Padding(
                            padding: const EdgeInsets.only(top: 10, left: 20, right: 10),
                            child: Text('A gaylord is a cardboard box that sets on top oa a pallet. They are Typicaly 3-7 ft tall.',
                                style: TextStyle(fontSize: SubRoutine.getFontSizeString(SizeConfig.screenWidth - 120, 'Ideal Delivery Services')))),
                      ]),
                    )),
                Padding(
                    padding: const EdgeInsets.only(top: 20, left: 25, right: 10),
                    child: Container(
                      height: 185,
                      width: SizeConfig.screenWidth - 64,
                      color: Colors.transparent,
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Text('Pallet',
                                style: TextStyle(
                                    fontSize: SubRoutine.getFontSizeString(SizeConfig.screenWidth - 120, 'Ideal Delivery Services'), color: Color(Clrs.taco)))),
                        Padding(
                            padding: const EdgeInsets.only(top: 10, left: 20, right: 10),
                            child: Text(
                                'A Pallet is a plastic or wood which supports goods in a stable fashion while being lifted by a pallet jack or forklift',
                                style: TextStyle(fontSize: SubRoutine.getFontSizeString(SizeConfig.screenWidth - 120, 'Ideal Delivery Services')))),
                      ]),
                    )),
                Padding(
                    padding: const EdgeInsets.only(top: 20, left: 25),
                    child: Container(
                      height: 100,
                      width: SizeConfig.screenWidth - 64,
                      color: Colors.transparent,
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Text('Pickup Forms',
                                style: TextStyle(
                                    fontSize: SubRoutine.getFontSizeString(SizeConfig.screenWidth - 120, 'Ideal Delivery Services'), color: Color(Clrs.taco)))),
                        Padding(
                            padding: const EdgeInsets.only(top: 10, left: 20, right: 10),
                            child: Text('These forms are required by UPS.',
                                style: TextStyle(fontSize: SubRoutine.getFontSizeString(SizeConfig.screenWidth - 120, 'Ideal Delivery Services')))),
                      ]),
                    )),
                Padding(
                    padding: const EdgeInsets.only(top: 20, left: 25, right: 10),
                    child: Container(
                      height: 120,
                      width: SizeConfig.screenWidth - 64,
                      color: Colors.transparent,
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Text('UPS Mail Inovations',
                                style: TextStyle(
                                    fontSize: SubRoutine.getFontSizeString(SizeConfig.screenWidth - 120, 'Ideal Delivery Services'), color: Color(Clrs.taco)))),
                        const Padding(
                            padding: EdgeInsets.only(top: 10, left: 20, right: 10),
                            child: Text('These forms are required by UPS.', style: TextStyle(fontSize: 20))),
                      ]),
                    )),
                Padding(
                    padding: const EdgeInsets.only(top: 20, left: 25, right: 10),
                    child: Container(
                      height: 320,
                      width: SizeConfig.screenWidth - 64,
                      color: Colors.transparent,
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Text('Understanding the Operation DDU to Post Office, ect',
                                style: TextStyle(
                                    fontSize: SubRoutine.getFontSizeString(SizeConfig.screenWidth - 120, 'Ideal Delivery Services'), color: Color(Clrs.taco)))),
                        Padding(
                            padding: const EdgeInsets.only(top: 10, left: 20, right: 10),
                            child: Text(
                                'Dispatch will notify all drivers when UPS DDU\'s are Ready to be Picked up.\nDrivers will drive their vehicle to the truck they are assigned. the truck may be located at UPS, the yard or near UPS.',
                                style: TextStyle(fontSize: SubRoutine.getFontSizeString(SizeConfig.screenWidth - 120, 'Ideal Delivery Services')))),
                      ]),
                    )),
              ])),
            ])));
  }
}
