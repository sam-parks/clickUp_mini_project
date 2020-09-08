import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:click_up_tasks/src/bloc/teams/teams_bloc.dart';
import 'package:click_up_tasks/src/data/models/teams_model.dart';
import 'package:click_up_tasks/src/data/space.dart';
import 'package:click_up_tasks/src/ui/style.dart';
import 'package:click_up_tasks/src/ui/widgets/circle_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:fluro/fluro.dart' as fluro;

class TeamsPage extends StatefulWidget {
  TeamsPage({Key key}) : super(key: key);

  @override
  _TeamsPageState createState() => _TeamsPageState();
}

class _TeamsPageState extends State<TeamsPage> {
  int _currentCarouselIndex = 0;
  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    TeamsBloc teamsBloc = BlocProvider.of<TeamsBloc>(context);
    TeamsModel teamsModel = Provider.of<TeamsModel>(context);
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text("Teams", style: TextStyle(color: Colors.white)),
      ),
      body: BlocBuilder(
        cubit: teamsBloc,
        builder: (context, state) {
          if (state is TeamsRetrieved) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 400,
                  child: CarouselSlider(
                    options: CarouselOptions(
                        height: 400,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _currentCarouselIndex = index;
                          });
                        }),
                    items: _expandableTeamBubbles(teamsModel.teams),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      for (int i = 0; i < teamsModel.teams.length; i++)
                        if (i == _currentCarouselIndex) ...[
                          CircleBar(
                            isActive: true,
                          )
                        ] else
                          CircleBar(
                            isActive: false,
                          ),
                    ],
                  ),
                ),
              ],
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  _expandableTeamBubbles(Map<Team, List<Space>> teamSpaceMaps) {
    fluro.Router router = Provider.of<fluro.Router>(context);
    return List.generate(teamSpaceMaps.length, (index) {
      Team team = teamSpaceMaps.keys.toList()[index];
      return Builder(
        builder: (BuildContext context) {
          return GestureDetector(
            onTap: () {
              router.navigateTo(context, "/spaces/${team.id}",
                  transition: fluro.TransitionType.fadeIn);
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 5.0),
              child: Stack(
                children: [
                  CustomPaint(
                    size: Size.infinite, //2
                    painter: SpaceCirclePainter(
                        AppColors.allColors[Random().nextInt(7)]), //3
                  ),
                  Center(
                    child: Text(
                      team.name,
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      );
    });
  }
}

class SpaceCirclePainter extends CustomPainter {
  final Color color;

  SpaceCirclePainter(this.color);
  @override
  void paint(Canvas canvas, Size size) {
    double radius = 100.0;
    canvas.translate(size.width / 2, size.height / 2);
    Offset center = Offset(0.0, 0.0);
    // draw back shadow first
    var gradient = RadialGradient(
      center: const Alignment(0.0, 0.0), // near the top right
      radius: 0.2,
      colors: [
        AppColors.orange, // yellow sun
        AppColors.pink, AppColors.light_blue, AppColors.purple_blue,
        AppColors.violet, // blue sky
      ],
      stops: [0.2, .2, .4, .6, 1.0],
    );
    Path oval = Path()
      ..addOval(Rect.fromCircle(center: center, radius: radius + 10));
    Paint shadowPaint = Paint()
      ..shader = gradient
          .createShader(Rect.fromCircle(center: center, radius: radius + 10))
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 50);
    canvas.drawPath(oval, shadowPaint);
    // draw circle
    Paint thumbPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, radius, thumbPaint);
  }

  @override
  bool shouldRepaint(SpaceCirclePainter oldDelegate) {
    return false;
  }
}
