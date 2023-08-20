import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:efim/view/invatory/members_list.dart';
import 'package:flutter/material.dart';

class UserPage extends StatefulWidget {
  final User user;
  final String documentId;

  const UserPage({Key? key, required this.user, required this.documentId})
      : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  String getImageAssetPath(String machineType) {
    if (machineType == 'male') {
      return 'assets/6.png';
    } else {
      return 'assets/7.1.png';
    }
  }

  @override
  Widget build(BuildContext context) {
    final String imageAssetPath = getImageAssetPath(widget.user.sex);
    // Make sure to replace UserList with your actual provider class
    // Replace Listusers with your actual user list property

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.user.username),
        backgroundColor: Colors.white54,
        actions: [
          IconButton(
            onPressed: () {
              deleteUser(widget.documentId); // Call deleteUser with user's id
              Navigator.pop(context);
            },
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Image.asset(
              imageAssetPath,
              width: 180,
              height: 180,
            ),
            Text(
              "Name: ${widget.user.username}",
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            Text(
              "Email: ${widget.user.email}",
              style:
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
            ),
            Text(
              "Phone: ${widget.user.phoneNum.toString()}",
              style:
                  const TextStyle(fontSize: 25, fontWeight: FontWeight.normal),
            ),
          ],
        ),
      ),
    );
  }

  void deleteUser(String documentId) {
    FirebaseFirestore.instance.collection('Members').doc(documentId).delete();
  }
}
