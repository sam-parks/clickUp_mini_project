import 'package:flare_splash_screen/flare_splash_screen.dart';
import 'package:flutter/material.dart';

class SplashScreenPage extends StatefulWidget {
  SplashScreenPage({Key key}) : super(key: key);

  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  Widget build(BuildContext context) {
    String asset = "assets/flare_splash.flr";
    var _size = MediaQuery.of(context).size;
    return SplashScreen.callback(
      height: _size.height,
      startAnimation: '0',
      endAnimation: '4',
      loopAnimation: 'Untitled',
      backgroundColor: Colors.white,
      name: asset,
      until: () => Future.delayed(Duration(milliseconds: 4)),
      onSuccess: (_) => Navigator.of(context).pushNamed('/teams'),
      onError: (error, stacktrace) {},
    );
  }
}
