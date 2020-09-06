import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:click_up_tasks/src/data/clickup_list.dart';
import 'package:click_up_tasks/src/data/task.dart';
import 'package:click_up_tasks/src/resources/task_db_provider.dart';
import 'package:click_up_tasks/src/services/click_up_service.dart';
import 'package:meta/meta.dart';

import '../../locator.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc() : super(TaskInitial());

  ClickUpService get _clickUpService => locator.get();

  @override
  Stream<TaskState> mapEventToState(
    TaskEvent event,
  ) async* {
    if (event is RetrieveSpaceTasks) {
      try {
        yield TaskStateLoadingState();
        Map items;

        items = await taskDBProvider.retrieveItemsForSpace(event.spaceID);
        if (items['tasks'].isEmpty) {
          items = await _clickUpService.getAllItemsForSpace(event.spaceID);
          taskDBProvider.insertTasks(items['tasks']);
          taskDBProvider.insertClickUpLists(items['clickUpLists']);
          taskDBProvider.insertFolders(items['folders']);
        }

        yield TasksRetrieved(items);
      } catch (e) {}
    }

    if (event is RefreshSpaceTasks) {
      try {
        yield TaskStateLoadingState();
        Map items = await _clickUpService.getAllItemsForSpace(event.spaceID);
        await taskDBProvider.cleanDatabase();
        taskDBProvider.insertTasks(items['tasks']);
        taskDBProvider.insertClickUpLists(items['clickUpLists']);
        taskDBProvider.insertFolders(items['folders']);

        yield TasksRetrieved(items);
      } catch (e) {}
    }

    if (event is CreateTask) {
      try {
        yield TaskStateLoadingState();
        Task task = await _clickUpService.createTask(event.task, event.listID);

        taskDBProvider.insertTask(task);

        yield TaskCreated(task);
      } catch (e) {}
    }
  }
}
