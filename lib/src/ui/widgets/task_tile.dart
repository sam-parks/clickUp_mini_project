import 'package:click_up_tasks/src/data/task.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../style.dart';

class TaskTile extends StatefulWidget {
  TaskTile(
    this.task, {
    Key key,
  }) : super(key: key);
  final Task task;

  @override
  _TaskTileState createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: Card(
        elevation: 2,
        color: Colors.white,
        child: ListTile(
          leading: Container(
            height: 20,
            width: 20,
            decoration: BoxDecoration(
                color: colorFromStatus(widget.task.status.status),
                borderRadius: BorderRadius.circular(3)),
          ),
          title: Text(widget.task.name),
        ),
      ),
      actions: <Widget>[
        IconSlideAction(
          caption: 'Archive',
          color: Colors.blue,
          icon: Icons.archive,
        ),
        IconSlideAction(
          caption: 'Share',
          color: Colors.indigo,
          icon: Icons.share,
        ),
      ],
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'More',
          color: Colors.black45,
          icon: Icons.more_horiz,
        ),
        IconSlideAction(
          caption: 'Delete',
          color: Colors.red,
          icon: Icons.delete,
        ),
      ],
    ));
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
