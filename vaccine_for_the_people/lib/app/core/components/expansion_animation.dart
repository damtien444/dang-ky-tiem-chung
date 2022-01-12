import 'package:flutter/material.dart';

class ExpansionAnimation extends StatefulWidget {
  const ExpansionAnimation({
    Key? key,
    required this.shouldExpand,
    required this.child,
    this.axis = Axis.vertical,
    this.axisAlignment = 1.0,
  }) : super(key: key);

  final Widget child;
  final bool shouldExpand;
  final Axis axis;
  final double axisAlignment;

  @override
  _ExpansionAnimationState createState() => _ExpansionAnimationState();
}

class _ExpansionAnimationState extends State<ExpansionAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController expandController;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    prepareAnimations();
    _runExpandCheck();
  }

  void prepareAnimations() {
    expandController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 320),
    );
    animation = CurvedAnimation(
      parent: expandController,
      curve: Curves.fastOutSlowIn,
    );
  }

  void _runExpandCheck() {
    if (widget.shouldExpand) {
      expandController.forward();
    } else {
      expandController.reverse();
    }
  }

  @override
  void didUpdateWidget(ExpansionAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);
    _runExpandCheck();
  }

  @override
  void dispose() {
    expandController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      axisAlignment: widget.axisAlignment,
      axis: widget.axis,
      sizeFactor: animation,
      child: widget.child,
    );
  }
}
