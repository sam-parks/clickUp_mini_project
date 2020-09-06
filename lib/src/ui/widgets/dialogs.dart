import 'package:click_up_tasks/src/data/clickup_list.dart';
import 'package:click_up_tasks/src/data/task.dart';
import 'package:click_up_tasks/src/ui/widgets/task_tile.dart';
import 'package:click_up_tasks/src/util/validate.dart';
import 'package:flutter/material.dart';

import '../style.dart';

createTaskDialog(
    BuildContext context, int orderIndex, List<ClickupList> clickupLists) {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String name;

  String status = 'to do';
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0)), //this right here
          child: StatefulBuilder(
            builder: (context, setState) {
              return Stack(
                children: [
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: Text(
                                'Create a Task',
                                style: TextStyle(
                                    color: AppColors.pink, fontSize: 30),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                autofocus: true,
                                decoration: InputDecoration(labelText: "Name"),
                                onChanged: (value) {
                                  name = value;
                                },
                                validator: (value) {
                                  return Validate.requiredField(
                                      value, "Field required.");
                                },
                              ),
                            ),
                            Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 20,
                                    width: 20,
                                    decoration: BoxDecoration(
                                        color: colorFromStatus(status),
                                        borderRadius: BorderRadius.circular(3)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: DropdownButton(
                                        value: status,
                                        items: [
                                          DropdownMenuItem(
                                            value: "to do",
                                            child: Text(
                                              "To Do",
                                            ),
                                          ),
                                          DropdownMenuItem(
                                            value: "in progress",
                                            child: Text(
                                              "In Progress",
                                            ),
                                          ),
                                          DropdownMenuItem(
                                            value: "ready",
                                            child: Text(
                                              "Ready",
                                            ),
                                          ),
                                          DropdownMenuItem(
                                            value: "complete",
                                            child: Text(
                                              "Complete",
                                            ),
                                          ),
                                        ],
                                        onChanged: (value) {
                                          setState(() {
                                            status = value;
                                          });
                                        }),
                                  ),
                                ],
                              ),
                            ),
                            Flexible(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  width: 250,
                                  child: RaisedButton(
                                    onPressed: () {
                                      if (_formKey.currentState.validate()) {
                                        Task task = Task(
                                            name: name,
                                            orderindex: orderIndex,
                                            dateCreated: DateTime.now()
                                                .millisecondsSinceEpoch
                                                .toString(),
                                            dateUpdated: DateTime.now()
                                                .millisecondsSinceEpoch
                                                .toString(),
                                            status: TaskStatus(status: status));
                                        Navigator.of(context).pop(task);
                                      }
                                    },
                                    child: Text(
                                      "Create",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    color: const Color(0xFF1BC0C5),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    child: IconButton(
                      icon: Icon(Icons.cancel),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  )
                ],
              );
            },
          ),
        );
      });
}
