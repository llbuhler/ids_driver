import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:ids_driver/Subs/SizeConfig.dart';
import 'package:ids_driver/variables.dart';
import '../Subs/dbFirebasek.dart';
import '../Subs/SubRoutines.dart';
import '../Subs/localColors.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => ProfileState();
}

class ProfileState extends State<Profile> {
  TextEditingController tecstreet = TextEditingController();
  TextEditingController teccity = TextEditingController();
  TextEditingController tecstate = TextEditingController();
  TextEditingController teczipcode = TextEditingController();
  TextEditingController tecphone = TextEditingController();
  TextEditingController tecemail = TextEditingController();

  @override
  void initState() {
    super.initState();
    tecstreet.text = variables.tablecurrentEmployee[0]['street'] ?? '';
    teccity.text = variables.tablecurrentEmployee[0]['city'] ?? '';
    tecstate.text = variables.tablecurrentEmployee[0]['state'] ?? '';
    teczipcode.text = variables.tablecurrentEmployee[0]['zipcode'] ?? '';
    tecphone.text = variables.tablecurrentEmployee[0]['phone'] ?? '';
    tecemail.text = variables.tablecurrentEmployee[0]['Email'] ?? '';
  }

  bool update = false;
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
                'My Profile',
                style: TextStyle(fontSize: 18),
              ),
            ]),
          ),
          SizedBox(
              height: SizeConfig.screenHeight - 85,
              width: SizeConfig.screenWidth,
              child: Column(children: [
                Expanded(
                  child: ListView(children: [
                    Padding(
                        padding: const EdgeInsets.only(top: 15, left: 16),
                        child: Row(children: [
                          SizedBox(
                              height: 40,
                              width: 70,
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [Text('First:', style: TextStyle(fontSize: SubRoutine.getFontSizeString(70, 'Street:'), color: Colors.black))])),
                          const SizedBox(width: 10.0),
                          Container(
                              height: 40,
                              width: SizeConfig.screenWidth - 110,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                border: Border.all(color: Color(Clrs.dkblue), width: 2),
                              ),
                              child: Padding(
                                  padding: const EdgeInsets.only(left: 10, top: 5),
                                  child: Text(variables.tablecurrentEmployee[0]['FirstName'],
                                      style: TextStyle(
                                          fontSize: SubRoutine.getFontSizeString(SizeConfig.screenWidth - 110, 'AAAAAAAAAAAAAAAA'), color: Colors.black)))),
                        ])),
                    Padding(
                        padding: const EdgeInsets.only(top: 15, left: 16),
                        child: Row(children: [
                          SizedBox(
                              height: 40,
                              width: 70,
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [Text('Last:', style: TextStyle(fontSize: SubRoutine.getFontSizeString(70, 'Street:'), color: Colors.black))])),
                          const SizedBox(width: 10),
                          Container(
                              height: 40,
                              width: SizeConfig.screenWidth - 110,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                border: Border.all(color: Color(Clrs.dkblue), width: 2),
                              ),
                              child: Padding(
                                  padding: const EdgeInsets.only(left: 10, top: 5),
                                  child: Text(variables.tablecurrentEmployee[0]['LastName'],
                                      style: TextStyle(
                                          fontSize: SubRoutine.getFontSizeString(SizeConfig.screenWidth - 110, 'AAAAAAAAAAAAAAAA'), color: Colors.black)))),
                        ])),
                    Padding(
                        padding: const EdgeInsets.only(top: 15, left: 16),
                        child: Row(children: [
                          SizedBox(
                              height: 40,
                              width: 70,
                              child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                                Text('Street:',
                                    style: TextStyle(fontSize: SubRoutine.getFontSizeString(70, 'Street:'), color: Colors.black), textAlign: TextAlign.left)
                              ])),
                          const SizedBox(width: 10),
                          Container(
                              height: 40,
                              width: SizeConfig.screenWidth - 110,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                border: Border.all(color: Color(Clrs.dkblue), width: 2),
                              ),
                              child: Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: TextField(
                                    controller: tecstreet,
                                    style: TextStyle(fontSize: SubRoutine.getFontSizeString(SizeConfig.screenWidth - 110, 'AAAAAAAAAAAAAAAA')),
                                    onChanged: (value) {
                                      update = true;
                                      setState(() {});
                                    },
                                  ))),
                        ])),
                    Padding(
                        padding: const EdgeInsets.only(top: 15, left: 16),
                        child: Row(children: [
                          SizedBox(
                              height: 40,
                              width: 70,
                              child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                                Text('City:',
                                    style: TextStyle(fontSize: SubRoutine.getFontSizeString(70, 'Street:'), color: Colors.black), textAlign: TextAlign.left)
                              ])),
                          const SizedBox(width: 10),
                          Container(
                              height: 40,
                              width: SizeConfig.screenWidth - 110,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                border: Border.all(color: Color(Clrs.dkblue), width: 2),
                              ),
                              child: Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: TextField(
                                      controller: teccity,
                                      style: TextStyle(fontSize: SubRoutine.getFontSizeString(SizeConfig.screenWidth - 110, 'AAAAAAAAAAAAAAAA')),
                                      onChanged: (value) {
                                        update = true;
                                        setState(() {});
                                      }))),
                        ])),
                    Padding(
                        padding: const EdgeInsets.only(top: 15, left: 16),
                        child: Row(children: [
                          SizedBox(
                              height: 40,
                              width: 70,
                              child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                                Text('State:',
                                    style: TextStyle(fontSize: SubRoutine.getFontSizeString(70, 'Street:'), color: Colors.black), textAlign: TextAlign.left)
                              ])),
                          const SizedBox(width: 10),
                          Container(
                              height: 40,
                              width: SizeConfig.screenWidth - 110,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                border: Border.all(color: Color(Clrs.dkblue), width: 2),
                              ),
                              child: Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: TextField(
                                      controller: tecstate,
                                      style: TextStyle(fontSize: SubRoutine.getFontSizeString(SizeConfig.screenWidth - 110, 'AAAAAAAAAAAAAAAA')),
                                      onChanged: (value) {
                                        update = true;
                                        setState(() {});
                                      }))),
                        ])),
                    Padding(
                        padding: const EdgeInsets.only(top: 15, left: 16),
                        child: Row(children: [
                          SizedBox(
                              height: 40,
                              width: 70,
                              child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                                Text('Zip:',
                                    style: TextStyle(fontSize: SubRoutine.getFontSizeString(70, 'Street:'), color: Colors.black), textAlign: TextAlign.left)
                              ])),
                          const SizedBox(width: 10),
                          Container(
                              height: 40,
                              width: SizeConfig.screenWidth - 110,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                border: Border.all(color: Color(Clrs.dkblue), width: 2),
                              ),
                              child: Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: TextField(
                                      controller: teczipcode,
                                      style: TextStyle(fontSize: SubRoutine.getFontSizeString(SizeConfig.screenWidth - 110, 'AAAAAAAAAAAAAAAA')),
                                      onChanged: (value) {
                                        update = true;
                                        setState(() {});
                                      }))),
                        ])),
                    Padding(
                        padding: const EdgeInsets.only(top: 15, left: 16),
                        child: Row(children: [
                          SizedBox(
                              height: 40,
                              width: 70,
                              child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                                Text('Phone:',
                                    style: TextStyle(fontSize: SubRoutine.getFontSizeString(65, 'Street:'), color: Colors.black), textAlign: TextAlign.left)
                              ])),
                          const SizedBox(width: 10),
                          Container(
                              height: 40,
                              width: SizeConfig.screenWidth - 110,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                border: Border.all(color: Color(Clrs.dkblue), width: 2),
                              ),
                              child: Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: TextField(
                                      controller: tecphone,
                                      style: TextStyle(fontSize: SubRoutine.getFontSizeString(SizeConfig.screenWidth - 120, 'AAAAAAAAAAAAAAAA')),
                                      onChanged: (value) {
                                        update = true;
                                        setState(() {});
                                      }))),
                        ])),
                    Padding(
                        padding: const EdgeInsets.only(top: 15, left: 16),
                        child: Row(children: [
                          SizedBox(
                              height: 40,
                              width: SizeConfig.screenWidth * 0.196,
                              child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                                Text('Email:',
                                    style: TextStyle(fontSize: SubRoutine.getFontSizeString(SizeConfig.screenWidth * 0.196, 'AAAAA'), color: Colors.black),
                                    textAlign: TextAlign.left)
                              ])),
                          const SizedBox(width: 10),
                          Container(
                              height: 40,
                              width: SizeConfig.screenWidth * 0.68,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                border: Border.all(color: Color(Clrs.dkblue), width: 2),
                              ),
                              child: Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: TextField(
                                    controller: tecemail,
                                    style: TextStyle(fontSize: SubRoutine.getFontSizeString(SizeConfig.screenWidth * 0.68, 'AAAAAAAAAAAAAAAAAA')),
                                  ))),
                        ])),
                    const SizedBox(
                      height: 40,
                    ),
                    Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                        SizedBox(
                            height: 60,
                            width: 150,
                            child: ElevatedButton(
                                onPressed: () async {
                                  if (update) {
                                    variables.tablecurrentEmployee[0]['Employee_ID'] = variables.tablecurrentEmployee[0]['Employee_ID'];
                                    variables.tablecurrentEmployee[0]['Street'] = tecstreet.text;
                                    variables.tablecurrentEmployee[0]['City'] = teccity.text;
                                    variables.tablecurrentEmployee[0]['State'] = tecstate.text;
                                    variables.tablecurrentEmployee[0]['Zip'] = teczipcode.text;
                                    variables.tablecurrentEmployee[0]['Phone'] = tecphone.text;
                                    await db.dbUpdate(variables.tablecurrentEmployee, 'Employees', 'Employee_ID');
                                  }
                                  update = false;
                                  setState(() {});
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: update ? Colors.green : Colors.grey,
                                    textStyle: TextStyle(
                                      color: Colors.green,
                                      fontSize: SubRoutine.getFontSizeString(150, 'Update'),
                                    )),
                                child: const Text('Update')))
                      ]),
                      const SizedBox(height: 400),
                    ])
                  ]),
                )
              ])),
        ]),
      ),
    );
  }
}
