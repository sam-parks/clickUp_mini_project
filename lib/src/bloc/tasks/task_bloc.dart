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
    if (event is RetrieveTeamTasks) {
      try {
        yield TaskStateLoadingState();
        List<Task> tasks;

        tasks = await taskDBProvider.retrieveTasks();
        if (tasks.isEmpty) {
          tasks = await _clickUpService.getAllTasksForTeam(event.teamID);
          taskDBProvider.insertTasks(tasks);
        }

        yield TasksRetrieved(tasks);
      } catch (e) {}
    }

    if (event is RefreshTeamTasks) {
      try {
        yield TaskStateLoadingState();
        List<Task> tasks =
            await _clickUpService.getAllTasksForTeam(event.teamID);
        await taskDBProvider.cleanDatabase();
        taskDBProvider.insertTasks(tasks);

        yield TasksRetrieved(tasks);
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
