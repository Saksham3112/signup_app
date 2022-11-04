import 'package:flutter/material.dart';

String? selectedItem;

class userPage extends StatefulWidget {
  const userPage({
    Key? key,
    required this.userDetails,
    required this.userName,
  }) : super(key: key);
  final userDetails;
  final userName;
  @override
  _userPageState createState() => _userPageState();
}

class _userPageState extends State<userPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade900,
        title: const Text(
          'Profile Page',
          style: TextStyle(fontSize: 30),
        ),
      ),
      backgroundColor: Colors.grey.shade800,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: 150,
                child: Text(
                  "Name",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
              Text(
                ":",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              Container(
                width: 150,
                child: Text(
                  widget.userName,
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: 150,
                child: Text(
                  "Age",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
              Text(
                ":",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              Container(
                width: 150,
                child: Text(
                  widget.userDetails['age'].toString(),
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: 150,
                child: Text(
                  "Gender",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
              Text(
                ":",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              Container(
                width: 150,
                child: Text(
                  widget.userDetails['gender'],
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              )
            ],
          ),
        ]),
      ),
    );
  }
}
