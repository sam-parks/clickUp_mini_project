part of 'clickuplist_bloc.dart';

@immutable
abstract class ClickuplistEvent {}

class SetClickUpLists extends ClickuplistEvent {
  final List<ClickupList> lists;

  SetClickUpLists(this.lists);
}

class ReorderClickUpLists extends ClickuplistEvent {
  final List<ClickupList> lists;

  ReorderClickUpLists(this.lists);
}
