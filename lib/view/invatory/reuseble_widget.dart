// ignore_for_file: prefer_const_constructors
import 'package:efim/constants/router.dart';
import 'package:efim/enums/MenuAction.dart';
import 'package:efim/view/invatory/dep_card.dart';
import 'package:flutter/material.dart';
import '../../services/auth/auth_service.dart';

class MainPageView extends StatefulWidget {
  const MainPageView({super.key});

  @override
  State<MainPageView> createState() => _MainPageViewState();
}

class _MainPageViewState extends State<MainPageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[400],
        body: Column(
          children: [
            //apbbar
            SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Main page',
                    style: TextStyle(fontSize: 30),
                  ),
                  // plus button
                  Container(
                      padding: EdgeInsets.all(1),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(213, 158, 158, 158),
                        shape: BoxShape.circle,
                      ),
                      child: PopupMenuButton<MenuAction>(
                        onSelected: (value) async {
                          switch (value) {
                            case MenuAction.logout:
                              final shouldLogout =
                                  await showLogOutDialog(context);
                              if (shouldLogout) {
                                // logout from firebase
                                await AuthService.firebase().logOut();
                                // ignore: use_build_context_synchronously
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                  loginRoute,
                                  (route) => false,
                                );
                              }
                          }
                        },
                        itemBuilder: (context) {
                          return [
                            const PopupMenuItem<MenuAction>(
                              value: MenuAction.logout,
                              child: Text('Logout'),
                            ),
                          ];
                        },
                      )),
                ],
              ),
            ),

            SizedBox(
              height: 25,
            ),

            //card
            SizedBox(
              height: 650,
              // ignore: prefer_const_literals_to_create_immutables
              child: ListView(children: [
                DepCard(
                    depName: "L'ACIÉRIE",
                    activeMachines: 7,
                    activeMembers: 16,
                    totalMachines: 24,
                    totalMembers: 24),
                DepCard(
                    depName: "TREFILERIE",
                    activeMachines: 7,
                    activeMembers: 16,
                    totalMachines: 24,
                    totalMembers: 24),
                DepCard(
                    depName: "LAMINOIR",
                    activeMachines: 7,
                    activeMembers: 16,
                    totalMachines: 24,
                    totalMembers: 24),
                DepCard(
                    depName: "INFOMATIQUE",
                    activeMachines: 7,
                    activeMembers: 16,
                    totalMachines: 24,
                    totalMembers: 24),
              ]),
            )
          ],
        ));
  }
}

Future<bool> showLogOutDialog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Sign out'),
        content: const Text('Are you sure '),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: const Text('Sing out'),
          )
        ],
      );
    },
// showDialog<bool> should return a bool :D but in this case i'm return'in optional bool wish leads to an error!
//to fix it we append then function saying that 'if showDialog<> isn't abel to reutrn a boolean
// then im going to return false other wise return the value of the showDialog
  ).then((value) => value ?? false);
}
