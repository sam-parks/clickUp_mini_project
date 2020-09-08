import 'dart:math';

import 'package:click_up_tasks/src/ui/style.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:vector_math/vector_math_64.dart' as math;
import 'package:fluro/fluro.dart' as fluro;

enum MenuType { tasks, lists }

class RadialMenu extends StatefulWidget {
  RadialMenu(
    this.teamID,
    this.menuType, {
    Key key,
  }) : super(key: key);
  final String teamID;
  final MenuType menuType;
  @override
  _RadialMenuState createState() => _RadialMenuState();
}

class _RadialMenuState extends State<RadialMenu>
    with SingleTickerProviderStateMixin {
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: Duration(milliseconds: 900), vsync: this);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RadialAnimation(widget.teamID, widget.menuType,
        controller: controller);
  }
}

class RadialAnimation extends StatelessWidget {
  final String teamID;
  final MenuType menuType;
  RadialAnimation(this.teamID, this.menuType, {Key key, this.controller})
      : scale = Tween<double>(
          begin: 1.5,
          end: 0.0,
        ).animate(
            CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn)),
        translation = Tween<double>(
          begin: 0,
          end: 100,
        ).animate(
            CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn)),
        super(key: key);

  final AnimationController controller;
  final Animation<double> scale;
  final Animation<double> translation;

  @override
  Widget build(BuildContext context) {
    fluro.Router router = Provider.of<fluro.Router>(context);
    return AnimatedBuilder(
      animation: controller,
      builder: (context, builder) {
        return Container(
          width: 200,
          height: 200,
          margin: const EdgeInsets.only(bottom: 20.0),
          child: Stack(
            children: [
              _buildButton(-60, color: AppColors.orange, icon: Icons.folder),
              menuType == MenuType.tasks
                  ? _buildButton(-120,
                      color: AppColors.deep_violet,
                      icon: Icons.list, onPressed: () {
                      _close();
                      router.pop(context);
                      
                      router.navigateTo(context, "/lists/$teamID",
                          transition: fluro.TransitionType.fadeIn);
                    })
                  : _buildButton(-120,
                      color: AppColors.deep_violet,
                      icon: FontAwesomeIcons.tasks, onPressed: () {
                      _close();
                      router.pop(context);
                      router.navigateTo(context, "/tasks/$teamID",
                          transition: fluro.TransitionType.fadeIn);
                    }),
              Align(
                alignment: Alignment.bottomCenter,
                child: Transform.scale(
                    scale: scale.value - 1,
                    child: FloatingActionButton(
                      child: const Icon(
                        Icons.close,
                        color: Colors.red,
                      ),
                      heroTag: "fab1",
                      onPressed: _close,
                      backgroundColor: Colors.white,
                    )),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Transform.scale(
                  scale: scale.value,
                  child: ButtonTheme(
                    height: 40,
                    minWidth: 40,
                    child: FloatingActionButton(
                      heroTag: "fab3",
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(colors: [
                              AppColors.orange,
                              AppColors.orange_pink,
                              AppColors.pink,
                              AppColors.violet,
                              AppColors.deep_violet,
                            ])),
                        child: const Icon(
                          FontAwesomeIcons.circleNotch,
                          color: Colors.white,
                        ),
                      ),
                      onPressed: _open,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  _buildButton(double angle, {Color color, IconData icon, Function onPressed}) {
    final double rad = math.radians(angle);
    return Align(
      alignment: Alignment.bottomCenter,
      child: Transform(
        transform: Matrix4.identity()
          ..translate(
              (translation.value) * cos(rad), (translation.value) * sin(rad)),
        child: FloatingActionButton(
          heroTag: Random().nextInt(100000).toString(),
          backgroundColor: color,
          onPressed: onPressed,
          child: Icon(icon, color: Colors.white),
        ),
      ),
    );
  }

  _open() {
    controller.forward();
  }

  _close() {
    controller.reverse();
  }
}
