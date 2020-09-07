import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:click_up_tasks/src/data/clickup_list.dart';
import 'package:meta/meta.dart';

part 'clickuplist_event.dart';
part 'clickuplist_state.dart';

class ClickuplistBloc extends Bloc<ClickuplistEvent, ClickuplistState> {
  ClickuplistBloc() : super(ClickuplistInitial());

  List<ClickupList> clickUpLists;

  @override
  Stream<ClickuplistState> mapEventToState(
    ClickuplistEvent event,
  ) async* {
    if (event is SetClickUpLists) {
      clickUpLists = event.lists;
    }

    if (event is ReorderClickUpLists) {
      yield ClickUpListsReordered(event.lists);
    }
  }
}
