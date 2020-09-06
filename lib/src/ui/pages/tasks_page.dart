import 'package:click_up_tasks/src/bloc/tasks/task_bloc.dart';
import 'package:click_up_tasks/src/data/clickup_list.dart';
import 'package:click_up_tasks/src/data/task.dart';
import 'package:click_up_tasks/src/ui/style.dart';
import 'package:click_up_tasks/src/ui/widgets/dialogs.dart';
import 'package:click_up_tasks/src/ui/widgets/radial_menu.dart';
import 'package:click_up_tasks/src/ui/widgets/task_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class TasksPage extends StatefulWidget {
  TasksPage({Key key, this.teamID}) : super(key: key);
  final String teamID;

  @override
  _TasksPageState createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  List<Task> tasks;
  List<ClickupList> clickUpLists;

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    TaskBloc taskBloc = BlocProvider.of<TaskBloc>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
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
            tasks = state.items['tasks'];
            clickUpLists = state.items['clickUpLists'];
          }
          if (state is TasksRefreshed) {
            _refreshController.refreshCompleted();
          }
          return SmartRefresher(
            enablePullDown: true,
            onRefresh: () => taskBloc.add(RefreshSpaceTasks(widget.teamID)),
            header: WaterDropHeader(),
            controller: _refreshController,
            child: ListView.builder(
                itemCount: clickUpLists.length,
                itemBuilder: (context, index) {
                  List<Task> tasksInList = (tasks.where(
                          (task) => task.clickUplist == clickUpLists[index].id))
                      .toList();

                  return tasksInList.length != 0
                      ? Column(
                          children: [
                            Text(clickUpLists[index].name),
                            Column(
                              children:
                                  List.generate(tasksInList.length, (index) {
                                return TaskTile(tasksInList[index]);
                              }),
                            )
                          ],
                        )
                      : Container();
                }),
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
                onPressed: () async {
                  Task task = await createTaskDialog(
                      context, tasks.length + 1, clickUpLists);
                  if (task != null) {
                    taskBloc.add(CreateTask(task, task.clickUplist));
                  }
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
