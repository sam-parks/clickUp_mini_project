import 'package:click_up_tasks/src/bloc/tasks/task_bloc.dart';
import 'package:click_up_tasks/src/bloc/teams/teams_bloc.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluro/fluro.dart' as fluro;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../config.dart';
import 'data/models/teams_model.dart';
import 'locator.dart';
import 'resources/task_db_provider.dart';
import 'ui/pages/teams_page.dart';
import 'ui/router.dart';
import 'ui/style.dart';

class App extends StatefulWidget {
  const App(
    this.config, {
    Key key,
  }) : super(key: key);

  final Config config;

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final router = fluro.Router();
  // ignore: close_sinks
  TeamsBloc _teamsBloc;
  @override
  void initState() {
    super.initState();

    taskDBProvider.open('clickUpTasks');
    Routes.configureRoutes(router);
    locator.registerSingleton<Config>(widget.config);
    registerLocatorItems(locator.get<Config>().clickupAPIToken);
  }

  @override
  void didChangeDependencies() {
    _teamsBloc = TeamsBloc();
    _teamsBloc.add(RetrieveTeams());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    TeamsModel teamsModel = TeamsModel();
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: MultiBlocProvider(
        providers: [
          BlocProvider.value(value: _teamsBloc),
          BlocProvider(create: (_) => TaskBloc())
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Click Up Tasks',
          theme: kClickUpTheme,
          home: ChangeNotifierProvider.value(
            value: teamsModel,
            child: home(teamsModel),
          ),
          onGenerateRoute: router.generator,
        ),
      ),
    );
  }

  home(TeamsModel teamsModel) {
    return BlocListener(
      cubit: _teamsBloc,
      listener: (context, state) {
        if (state is TeamsRetrieved) {
          teamsModel.updateTeams(state.teams);
        }
        if (state is TeamSelected) {
          // ignore: close_sinks
          TaskBloc folderListTaskBloc = BlocProvider.of<TaskBloc>(context);
          folderListTaskBloc.add(RetrieveTeamTasks(state.teamID));
          router.navigateTo(context, "/tasks/${state.teamID}",
              transition: TransitionType.fadeIn);
        }
      },
      child: TeamsPage(),
    );
  }
}
