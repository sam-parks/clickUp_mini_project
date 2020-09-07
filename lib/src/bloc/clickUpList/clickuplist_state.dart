part of 'clickuplist_bloc.dart';

@immutable
abstract class ClickuplistState {}

class ClickuplistInitial extends ClickuplistState {}

class ClickUpListsReordered extends ClickuplistState {
  final List<ClickupList> lists;

  ClickUpListsReordered(this.lists);
}
