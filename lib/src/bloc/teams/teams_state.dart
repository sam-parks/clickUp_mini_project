part of 'teams_bloc.dart';

@immutable
abstract class TeamsState {}

class TeamsInitial extends TeamsState {}

class TeamsRetrieved extends TeamsState {
  final List<Team> teams;

  TeamsRetrieved(this.teams);
}

class TeamSelected extends TeamsState {
  final String teamID;
  final List<Space> spaces;

  TeamSelected(this.teamID, this.spaces);
}

class TeamsLoadingState extends TeamsState {}
