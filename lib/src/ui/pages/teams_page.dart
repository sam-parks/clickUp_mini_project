import 'package:carousel_slider/carousel_slider.dart';
import 'package:click_up_tasks/src/bloc/teams/teams_bloc.dart';
import 'package:click_up_tasks/src/data/models/teams_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class TeamsPage extends StatefulWidget {
  TeamsPage({Key key}) : super(key: key);

  @override
  _TeamsPageState createState() => _TeamsPageState();
}

class _TeamsPageState extends State<TeamsPage> {
  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    TeamsBloc teamsBloc = BlocProvider.of<TeamsBloc>(context);
    TeamsModel teamsModel = Provider.of<TeamsModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Teams"),
      ),
      body: teamsModel.teams == null
          ? CircularProgressIndicator()
          : Center(
              child: CarouselSlider(
                options: CarouselOptions(height: 400.0),
                items: teamsModel.teams.map((team) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        child: Stack(
                          children: [
                            CustomPaint(
                              size: Size.infinite, //2
                              painter: SpaceCirclePainter(), //3
                            ),
                            Center(
                              child: Text(team.name),
                            )
                          ],
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => teamsBloc.add(SelectTeam(teamsModel.teams.first.id)),
      ),
    );
  }
}

class SpaceCirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double radius = 100.0;
    canvas.translate(size.width / 2, size.height / 2);
    Offset center = Offset(0.0, 0.0);
    // draw shadow first
    Path oval = Path()
      ..addOval(Rect.fromCircle(center: center, radius: radius + 10));
    Paint shadowPaint = Paint()
      ..color = Colors.black.withOpacity(0.3)
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 50);
    canvas.drawPath(oval, shadowPaint);
    // draw circle
    Paint thumbPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, radius, thumbPaint);
  }

  @override
  bool shouldRepaint(SpaceCirclePainter oldDelegate) {
    return false;
  }
}
