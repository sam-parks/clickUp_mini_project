part of 'teams_bloc.dart';

@immutable
abstract class TeamsState {}

class TeamsInitial extends TeamsState {}

class TeamsRetrieved extends TeamsState {
  final Map<Team, List<Space>> teamSpaceMap;

  TeamsRetrieved(this.teamSpaceMap);
}





class TeamsLoadingState extends TeamsState {}
