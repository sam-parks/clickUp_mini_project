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
  final Map items;

  TasksRetrieved(this.items);
}

class TasksRefreshed extends TaskState {
  final List<Task> tasks;

  TasksRefreshed(this.tasks);
}

class TaskCreated extends TaskState {
  final Task task;

  TaskCreated(this.task);
}

