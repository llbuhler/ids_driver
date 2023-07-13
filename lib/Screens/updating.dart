import 'package:flutter/material.dart';
import 'package:ids_driver/Subs/SizeConfig.dart';
import 'package:ids_driver/Subs/localColors.dart';

class UpdateStops extends StatefulWidget {
  const UpdateStops({super.key});

  @override
  State<UpdateStops> createState() => _UpdateStopsState();
}

class _UpdateStopsState extends State<UpdateStops> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        height: SizeConfig.screenHeight,
        width: SizeConfig.screenWidth,
        color: Color(Clrs.laser),
      ),
    );
  }
}
