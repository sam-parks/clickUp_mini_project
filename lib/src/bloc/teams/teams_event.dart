part of 'teams_bloc.dart';

@immutable
abstract class TeamsEvent {}

class RetrieveTeams extends TeamsEvent {}

class SelectTeam extends TeamsEvent {
  final String teamID;

  SelectTeam(this.teamID);
}
