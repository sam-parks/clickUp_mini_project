part of 'task_list_bloc.dart';

@immutable
abstract class TaskListEvent {}

class CreateClickupList {
  final String folderID;
  final ClickUpList clickUpList;

  CreateClickupList(this.folderID, this.clickUpList);
}

class RetrieveClickupList {
  final String folderID;

  RetrieveClickupList(this.folderID);
}

class RetrieveTasks extends TaskListEvent {
  final String listID;

  RetrieveTasks(this.listID);
}
