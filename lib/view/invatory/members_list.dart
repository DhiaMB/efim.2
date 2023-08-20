import 'package:flutter/material.dart';

class UserList extends ChangeNotifier {
  final List<User> _users;

  UserList(this._users);

  List<User> get Listusers {
    return _users;
  }

  void addToListUser(User user) {
    _users.add(user);
    notifyListeners(); // Notify listeners when the data changes
  }

  void deleteUser(User user) {
    _users.remove(user);
    notifyListeners(); // Notify listeners when the data changes
  }
}

class MachinesList extends ChangeNotifier {
  final List<Machine> _machines;

  MachinesList(this._machines);

  List<Machine> get Listusers {
    return _machines;
  }

  void addToListMachine(Machine machine) {
    _machines.add(machine);
    notifyListeners(); // Notify listeners when the data changes
  }

  void deleteUser(Machine machine) {
    _machines.remove(machine);
    notifyListeners(); // Notify listeners when the data changes
  }
}

class User {
  final String username;
  final String email;
  final String phoneNum;
  final bool isOnline;
  final String sex;

  User({
    required this.username,
    required this.email,
    required this.phoneNum,
    required this.isOnline, // Make sure to include isOnline parameter
    required this.sex,
  });

  static User fromJson(Map<String, dynamic> json) => User(
        username: json['name'],
        email: json['email'],
        phoneNum: json['phone'],
        isOnline: json['isOnline'] ?? false, // Include isOnline here
        sex: json['sex'],
      );
}

class Machine {
  final String name;
  final String type;
  final String location;
  final bool isOnline;

  Machine(
      {required this.name,
      required this.type,
      required this.location,
      required this.isOnline});
  static Machine fromJson(Map<String, dynamic> json) => Machine(
        name: json['name'],
        type: json['type'],
        location: json['location'],
        isOnline: json['isOnline'] ?? false, // Include isOnline here
      );
}
