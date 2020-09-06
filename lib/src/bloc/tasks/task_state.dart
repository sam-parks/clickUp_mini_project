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
   final Map items;

  TasksRefreshed(this.items);
}

class TaskCreated extends TaskState {
  final Task task;

  TaskCreated(this.task);
}

class TaskDeleted extends TaskState {
  final String taskID;

  TaskDeleted(this.taskID);
}
