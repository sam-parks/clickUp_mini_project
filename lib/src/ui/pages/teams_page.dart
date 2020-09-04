import 'package:click_up_tasks/src/bloc/teams/teams_bloc.dart';
import 'package:click_up_tasks/src/data/models/teams_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class TeamsPage extends StatefulWidget {
  TeamsPage({Key key}) : super(key: key);

  @override
  _TeamsPageState createState() => _TeamsPageState();
}

class _TeamsPageState extends State<TeamsPage> {
  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    TeamsBloc teamsBloc = BlocProvider.of<TeamsBloc>(context);
    TeamsModel teamsModel = Provider.of<TeamsModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Teams"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => teamsBloc.add(SelectTeam(teamsModel.teams.first.id)),
      ),
    );
  }
}
