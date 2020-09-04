import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:click_up_tasks/src/data/task.dart';
import 'package:click_up_tasks/src/services/click_up_service.dart';
import 'package:meta/meta.dart';

import '../../locator.dart';

part 'task_list_event.dart';
part 'task_list_state.dart';

class TaskListBloc extends Bloc<TaskListEvent, TaskListState> {
  TaskListBloc() : super(TaskListInitial());

  ClickUpService get _clickUpService => locator.get();

  @override
  Stream<TaskListState> mapEventToState(
    TaskListEvent event,
  ) async* {
    if (event is RetrieveTasks) {
      try {
        yield TaskListLoadingState();
        List<Task> tasks = await _clickUpService.getTasks(event.listID);
      } catch (e) {}
    }
  }
}
