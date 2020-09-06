import 'package:click_up_tasks/src/data/clickup_list.dart';
import 'package:click_up_tasks/src/data/task.dart';
import 'package:click_up_tasks/src/ui/widgets/task_tile.dart';
import 'package:click_up_tasks/src/util/validate.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../style.dart';

createTaskDialog(
    BuildContext context, int orderIndex, List<ClickupList> clickupLists) {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String name;

  String status = 'to do';
  String listID;
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
                                    color: AppColors.pink, fontSize: 20),
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
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: DropdownButton(
                                        hint: Text("Select a List"),
                                        icon: Icon(FontAwesomeIcons.list),
                                        value: listID,
                                        items: List.generate(
                                          clickupLists.length,
                                          (index) => DropdownMenuItem(
                                            value: clickupLists[index].id,
                                            child: Text(
                                              clickupLists[index].name,
                                            ),
                                          ),
                                        ),
                                        onChanged: (value) {
                                          setState(() {
                                            listID = value;
                                          });
                                        }),
                                  ),
                                ],
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
                                  Container(
                                    width: 220,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 30),
                                    child: DropdownButtonFormField(
                                        validator: (value) {
                                          return Validate.requiredField(
                                              value, "Field required.");
                                        },
                                        hint: Text("Select a Status"),
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
                                            clickUplist: listID,
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
