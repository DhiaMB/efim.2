import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:efim/view/invatory/members_list.dart';

import '../enums/locationMenu.dart';

class AddMachineBottomSheet extends StatefulWidget {
  final Function(Machine) onMachineAdd;

  const AddMachineBottomSheet({Key? key, required this.onMachineAdd})
      : super(key: key);

  @override
  _AddMachineBottomSheetState createState() => _AddMachineBottomSheetState();
}

class _AddMachineBottomSheetState extends State<AddMachineBottomSheet> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController idController = TextEditingController();
  final TextEditingController typeController = TextEditingController();
  final TextEditingController statusController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  ValueNotifier<Location> selectedlocation =
      ValueNotifier<Location>(Location.Informatique);

  Location group = Location.Lacierie;

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    return Padding(
      padding: mediaQueryData.viewInsets,
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: "Name",
                  ),
                  controller: nameController,
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: "Type",
                  ),
                  controller: typeController,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(
                  height: 20,
                ),
                DropdownButtonFormField<Location>(
                  onChanged: (newValue) {
                    selectedlocation.value = newValue!;
                  },
                  value: selectedlocation.value,
                  decoration: const InputDecoration(
                    labelText: "Location",
                  ),
                  items: Location.values
                      .map((e) => DropdownMenuItem<Location>(
                            value: e,
                            child: Text(e.toString().split('.').last),
                          ))
                      .toList(),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 50.0,
                  child: ElevatedButton(
                    child: const Text("Add new machine"),
                    onPressed: () {
                      final name = nameController.text;
                      final type = typeController.text;
                      final location = selectedlocation.value.toString();
                      createMachine(name: name, type: type, location: location);

                      Navigator.pop(context);
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> createMachine({
    required String name,
    required String type,
    required String location,
  }) async {
    final docUser = FirebaseFirestore.instance.collection('Machines').doc();
    final machine = {
      'name': name,
      'type': type,
      'location': selectedlocation.value.toString().split('.').last,
      'isOnline': false,
    };
    await docUser.set(machine);
  }

  Stream<List<Machine>> readUsers() {
    return FirebaseFirestore.instance.collection('Machines').snapshots().map(
        (snapshot) =>
            snapshot.docs.map((doc) => Machine.fromJson(doc.data())).toList());
  }
}
