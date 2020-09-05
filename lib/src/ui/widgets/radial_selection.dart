import 'dart:math';
import 'dart:ui';

import 'package:click_up_tasks/src/ui/style.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vector_math/vector_math_64.dart' as math;

class RadialSelection extends StatefulWidget {
  RadialSelection({Key key}) : super(key: key);

  @override
  _RadialSelectionState createState() => _RadialSelectionState();
}

class _RadialSelectionState extends State<RadialSelection>
    with SingleTickerProviderStateMixin {
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: Duration(milliseconds: 900), vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return RadialAnimation(controller: controller);
  }
}

class RadialAnimation extends StatelessWidget {
  RadialAnimation({Key key, this.controller})
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
    return AnimatedBuilder(
      animation: controller,
      builder: (context, builder) {
        return Container(
          margin: const EdgeInsets.all(20),
          child: GestureDetector(
            onTap: () {
              _close();
            },
            child: Stack(
              children: [
                _buildButton(-60, color: AppColors.orange, icon: Icons.folder),
                _buildButton(-120,
                    color: AppColors.deep_violet, icon: Icons.list),
                ButtonTheme(
                  height: 40,
                  minWidth: 40,
                  child: FloatingActionButton(
                    heroTag: "workspace",
                    onPressed: _open,
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
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  _buildButton(double angle, {Color color, IconData icon}) {
    final double rad = math.radians(angle);
    return Transform(
      transform: Matrix4.identity()
        ..translate(
            (translation.value) * cos(rad), (translation.value) * sin(rad)),
      child: FloatingActionButton(
        heroTag: Random().nextInt(100000).toString(),
        backgroundColor: color,
        onPressed: _close,
        child: Icon(icon),
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
