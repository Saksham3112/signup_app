import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'profilePage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Sign Up Application',
      home: HomePage(storage: Users()),
    ),
  );
}

class Users {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/counter.txt');
  }

  Future<String> readCounter() async {
    try {
      final file = await _localFile;

      // Read the file
      final contents = await file.readAsString();
      return contents;
    } catch (e) {
      // If encountering an error, return 0
      return "0";
    }
  }

  Future<File> writeCounter(String data) async {
    final file = await _localFile;

    // Write the file
    return file.writeAsString(data);
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.storage});

  final Users storage;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List names = [];
  String _signedDB = "";
  Map userData = {};
  Map currDetails = {"age": 1, "gender": "male"};
  TextEditingController _textFieldControllerAge = TextEditingController();
  TextEditingController _textFieldControllerGender = TextEditingController();
  @override
  void initState() {
    super.initState();
    widget.storage.readCounter().then((value) {
      setState(() {
        debugPrint("Intialized");
        _signedDB = value;
        userData = jsonDecode(_signedDB);
      });
    });
    names = [
      {"name": "Krishna", "id": "1", "atype": "Permanent"},
      {"name": "Sameera", "id": "2", "atype": "Permanent"},
      {"name": "Radhika", "id": "3", "atype": "Permanent"},
      {"name": "Yogesh", "id": "4", "atype": "Permanent"},
      {"name": "Radhe", "id": "5", "atype": "Permanent"},
      {"name": "Anshu", "id": "6", "atype": "Permanent"},
      {"name": "Balay", "id": "7", "atype": "Permanent"},
      {"name": "Julie", "id": "8", "atype": "Permanent"},
      {"name": "Swaminathan", "id": "9", "atype": "Permanent"},
      {"name": "Charandeep", "id": "10", "atype": "Permanent"},
      {"name": "Sankaran", "id": "11", "atype": "Permanent"},
      {"name": "Alpa", "id": "12", "atype": "Permanent"},
      {"name": "Sheth", "id": "13", "atype": "Temproary"},
      {"name": "Sabina", "id": "14", "atype": "Temproary"}
    ];
  }

  bool isSignedIn(String key) {
    if (userData.isEmpty) {
      return false;
    } else if (userData.containsKey(key)) {
      return true;
    } else {
      return false;
    }
  }

  void _logOut(dynamic key) {
    if (userData.isNotEmpty) {
      setState(() {
        userData.remove(key.toString());
        widget.storage.writeCounter(jsonEncode(userData));
      });
    }
  }

  Future<void> _displayTextInputDialog(
      BuildContext context, Map element) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Kindly fill details, ' + element['name']),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  onChanged: (value) {
                    setState(() {
                      currDetails['age'] = value.toString();
                    });
                  },
                  controller: _textFieldControllerAge,
                  decoration: InputDecoration(hintText: "Age"),
                ),
                TextField(
                  onChanged: (value) {
                    setState(() {
                      currDetails['gender'] = value.toString();
                    });
                  },
                  controller: _textFieldControllerGender,
                  decoration: InputDecoration(hintText: "Gender"),
                ),
              ],
            ),
            actions: [
              ElevatedButton(
                onPressed: (() {
                  setState(() {
                    Navigator.pop(context);
                  });
                }),
                child: Text("Deny"),
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.red.shade700)),
              ),
              ElevatedButton(
                onPressed: (() {
                  setState(() {
                    userData[element['id']] = currDetails;
                    widget.storage.writeCounter(jsonEncode(userData));
                    widget.storage.readCounter().then((value) {
                      setState(() {
                        _signedDB = value;
                      });
                    });

                    Navigator.pop(context);
                  });
                }),
                child: Text("Ok"),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.green)),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade900,
        title: const Text(
          'Users',
          style: TextStyle(fontSize: 40),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.grey.shade800,
            child: Column(
              children: [
                Column(
                  children: List.from(names.map((e) => Container(
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                  height: 55,
                                  width: 200,
                                  child: Flexible(
                                      child: GestureDetector(
                                    onTap: () {
                                      isSignedIn(e['id']) == false
                                          ? _displayTextInputDialog(context, e)
                                          : Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      userPage(
                                                          userDetails:
                                                              userData[e['id']],
                                                          userName: e['name'])),
                                            );
                                      ;
                                    },
                                    child: Text(
                                      e['name'],
                                      style: TextStyle(
                                          color: Colors.grey.shade400,
                                          fontSize: 35),
                                    ),
                                  ))),
                              isSignedIn(e['id']) == false
                                  ? ElevatedButton(
                                      onPressed: (() {
                                        setState(() {
                                          _displayTextInputDialog(context, e);
                                        });
                                      }),
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.green)),
                                      child: Container(
                                        width: 100,
                                        child: Center(
                                          child: Text(
                                            "Sign In",
                                            style: TextStyle(fontSize: 20),
                                          ),
                                        ),
                                      ))
                                  : ElevatedButton(
                                      onPressed: (() {
                                        setState(() {
                                          _logOut(e['id']);
                                        });
                                      }),
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.red.shade700)),
                                      child: Container(
                                        width: 100,
                                        child: Center(
                                          child: Text(
                                            "Sign Out",
                                            style: TextStyle(fontSize: 20),
                                          ),
                                        ),
                                      ))
                            ],
                          ),
                        ),
                      ))),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
