import 'package:click_up_tasks/src/bloc/clickUpList/clickuplist_bloc.dart';
import 'package:click_up_tasks/src/data/clickup_list.dart';
import 'package:click_up_tasks/src/ui/style.dart';
import 'package:click_up_tasks/src/ui/widgets/radial_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ListPage extends StatefulWidget {
  ListPage({Key key, this.teamID}) : super(key: key);
  final String teamID;

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  List<ClickupList> clickUpLists = [];

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    ClickuplistBloc clickuplistBloc = BlocProvider.of<ClickuplistBloc>(context);
    clickUpLists = clickuplistBloc.clickUpLists;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text("Lists", style: TextStyle(color: Colors.white)),
        leading: Container(),
      ),
      body: BlocListener(
        cubit: clickuplistBloc,
        listener: (context, state) {
          if (state is ClickUpListsReordered) {
            setState(() {});
          }
        },
        child: clickUpLists.isEmpty
            ? Center(
                child: Opacity(
                    opacity: .4, child: SvgPicture.asset('assets/clickup.svg')),
              )
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: ReorderableListView(
                    onReorder: (int oldIndex, int newIndex) {
                      setState(
                        () {
                          if (newIndex > oldIndex) {
                            newIndex -= 1;
                          }
                          final ClickupList list =
                              clickUpLists.removeAt(oldIndex);
                          clickUpLists.insert(newIndex, list);
                          clickuplistBloc
                              .add(ReorderClickUpLists(clickUpLists));
                        },
                      );
                    },
                    children: List.generate(
                        clickUpLists.length,
                        (index) => ListTile(
                              key: ValueKey(clickUpLists[index].id),
                              trailing: Icon(Icons.reorder),
                              title: Text(clickUpLists[index].name),
                            ))),
              ),
      ),
      floatingActionButton: RadialMenu(widget.teamID, MenuType.lists),
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
              IconButton(
                icon: Icon(FontAwesomeIcons.home),
                color: Colors.white,
                onPressed: () async {
                  Navigator.of(context).pop();
                },
              ),
              Spacer(),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
