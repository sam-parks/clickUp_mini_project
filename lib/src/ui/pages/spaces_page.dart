import 'package:circle_wheel_scroll/circle_wheel_scroll_view.dart';
import 'package:click_up_tasks/src/bloc/tasks/task_bloc.dart';
import 'package:click_up_tasks/src/data/models/teams_model.dart';
import 'package:click_up_tasks/src/data/space.dart';
import 'package:click_up_tasks/src/ui/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:fluro/fluro.dart' as fluro;

class SpacesPage extends StatefulWidget {
  SpacesPage({Key key, this.teamID}) : super(key: key);
  final String teamID;
  @override
  _SpacesPageState createState() => _SpacesPageState();
}

class _SpacesPageState extends State<SpacesPage> {
  int _selectedItemIndex = 0;

  ScrollController _innerCircleScrollController = ScrollController();
  ScrollController _outerCircleScrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    TeamsModel teamsModel = Provider.of<TeamsModel>(context);
    fluro.Router router = Provider.of<fluro.Router>(context);
    Team team =
        teamsModel.teams.keys.firstWhere((team) => team.id == widget.teamID);
    Space selectedSpace = teamsModel.teams[team][_selectedItemIndex];
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text("Spaces"),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: CircleListScrollView(
                      controller: _innerCircleScrollController,
                      physics: NeverScrollableScrollPhysics(),
                      radius: MediaQuery.of(context).size.width * 0.8,
                      itemExtent: 30,
                      children:
                          List.generate(teamsModel.teams[team].length, (index) {
                        return Center(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(40),
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 500),
                              width: _selectedItemIndex == index ? 15 : 5,
                              height: _selectedItemIndex == index ? 120 : 30,
                              padding: EdgeInsets.all(20),
                              color: AppColors.allColors[index],
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: CircleListScrollView(
                      onSelectedItemChanged: (index) {
                        setState(() {
                          _selectedItemIndex = index;
                          _innerCircleScrollController.animateTo(index * 40.0,
                              duration: Duration(milliseconds: 1000),
                              curve: Curves.bounceOut);
                        });
                      },
                      radius: MediaQuery.of(context).size.width * 0.8,
                      itemExtent: 80,
                      children:
                          List.generate(teamsModel.teams[team].length, (index) {
                        Space space = teamsModel.teams[team][index];
                        return Center(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(40),
                            child: Container(
                              width: 200,
                              padding: EdgeInsets.all(20),
                              color: AppColors.allColors[index],
                              child: Center(
                                child: Text(space.name),
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () => _selectSpace(router, context, selectedSpace.id),
              child: Container(
                margin: const EdgeInsets.all(50),
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Container(
                    child: Center(
                      child: Text(
                        "Expand ${selectedSpace.name}",
                        style: TextStyle(
                            fontSize: 20,
                            color: AppColors.allColors[_selectedItemIndex]),
                      ),
                    ),
                    decoration: kInnerDecoration,
                  ),
                ),
                height: 66.0,
                decoration: kGradientBoxDecoration,
              ),
            ),
          ],
        ),
      ),
    );
  }

  _selectSpace(fluro.Router router, BuildContext context, String spaceID) {
    // ignore: close_sinks
    TaskBloc taskBloc = BlocProvider.of<TaskBloc>(context);
    taskBloc.add(RetrieveSpaceTasks(spaceID));
    router.navigateTo(context, "/tasks/$spaceID",
        transition: fluro.TransitionType.fadeIn);
  }
}

final kInnerDecoration = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.circular(5),
  border: Border.all(color: Colors.white),
);

final kGradientBoxDecoration = BoxDecoration(
  gradient: LinearGradient(colors: [AppColors.orange, AppColors.pink]),
  borderRadius: BorderRadius.circular(5),
  border: Border.all(
    color: AppColors.violet,
  ),
);
