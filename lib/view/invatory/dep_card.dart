// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';

import '../../constants/buildsheets.dart';

class DepCard extends StatelessWidget {
  final String depName;
  final int totalMembers;
  final int activeMembers;
  final int totalMachines;
  final int activeMachines;

  const DepCard(
      {super.key,
      required this.depName,
      required this.activeMachines,
      required this.activeMembers,
      required this.totalMachines,
      required this.totalMembers});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
        child: Material(
          borderRadius: BorderRadius.circular(18),
          elevation: 15,
          child: Container(
            width: 350,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
            ),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                depName,
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 18,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                      onPressed: () {
                        showModalBottomSheet(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20))),
                          context: context,
                          builder: (context) => membersbuildSheet(context),
                        );
                      },
                      child: Row(
                        children: [
                          Text(
                            'Active members: ',
                            style: TextStyle(color: Colors.black),
                          ),
                          Text(
                            '$activeMembers / $totalMembers',
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ))
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                      onPressed: () {
                        showModalBottomSheet(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20))),
                          context: context,
                          builder: (context) => machinebuildSheet(context),
                        );
                      },
                      child: Row(
                        children: [
                          Text(
                            'Active machines:  ',
                            style: TextStyle(color: Colors.black),
                          ),
                          Text(
                            '$activeMachines / $totalMachines',
                            style: TextStyle(color: Colors.black),
                          )
                        ],
                      ))
                ],
              )
            ]),
          ),
        ));
  }
}
