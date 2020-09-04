import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:click_up_tasks/src/data/clickup_list.dart';
import 'package:click_up_tasks/src/data/task.dart';
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
        List<Task> tasks =
            await _clickUpService.getAllTasksForTeam(event.teamID);
        yield TasksRetrieved(tasks);
      } catch (e) {}
    }
  }
}
