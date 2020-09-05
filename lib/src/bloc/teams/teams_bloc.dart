import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:click_up_tasks/src/data/models/teams_model.dart';
import 'package:click_up_tasks/src/data/space.dart';
import 'package:click_up_tasks/src/services/click_up_service.dart';
import 'package:meta/meta.dart';

import '../../locator.dart';

part 'teams_event.dart';
part 'teams_state.dart';

class TeamsBloc extends Bloc<TeamsEvent, TeamsState> {
  TeamsBloc() : super(TeamsInitial());
  ClickUpService get _clickUpService => locator.get();
  @override
  Stream<TeamsState> mapEventToState(
    TeamsEvent event,
  ) async* {
    if (event is RetrieveTeams) {
      try {
        yield TeamsLoadingState();
        Map<Team, List<Space>> teamSpaceMap = {};
        List<Team> teams = await _clickUpService.getTeams();
        for (Team team in teams) {
          List<Space> spaces = await _clickUpService.getSpacesForTeam(team.id);
          teamSpaceMap[team] = spaces;
        }

        yield TeamsRetrieved(teamSpaceMap);
      } catch (e) {}
    }
   
  }
}
