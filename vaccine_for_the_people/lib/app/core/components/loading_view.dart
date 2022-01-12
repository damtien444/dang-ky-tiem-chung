import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class LoadingWidget extends StatelessWidget {
  final size = Get.size.shortestSide;
  final mini;

  LoadingWidget({
    this.mini = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ratio = mini ? 0.05 : 0.15;
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: Lottie.asset(
          'loading.json',
          fit: BoxFit.cover,
          width: size * ratio,
          height: size * ratio,
        ),
      ),
    );
  }
}
