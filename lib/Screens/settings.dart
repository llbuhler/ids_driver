import 'package:flutter/material.dart';
import 'package:slider_button/slider_button.dart';
import 'package:ids_driver/Subs/SizeConfig.dart';
import 'package:ids_driver/Subs/SubRoutines.dart';
import 'package:ids_driver/Subs/localColors.dart';
import 'package:ids_driver/Subs/dbFirebasek.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:ids_driver/variables.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});
  //final VoidCallback? callback;
  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  TextEditingController tdelay = TextEditingController();
  bool showSettings = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tdelay.text = variables.tableMySettings[0]['updatedelay'].toString();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        height: SizeConfig.screenHeight,
        width: SizeConfig.screenWidth,
        color: Color(Clrs.white),
        child: Column(children: [
          Row(children: [
            Container(
              height: 50,
              width: 55,
              color: Color(Clrs.blue),
            ),
            Container(
                height: 50,
                width: SizeConfig.screenWidth - 110,
                color: Color(Clrs.blue),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text('IDS Driver App', style: TextStyle(fontSize: 30, color: Color(Clrs.white)), textAlign: TextAlign.center)],
                )),
            Container(
              height: 50,
              width: 55,
              color: Color(Clrs.blue),
              child: IconButton(
                onPressed: () async {
                  showSettings = false;
                  variables.tableMySettings[0]['recordid'] = variables.tablecurrentEmployee[0]['Employee_ID'];

                  await db.dbUpdate(variables.tableMySettings, 'Settings', 'recordid');
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.menu,
                  size: 30,
                  color: Color(Clrs.white),
                ),
              ),
            ),
          ]),
          Container(
            height: 30,
            width: SizeConfig.screenWidth,
            decoration: BoxDecoration(border: Border.all(color: Color(Clrs.blue), width: 2.0)),
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: const [
              Text(
                'Settings',
                style: TextStyle(fontSize: 18),
              ),
            ]),
          ),
          Expanded(
            child: ListView(children: [
              Padding(
                  padding: EdgeInsets.only(top: 20, left: 15, right: 15),
                  child: SizedBox(
                    height: 40,
                    child: ToggleSwitch(
                      minWidth: 120.0,
                      cornerRadius: 20.0,
                      activeBgColors: const [
                        [Colors.red],
                        [Colors.green]
                      ],
                      activeFgColor: Colors.white,
                      inactiveBgColor: Colors.grey,
                      inactiveFgColor: Colors.white,
                      initialLabelIndex: variables.tableMySettings[0]['seconds'] ? 1 : 0,
                      totalSwitches: 2,
                      labels: const ['Off', 'Seconds'],
                      radiusStyle: true,
                      onToggle: (index) {
                        variables.tableMySettings[0]['seconds'] = index == 0 ? false : true;
                        //print('switched to: $index');
                      },
                    ),
                  )),
              Padding(
                  padding: EdgeInsets.only(top: 20, left: 15, right: 15),
                  child: SizedBox(
                    height: 40,
                    child: ToggleSwitch(
                      minWidth: 120.0,
                      cornerRadius: 20.0,
                      activeBgColors: const [
                        [Colors.red],
                        [Colors.green]
                      ],
                      activeFgColor: Colors.white,
                      inactiveBgColor: Colors.grey,
                      inactiveFgColor: Colors.white,
                      initialLabelIndex: variables.tableMySettings[0]['autoupdate'] ? 1 : 0,
                      totalSwitches: 2,
                      labels: const ['Off', 'Auto Update'],
                      radiusStyle: true,
                      onToggle: (index) {
                        variables.tableMySettings[0]['autoupdate'] = index == 0 ? false : true;
                        //print('switched to: $index');
                      },
                    ),
                  )),
              Padding(
                padding: EdgeInsets.only(top: 20, left: 15, right: 15),
                child: SizedBox(
                  height: 40,
                  width: 240,
                  child: TextField(
                    controller: tdelay,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Color(Clrs.white)),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey,
                      hintText: 'Delay in Minutes',
                      hintStyle: TextStyle(
                        fontSize: 18,
                        color: Color(Clrs.white),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide(color: Color(Clrs.dkgray), width: 1),
                      ),
                    ),
                    onChanged: (v) {
                      variables.tableMySettings[0]['updatedelay'] = int.parse(v);
                    },
                  ),
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(top: 20, left: 15, right: 15),
                  child: SizedBox(
                    height: 40,
                    child: ToggleSwitch(
                      minWidth: 120.0,
                      cornerRadius: 20.0,
                      activeBgColors: const [
                        [Colors.red],
                        [Colors.green]
                      ],
                      activeFgColor: Colors.white,
                      inactiveBgColor: Colors.grey,
                      inactiveFgColor: Colors.white,
                      initialLabelIndex: variables.tableMySettings[0]['picture'] ? 1 : 0,
                      totalSwitches: 2,
                      labels: const ['Off', 'Picture'],
                      radiusStyle: true,
                      onToggle: (index) {
                        variables.tableMySettings[0]['picture'] = index == 0 ? false : true;
                        //print('switched to: $index');
                      },
                    ),
                  )),
              Padding(
                  padding: EdgeInsets.only(top: 20, left: 15, right: 15),
                  child: SizedBox(
                    height: 40,
                    child: ToggleSwitch(
                      minWidth: 120.0,
                      cornerRadius: 20.0,
                      activeBgColors: const [
                        [Colors.red],
                        [Colors.green]
                      ],
                      activeFgColor: Colors.white,
                      inactiveBgColor: Colors.grey,
                      inactiveFgColor: Colors.white,
                      initialLabelIndex: variables.tableMySettings[0]['test'] ? 1 : 0,
                      totalSwitches: 2,
                      labels: const ['Off', 'Test'],
                      radiusStyle: true,
                      onToggle: (index) {
                        variables.tableMySettings[0]['test'] = index == 0 ? false : true;
                        //print('switched to: $index');
                      },
                    ),
                  )),
              Padding(
                  padding: EdgeInsets.only(top: 20, left: 15, right: 15),
                  child: SizedBox(
                    height: 40,
                    child: ToggleSwitch(
                      minWidth: 120.0,
                      cornerRadius: 20.0,
                      activeBgColors: const [
                        [Colors.red],
                        [Colors.green]
                      ],
                      activeFgColor: Colors.white,
                      inactiveBgColor: Colors.grey,
                      inactiveFgColor: Colors.white,
                      initialLabelIndex: variables.tableMySettings[0]['messages'] ? 1 : 0,
                      totalSwitches: 2,
                      labels: const ['Off', 'Messages'],
                      radiusStyle: true,
                      onToggle: (index) {
                        variables.tableMySettings[0]['messages'] = index == 0 ? false : true;
                        //print('switched to: $index');
                      },
                    ),
                  )),
              Padding(
                  padding: EdgeInsets.only(top: 20, left: 15, right: 15),
                  child: SizedBox(
                    height: 40,
                    child: ToggleSwitch(
                      minWidth: 120.0,
                      cornerRadius: 20.0,
                      activeBgColors: const [
                        [Colors.red],
                        [Colors.green]
                      ],
                      activeFgColor: Colors.white,
                      inactiveBgColor: Colors.grey,
                      inactiveFgColor: Colors.white,
                      initialLabelIndex: variables.tableMySettings[0]['loadboard'] ? 1 : 0,
                      totalSwitches: 2,
                      labels: const ['Off', 'Load Board'],
                      radiusStyle: true,
                      onToggle: (index) {
                        variables.tableMySettings[0]['loadboard'] = index == 0 ? false : true;
                        //print('switched to: $index');
                      },
                    ),
                  )),
              Padding(
                padding: EdgeInsets.only(top: 35, left: 15, right: 15),
                child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  SizedBox(
                    height: 60,
                    width: 150,
                    child: ElevatedButton(
                      onPressed: () async {
                        variables.tableMySettings[0]['recordid'] = variables.tablecurrentEmployee[0]['recordid'];
                        await db.dbUpdate(variables.tableMySettings, 'Settings', 'recordid');
                        //widget.callback!();
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        textStyle: TextStyle(fontSize: 30),
                        foregroundColor: Color(Clrs.black),
                        backgroundColor: Color(Clrs.green),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          side: BorderSide(color: Color(Clrs.dkblue), width: 2.0),
                        ),
                      ),
                      child: Text('Update'),
                    ),
                  ),
                ]),
              ),
              Container(height: 500, width: SizeConfig.screenWidth - 30),
            ]),
          ),
        ]),
      ),
    );
  }
}
