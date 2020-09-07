import 'package:click_up_tasks/src/bloc/tasks/task_bloc.dart';
import 'package:click_up_tasks/src/data/clickup_list.dart';
import 'package:click_up_tasks/src/ui/style.dart';
import 'package:click_up_tasks/src/ui/widgets/radial_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ListPage extends StatefulWidget {
  ListPage({Key key, this.teamID}) : super(key: key);
  final String teamID;

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  List<ClickupList> clickUpLists;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    TaskBloc taskBloc = BlocProvider.of<TaskBloc>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text("Lists", style: TextStyle(color: Colors.white)),
      ),
      body: BlocBuilder(
        cubit: taskBloc,
        builder: (context, state) {
          if (state is TaskStateLoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is TasksRetrieved) {
            clickUpLists = state.items['clickUpLists'];
          }
          if (state is TasksRefreshed) {
            clickUpLists = state.items['clickUpLists'];
            _refreshController.loadComplete();
            _refreshController.refreshCompleted();
          }

          return clickUpLists.isEmpty
              ? Center(
                  child: Opacity(
                      opacity: .4,
                      child: SvgPicture.asset('assets/clickup.svg')),
                )
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SmartRefresher(
                    enablePullDown: true,
                    onRefresh: () =>
                        taskBloc.add(RefreshSpaceTasks(widget.teamID)),
                    header: WaterDropHeader(
                      waterDropColor: AppColors.violet,
                    ),
                    controller: _refreshController,
                    child: ListView.builder(
                        itemCount: clickUpLists.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: Text(clickUpLists[index].name),
                          );
                        }),
                  ),
                );
        },
      ),
      floatingActionButton: RadialMenu(widget.teamID),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            AppColors.light_blue,
            AppColors.purple_blue,
            AppColors.purple
          ])),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Spacer(),
              IconButton(
                icon: Icon(Icons.add),
                color: Colors.white,
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
