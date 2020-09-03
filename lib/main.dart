import 'package:click_up_tasks/src/app.dart';
import 'package:flutter/material.dart';

import 'config.dart';

void main() {
  runApp(App(_ProdConfig()));
}

class _ProdConfig extends Config {
  @override
  String get clickupAPIKey => "pk_6379858_6HJDSE3QOE4B6HWL96O5H1RDXTQ3WVFX";
}
