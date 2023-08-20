import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:efim/constants/insert.dart';
import 'package:efim/constants/add_machine.dart';
import 'package:flutter/material.dart';
import '../view/invatory/MachinePage_view.dart';
import '../view/invatory/UserPage_View.dart';
import '../view/invatory/members_list.dart';

Widget membersbuildSheet(BuildContext context) {
  final _userStream =
      FirebaseFirestore.instance.collection('Members').snapshots();

  return DraggableScrollableSheet(
    expand: false,
    initialChildSize: 0.7,
    minChildSize: 0.7,
    maxChildSize: 0.9,
    builder: (_, controller) => Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return AddMemberBottomSheet(onUserAdd: (user) {
                        // This function will be called when a new user is added.
                        // Here you can add the user to your list or perform other actions.
                        // You might also want to call Navigator.pop(context) to close the bottom sheet.
                      });
                    },
                  );
                },
              ),
            ],
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
                stream: _userStream,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (!snapshot.hasData) {
                    return const Text('No data available');
                  } else {
                    final userDocs = snapshot.data!.docs;
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: userDocs.length,
                      itemBuilder: (context, index) {
                        final userDoc = userDocs[index];
                        final userData = userDoc.data() as Map<String, dynamic>;
                        final user = User.fromJson(userData);
                        final statusIcon = user.isOnline == true
                            ? const Icon(Icons.circle, color: Colors.green)
                            : const Icon(Icons.circle, color: Colors.grey);
                        return Card(
                          child: ListTile(
                            leading: statusIcon,
                            title: Text(user.username),
                            subtitle: Text(user.email),
                            trailing: const Icon(Icons.arrow_forward),
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => UserPage(
                                  user: user,
                                  documentId: userDoc.id,
                                ),
                              ));
                            },
                          ),
                        );
                      },
                    );
                  }
                }),
          )
        ],
      ),
    ),
  );
}

// Widget membersbuildSheet(BuildContext context) => DraggableScrollableSheet(
//       expand: false,
//       initialChildSize: 0.7,
//       minChildSize: 0.7,
//       maxChildSize: 0.9,
//       builder: (_, controller) => Container(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 IconButton(
//                   icon: const Icon(Icons.add),
//                   onPressed: () {
//                     showModalBottomSheet(
//                       context: context,
//                       builder: (BuildContext context) {
//                         return AddMemberBottomSheet(onUserAdd: (user) {
//                           // This function will be called when a new user is added.
//                           // Here you can add the user to your list or perform other actions.
//                           // You might also want to call Navigator.pop(context) to close the bottom sheet.
//                         });
//                       },
//                     );

//                     // Handle the 'Add' button click
//                   },
//                 ),
//               ],
//             ),
//             Expanded(
//               child: ListView.builder(
//                 shrinkWrap: true,
//                 itemCount: UserList.Listusers,
//                 itemBuilder: (context, index) {
//                   final user = users[index];
//                   final statusIcon = user.isOnline == true
//                       ? const Icon(Icons.circle, color: Colors.green)
//                       : const Icon(Icons.circle, color: Colors.grey);
//                   return Card(
//                     child: ListTile(
//                       leading: statusIcon,
//                       title: Text(user.username),
//                       subtitle: Text(user.email),
//                       trailing: const Icon(Icons.arrow_forward),
//                       onTap: () {
//                         Navigator.of(context).push(MaterialPageRoute(
//                           builder: (context) => UserPage(user: user),
//                         ));
//                       },
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );

Widget machinebuildSheet(BuildContext context) {
  final _machineStream =
      FirebaseFirestore.instance.collection('Machines').snapshots();

  return DraggableScrollableSheet(
    expand: false,
    initialChildSize: 0.7,
    minChildSize: 0.7,
    maxChildSize: 0.9,
    builder: (_, controller) => Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return AddMachineBottomSheet(
                        onMachineAdd: (machine) {
                          // This function will be called when a new machine is added.
                          // Here you can add the machine to your list or perform other actions.
                          // You might also want to call Navigator.pop(context) to close the bottom sheet.
                        },
                      );
                    },
                  );
                },
              ),
            ],
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _machineStream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (!snapshot.hasData) {
                  return const Text('No data available');
                } else {
                  final machineDocs = snapshot.data!.docs;
                  final machines = machineDocs.map((machineDoc) {
                    final machineData =
                        machineDoc.data() as Map<String, dynamic>;
                    return Machine.fromJson(machineData);
                  }).toList();

                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: machineDocs.length,
                    itemBuilder: (context, index) {
                      final machineDoc = machineDocs[index];
                      final userData =
                          machineDoc.data() as Map<String, dynamic>;
                      final machine = Machine.fromJson(userData);
                      final statusIcon = machine.isOnline == true
                          ? const Icon(Icons.circle, color: Colors.green)
                          : const Icon(Icons.circle, color: Colors.grey);
                      return Card(
                        child: ListTile(
                          leading: statusIcon,
                          title: Text(machine.name),
                          subtitle: Text(machine.type),
                          trailing: const Icon(Icons.arrow_forward),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => MachienPage(
                                  machine: machine, documentId: machineDoc.id),
                            ));
                          },
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    ),
  );
}
