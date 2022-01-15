import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:vaccine_for_the_people/app/core/components/my_dialog.dart';
import 'package:vaccine_for_the_people/app/data/services/repository.dart';
import 'package:vaccine_for_the_people/app/routes/app_routes.dart';

class LoginController extends GetxController {
  Repository repository;

  LoginController({required this.repository});

  final loginFormKey = GlobalKey<FormBuilderState>();
  final ready = true.obs;

  Future<void> login(String username, String password) async {
    try {
      ready.value = false;
      final response = await repository.login(username, password);
      if (response!.isEmpty) {
        ready.value = true;
        _showDialog();
        return;
      }
      await Get.offAndToNamed(Routes.NAVIGATIONADMIN);
      ready.value = true;
    } catch (e) {
      ready.value = true;
      _showDialog();
    }
  }

  void _showDialog() {
    Get.dialog(const MyDialog());
  }
}
