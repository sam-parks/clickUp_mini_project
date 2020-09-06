part of 'task_bloc.dart';

@immutable
abstract class TaskEvent {}

class CreateClickupList extends TaskEvent {
  final String folderID;
  final ClickupList clickUpList;

  CreateClickupList(this.folderID, this.clickUpList);
}

class RetrieveSpaceTasks extends TaskEvent {
  final String spaceID;

  RetrieveSpaceTasks(this.spaceID);
}

class CreateTask extends TaskEvent {
  final Task task;
  final String listID;

  CreateTask(this.task, this.listID);
}

class DeleteTask extends TaskEvent {
  final String taskID;

  DeleteTask(this.taskID);
}

class RefreshSpaceTasks extends TaskEvent {
  final String spaceID;

  RefreshSpaceTasks(this.spaceID);
}
