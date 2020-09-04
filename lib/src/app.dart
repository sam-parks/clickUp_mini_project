import 'package:click_up_tasks/src/bloc/teams/teams_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluro/fluro.dart' as fluro;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../config.dart';
import 'data/models/teams_model.dart';
import 'locator.dart';
import 'ui/pages/home_page.dart';
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
    Routes.configureRoutes(router);
    locator.registerSingleton<Config>(widget.config);
    registerLocatorItems(locator.get<Config>().clickupAPIToken);
  }

  @override
  void didChangeDependencies() {
    _teamsBloc = BlocProvider.of<TeamsBloc>(context);
    _teamsBloc.add(RetrieveTeams());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Click Up Tasks',
        theme: kClickUpTheme,
        home: HomePage(),
        onGenerateRoute: router.generator,
      ),
    );
  }

  home() {
    return BlocBuilder(
        cubit: _teamsBloc,
        builder: (context, state) {
          if (state is TeamsRetrieved) {
            TeamsModel teamsModel = Provider.of<TeamsModel>(context);
            teamsModel.updateTeams(state.teams);
            return HomePage();
          }
          return HomePage();
        });
  }
}
