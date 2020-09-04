import 'package:carousel_slider/carousel_slider.dart';
import 'package:click_up_tasks/src/bloc/teams/teams_bloc.dart';
import 'package:click_up_tasks/src/data/models/teams_model.dart';
import 'package:click_up_tasks/src/ui/style.dart';
import 'package:click_up_tasks/src/ui/widgets/circle_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

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
        title: Text("Teams"),
      ),
      body: teamsModel.teams == null
          ? Center(child: CircularProgressIndicator())
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Select Your Space",
                    style:
                        TextStyle(color: AppColors.deep_violet, fontSize: 40),
                  ),
                  Column(
                    children: [
                      CarouselSlider(
                        options: CarouselOptions(
                            height: 400,
                            onPageChanged: (index, reason) {
                              setState(() {
                                _currentCarouselIndex = index;
                              });
                            }),
                        items: teamsModel.teams.map((team) {
                          return Builder(
                            builder: (BuildContext context) {
                              return GestureDetector(
                                onTap: () => teamsBloc
                                    .add(SelectTeam(teamsModel.teams.first.id)),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                                  child: Stack(
                                    children: [
                                      CustomPaint(
                                        size: Size.infinite, //2
                                        painter: SpaceCirclePainter(
                                            AppColors.orange_pink), //3
                                      ),
                                      Center(
                                        child: Text(team.name),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        }).toList(),
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
                  ),
                ],
              ),
            ),
    );
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
    Path oval = Path()
      ..addOval(Rect.fromCircle(center: center, radius: radius + 10));
    Paint shadowPaint = Paint()
      ..color = Colors.black.withOpacity(0.3)
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
