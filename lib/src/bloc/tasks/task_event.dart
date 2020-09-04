part of 'task_bloc.dart';

@immutable
abstract class TaskEvent {}

class CreateClickupList extends TaskEvent {
  final String folderID;
  final ClickupList clickUpList;

  CreateClickupList(this.folderID, this.clickUpList);
}

class RetrieveTeamTasks extends TaskEvent {
  final String teamID;

  RetrieveTeamTasks(this.teamID);
}

class CreateTask extends TaskEvent {
  final Task task;
  final String listID;

  CreateTask(this.task, this.listID);
}

class RefreshTeamTasks extends TaskEvent {
  final String teamID;

  RefreshTeamTasks(this.teamID);
}
