part of 'task_bloc.dart';

@immutable
abstract class TaskState {}

class TaskInitial extends TaskState {}

class TaskStateLoadingState extends TaskState {}

class TasksErrorState extends TaskState {
  final String e;

  TasksErrorState(this.e);
}

class TasksRetrieved extends TaskState {
  final List<Task> tasks;

  TasksRetrieved(this.tasks);
}

class TasksRefreshed extends TaskState {
  final List<Task> tasks;

  TasksRefreshed(this.tasks);
}
