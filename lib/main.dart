import 'package:click_up_tasks/src/app.dart';
import 'package:click_up_tasks/src/data/models/teams_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'config.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => TeamsModel(), child: App(_ProdConfig())));
}

class _ProdConfig extends Config {
  @override
  String get clickupAPIToken => "pk_6379858_6HJDSE3QOE4B6HWL96O5H1RDXTQ3WVFX";
}
