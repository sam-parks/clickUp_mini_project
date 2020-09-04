part of 'task_list_bloc.dart';

@immutable
abstract class TaskListEvent {}



class CreateClickupList extends TaskListEvent {
  final String folderID;
  final ClickUpList clickUpList;

  CreateClickupList(this.folderID, this.clickUpList);
}

class RetrieveClickupList extends TaskListEvent {
  final String folderID;

  RetrieveClickupList(this.folderID);
}

class RetrieveTasks extends TaskListEvent {
  final String listID;

  RetrieveTasks(this.listID);
}
