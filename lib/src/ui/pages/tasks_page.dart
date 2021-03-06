import 'package:click_up_tasks/src/bloc/clickUpList/clickuplist_bloc.dart';
import 'package:click_up_tasks/src/bloc/tasks/task_bloc.dart';
import 'package:click_up_tasks/src/data/clickup_list.dart';
import 'package:click_up_tasks/src/data/task.dart';
import 'package:click_up_tasks/src/ui/style.dart';
import 'package:click_up_tasks/src/ui/widgets/dialogs.dart';
import 'package:click_up_tasks/src/ui/widgets/radial_menu.dart';
import 'package:click_up_tasks/src/ui/widgets/task_tile.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class TasksPage extends StatefulWidget {
  TasksPage({Key key, this.teamID}) : super(key: key);
  final String teamID;

  @override
  _TasksPageState createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  List<Task> tasks = [];
  List<ClickupList> clickUpLists;

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    TaskBloc taskBloc = BlocProvider.of<TaskBloc>(context);
    // ignore: close_sinks
    ClickuplistBloc clickuplistBloc = BlocProvider.of<ClickuplistBloc>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text("Tasks", style: TextStyle(color: Colors.white)),
        leading: Container(),
      ),
      body: BlocConsumer(
        listener: (context, state) {
          if (state is TaskCreated) {
            setState(() {
              tasks.add(state.task);
            });

            Flushbar(
              titleText: Text(
                "Task created!",
              ),
              icon: Icon(Icons.notification_important, color: AppColors.violet),
              message: state.task.id,
              isDismissible: true,
              flushbarStyle: FlushbarStyle.FLOATING,
              duration: Duration(seconds: 3),
              backgroundColor: Colors.white,
              borderColor: AppColors.violet,
            )..show(context);
          }
          if (state is TaskDeleted) {
            setState(() {
              tasks.removeWhere((task) => task.id == state.taskID);
            });

            Flushbar(
              titleText: Text(
                "Task deleted!",
              ),
              icon: Icon(Icons.notification_important, color: AppColors.violet),
              message: state.taskID,
              isDismissible: true,
              flushbarStyle: FlushbarStyle.FLOATING,
              duration: Duration(seconds: 3),
              backgroundColor: Colors.white,
              borderColor: AppColors.violet,
            )..show(context);
          }
        },
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
            clickuplistBloc.add(SetClickUpLists(clickUpLists));
          }
          if (state is TasksRefreshed) {
            tasks = state.items['tasks'];
            clickUpLists = state.items['clickUpLists'];
            _refreshController.loadComplete();
            _refreshController.refreshCompleted();
          }

          return tasks.isEmpty
              ? Center(
                  child: Opacity(
                      opacity: .4,
                      child: SvgPicture.asset('assets/clickup.svg')),
                )
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SmartRefresher(
                    enablePullDown: true,
                    onRefresh: () =>
                        taskBloc.add(RefreshSpaceTasks(widget.teamID)),
                    header: WaterDropHeader(
                      waterDropColor: AppColors.pink,
                    ),
                    controller: _refreshController,
                    child: ListView.builder(
                        itemCount: clickUpLists.length,
                        itemBuilder: (context, index) {
                          List<Task> tasksInList = (tasks.where((task) =>
                                  task.clickUplist == clickUpLists[index].id))
                              .toList();

                          Color listColor = AppColors.allColors[index];

                          return tasksInList.length != 0
                              ? Column(
                                  children: [
                                    Text(
                                      clickUpLists[index].name,
                                      style: TextStyle(color: listColor),
                                    ),
                                    Column(
                                      children: List.generate(
                                          tasksInList.length, (index) {
                                        return TaskTile(
                                          tasksInList[index],
                                          listColor,
                                          key: ValueKey(tasksInList[index].id),
                                        );
                                      }),
                                    )
                                  ],
                                )
                              : Container();
                        }),
                  ),
                );
        },
      ),
      floatingActionButton: RadialMenu(widget.teamID, MenuType.tasks),
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
                icon: Icon(FontAwesomeIcons.home),
                color: Colors.white,
                onPressed: () async {
                  Navigator.of(context).pop();
                },
              ),
              Spacer(),
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
