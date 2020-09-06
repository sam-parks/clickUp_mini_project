import 'package:click_up_tasks/src/bloc/tasks/task_bloc.dart';
import 'package:click_up_tasks/src/data/task.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../style.dart';

class TaskTile extends StatefulWidget {
  TaskTile(
    this.task,
    this.color, {
    Key key,
  }) : super(key: key);
  final Task task;
  final Color color;

  @override
  _TaskTileState createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  double opacity = 1;

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    TaskBloc taskBloc = BlocProvider.of<TaskBloc>(context);
    return AnimatedOpacity(
      duration: Duration(milliseconds: 1000),
      opacity: opacity,
      child: Container(
          child: Slidable(
        actionPane: SlidableDrawerActionPane(),
        actionExtentRatio: 0.25,
        child: Card(
          elevation: 2,
          color: Colors.white,
          child: Container(
            height: 60,
            child: Row(
              children: [
                Container(
                  width: 40,
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(right: 8),
                          width: 10,
                          color: widget.color,
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                              color: colorFromStatus(widget.task.status.status),
                              borderRadius: BorderRadius.circular(3)),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(widget.task.name),
                ),
              ],
            ),
          ),
        ),
        secondaryActions: <Widget>[
          IconSlideAction(
            caption: 'Delete',
            color: Colors.red,
            icon: Icons.delete,
            onTap: () {
              setState(() {
                opacity = .1;
              });
              Future.delayed(Duration(milliseconds: 1200), () {
                taskBloc.add(DeleteTask(widget.task.id));
              });
            },
          ),
        ],
      )),
    );
  }
}

Color colorFromStatus(String color) {
  switch (color) {
    case 'to do':
      return Colors.grey;
    case 'in progress':
      return AppColors.light_blue;
    case 'ready':
      return AppColors.purple;
    case 'complete':
      return Colors.lightGreen;

    default:
      return Colors.grey;
  }
}
