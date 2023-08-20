import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:efim/view/invatory/members_list.dart';
import 'package:flutter/material.dart';

class MachienPage extends StatefulWidget {
  final Machine machine;
  final String documentId;

  const MachienPage({Key? key, required this.machine, required this.documentId})
      : super(key: key);

  @override
  State<MachienPage> createState() => _MachienPageState();
}

class _MachienPageState extends State<MachienPage> {
  String getImageAssetPath(String machineType) {
    if (machineType == 'PC') {
      return 'assets/9.png';
    } else if (machineType == "Camera") {
      return 'assets/13.png';
    } else {
      return 'assets/10.png';
    }
  }

  @override
  Widget build(BuildContext context) {
    final String imageAssetPath = getImageAssetPath(widget.machine.type);

    return Scaffold(
        appBar: AppBar(
            title: Text(
              widget.machine.name,
              style: const TextStyle(fontSize: 30),
            ),
            backgroundColor: Colors.white54,
            actions: [
              IconButton(
                  onPressed: () {
                    deleteUser(widget.documentId);
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.delete)),
            ]),
        body: Center(
          child: Column(children: <Widget>[
            Image.asset(
              imageAssetPath,
              width: 180,
              height: 180,
            ),
            Text(
              "Name ${widget.machine.name}",
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            Text(
              "Type : ${widget.machine.type}",
              style:
                  const TextStyle(fontSize: 25, fontWeight: FontWeight.normal),
            ),
            Text(
              "Location : ${widget.machine.location}",
              style:
                  const TextStyle(fontSize: 25, fontWeight: FontWeight.normal),
            ),
          ]),
        ));
  }

  void deleteUser(String documentId) {
    FirebaseFirestore.instance.collection('Machines').doc(documentId).delete();
  }
}
