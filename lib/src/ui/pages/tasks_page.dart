import 'package:click_up_tasks/src/bloc/tasks/task_bloc.dart';
import 'package:click_up_tasks/src/data/task.dart';
import 'package:click_up_tasks/src/ui/style.dart';
import 'package:click_up_tasks/src/ui/widgets/dialogs.dart';
import 'package:click_up_tasks/src/ui/widgets/radial_menu.dart';
import 'package:click_up_tasks/src/ui/widgets/task_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TasksPage extends StatefulWidget {
  TasksPage({Key key}) : super(key: key);

  @override
  _TasksPageState createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  List<Task> tasks;

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    TaskBloc taskBloc = BlocProvider.of<TaskBloc>(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text("Tasks"),
      ),
      body: BlocBuilder(
        cubit: taskBloc,
        builder: (context, state) {
          if (state is TaskStateLoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is TasksRetrieved) {
            tasks = state.tasks;
          }
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      return TaskTile(tasks[index]);
                    }),
              ),
            ],
          );
        },
      ),
      floatingActionButton: RadialMenu(),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            AppColors.light_blue,
            AppColors.purple_blue,
            AppColors.purple
          ])),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.search),
                color: Colors.white,
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.add),
                color: Colors.white,
                onPressed: () {
                  createTaskDialog(context);
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
