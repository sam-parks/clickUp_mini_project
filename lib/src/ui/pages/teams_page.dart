import 'package:flutter/material.dart';

class TeamsPage extends StatefulWidget {
  TeamsPage({Key key}) : super(key: key);

  @override
  _TeamsPageState createState() => _TeamsPageState();
}

class _TeamsPageState extends State<TeamsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Teams"),
      ),
    );
  }
}
