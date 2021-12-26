import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

class FeedbackController extends GetxController {
  final feedBackFormKey = GlobalKey<FormBuilderState>();
  final FocusNode focusNode = FocusNode();
}
