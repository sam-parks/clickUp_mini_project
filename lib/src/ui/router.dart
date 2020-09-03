import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart' as fluro;

import 'pages/home_page.dart';

class Routes {
  static void configureRoutes(fluro.Router router) {
    router.notFoundHandler = fluro.Handler(handlerFunc: (context, parameters) {
      debugPrint("Route was not found.");
      return Container();
    });
    router.define('/',
        handler: fluro.Handler(
          handlerFunc: (context, parameters) => HomePage(),
        ));
  }
}
