import 'package:click_up_tasks/src/bloc/teams/teams_bloc.dart';
import 'package:click_up_tasks/src/ui/pages/teams_page.dart';
import 'package:flare_splash_screen/flare_splash_screen.dart';
import 'package:fluro/fluro.dart' as fluro;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import '../config.dart';
import 'data/models/teams_model.dart';
import 'locator.dart';
import 'resources/task_db_provider.dart';
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
  // ignore: close_sinks
  TeamsBloc _teamsBloc;
  TeamsModel teamsModel;
  fluro.Router router;

  @override
  void initState() {
    super.initState();
    taskDBProvider.open('clickUpTasks');
    locator.registerSingleton<Config>(widget.config);
    registerLocatorItems(locator.get<Config>().clickupAPIToken);
  }

  @override
  void didChangeDependencies() {
    _teamsBloc = BlocProvider.of<TeamsBloc>(context);
    _teamsBloc.add(RetrieveTeams());
    teamsModel = Provider.of<TeamsModel>(context);
    router = Provider.of<fluro.Router>(context);
    Routes.configureRoutes(router);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    String asset = "assets/clickUp.flr";
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
        home: BlocListener(
          cubit: _teamsBloc,
          listener: (context, state) {
            if (state is TeamsRetrieved) {
              teamsModel.updateTeams(state.teamSpaceMap);
            }
          },
          child: SplashScreen.navigate(
            startAnimation: '0',
            endAnimation: '2',
            loopAnimation: '1',
            backgroundColor: Colors.white,
            name: asset,
            until: () => Future.delayed(Duration(seconds: 4)),
            next: (context) => TeamsPage(),
          ),
        ),
        onGenerateRoute: router.generator,
      ),
    );
  }
}
