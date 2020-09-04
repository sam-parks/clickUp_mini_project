import 'package:click_up_tasks/src/bloc/tasks/task_bloc.dart';
import 'package:click_up_tasks/src/data/task.dart';
import 'package:click_up_tasks/src/ui/widgets/task_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Task> tasks;

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    TaskBloc taskBloc = BlocProvider.of<TaskBloc>(context);

    return BlocListener(
      cubit: taskBloc,
      listener: (context, state) {
        if (state is TasksRetrieved) {
          setState(() {
            tasks = state.tasks;
          });
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Tasks"),
        ),
        body: tasks == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  return TaskTile(tasks[index]);
                }),
      ),
    );
  }
}
