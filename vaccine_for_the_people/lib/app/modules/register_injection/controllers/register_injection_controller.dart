import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

class RegisterInjectionController extends GetxController {
  final regInjectionFormKey = GlobalKey<FormBuilderState>();
  final List<String> orderInjection = ['Mũi tiêm thứ nhất', 'Mũi tiêm thứ hai'];
  final List<String> genders = ['Nam', 'Nữ'];
  final bool isEnable = false;

  @override
  void onInit() {
    super.onInit();
  }

}
