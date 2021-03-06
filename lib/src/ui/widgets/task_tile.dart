import 'package:auto_size_text/auto_size_text.dart';
import 'package:click_up_tasks/src/bloc/tasks/task_bloc.dart';
import 'package:click_up_tasks/src/data/task.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

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

  var format = DateFormat.yMd().add_jm();

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
            height: 70,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
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
                Container(
                  width: 80,
                  padding: const EdgeInsets.all(8.0),
                  child: AutoSizeText(
                    widget.task.name,
                    maxLines: 2,
                  ),
                ),
                Spacer(),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text("Date Created"),
                        if (widget.task.dateCreated != null)
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: AutoSizeText(
                              format.format(DateTime.fromMillisecondsSinceEpoch(
                                  int.parse(widget.task.dateCreated))),
                              maxLines: 1,
                            ),
                          )
                      ],
                    ),
                  ),
                )
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
