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

  TeamSelected(this.teamID);
}

class TeamsLoadingState extends TeamsState {}
