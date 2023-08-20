import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:efim/enums/sexMenu.dart';
import 'package:flutter/material.dart';

import 'package:efim/view/invatory/members_list.dart';

class AddMemberBottomSheet extends StatefulWidget {
  final Function(User) onUserAdd;

  const AddMemberBottomSheet({Key? key, required this.onUserAdd})
      : super(key: key);

  @override
  _AddMemberBottomSheetState createState() => _AddMemberBottomSheetState();
}

class _AddMemberBottomSheetState extends State<AddMemberBottomSheet> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController statusController = TextEditingController();
  ValueNotifier<Sex> selectedSex = ValueNotifier<Sex>(Sex.male);

  Sex group = Sex.male;

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
                    labelText: "Email",
                  ),
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: "Phone No.",
                  ),
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(
                  height: 20,
                ),
                DropdownButtonFormField<Sex>(
                  onChanged: (newValue) {
                    selectedSex.value = newValue!;
                  },
                  value: selectedSex.value,
                  decoration: const InputDecoration(
                    labelText: "Sex",
                  ),
                  items: Sex.values
                      .map((e) => DropdownMenuItem<Sex>(
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
                    child: const Text("Add new contact"),
                    onPressed: () {
                      final name = nameController.text;
                      final email = emailController.text;
                      final phone = phoneController.text;
                      final sex = selectedSex.value.toString();

                      createUser(
                        name: name,
                        email: email,
                        phone: phone,
                        sex: sex,
                      );

                      Navigator.pop(context); // Close the bottom sheet
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

// Creat User
  Future<void> createUser({
    required String name,
    required String email,
    required String phone,
    required String sex,
  }) async {
    final docUser = FirebaseFirestore.instance.collection('Members').doc();
    final user = {
      'name': name,
      'email': email,
      'phone': phone,
      'sex': selectedSex.value.toString().split('.').last,
      'isOnline': false,
    };
    await docUser.set(user);
  }

  Stream<List<User>> readUsers() {
    return FirebaseFirestore.instance.collection('Members').snapshots().map(
        (snapshot) =>
            snapshot.docs.map((doc) => User.fromJson(doc.data())).toList());
  }
}
