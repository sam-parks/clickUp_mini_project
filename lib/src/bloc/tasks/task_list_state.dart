part of 'task_list_bloc.dart';

@immutable
abstract class TaskListState {}

class TaskListInitial extends TaskListState {}

class TaskListLoadingState extends TaskListState {}

class TasksErrorState extends TaskListState {
  final String e;

  TasksErrorState(this.e);
}

class TasksRetrieved extends TaskListState {
  final List<Task> tasks;

  TasksRetrieved(this.tasks);
}
