import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../config.dart';
import 'locator.dart';

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
  @override
  void initState() {
    super.initState();
    locator.registerSingleton<Config>(widget.config);
    registerLocatorItems(Provider.of<Config>(context).clickupAPIKey);
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
        theme: ThemeData(
          primarySwatch: Colors.brown,
        ),
        home: HomePage(),
        onGenerateRoute: Router.onGenerateRoute,
      ),
    );
  }
}
