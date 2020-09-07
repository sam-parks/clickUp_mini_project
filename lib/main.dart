import 'package:click_up_tasks/src/app.dart';
import 'package:click_up_tasks/src/bloc/clickUpList/clickuplist_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:fluro/fluro.dart' as fluro;
import 'config.dart';
import 'src/bloc/tasks/task_bloc.dart';
import 'src/bloc/teams/teams_bloc.dart';
import 'src/data/models/teams_model.dart';

void main() {
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => TeamsModel(),
        ),
        Provider(
          create: (_) => fluro.Router(),
        ),
      ],
      child: MultiBlocProvider(providers: [
        BlocProvider(create: (_) => TeamsBloc()),
        BlocProvider(create: (_) => TaskBloc()),
        BlocProvider(create: (_) => ClickuplistBloc())
      ], child: App(_ProdConfig()))));
}

class _ProdConfig extends Config {
  @override
  String get clickupAPIToken => "pk_6379858_6HJDSE3QOE4B6HWL96O5H1RDXTQ3WVFX";
}
