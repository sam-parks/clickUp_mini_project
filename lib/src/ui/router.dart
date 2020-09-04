import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart' as fluro;

import 'pages/tasks_page.dart';
import 'pages/teams_page.dart';

class Routes {
  static void configureRoutes(fluro.Router router) {
    router.notFoundHandler = fluro.Handler(handlerFunc: (context, parameters) {
      debugPrint("Route was not found.");
      return Container();
    });
    router.define('/teams',
        handler: fluro.Handler(
          handlerFunc: (context, parameters) => TeamsPage(),
        ));
    router.define('/tasks/:id',
        handler: fluro.Handler(
          handlerFunc: (context, parameters) => TasksPage(
            teamID: parameters["id"][0],
          ),
        ));
  }
}
