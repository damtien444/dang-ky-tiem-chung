import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:vaccine_for_the_people/app/data/services/repository.dart';
import 'package:vaccine_for_the_people/app/modules/feedback/controllers/feedback_controller.dart';
import 'package:vaccine_for_the_people/app/modules/navigation/controller/navigation_controller.dart';
import 'package:vaccine_for_the_people/app/routes/app_routes.dart';

class LoginController extends GetxController {
  Repository repository;

  LoginController({required this.repository});

  final loginFormKey = GlobalKey<FormBuilderState>();
  final ready = false.obs;
  final error = ''.obs;

  Future<void> login(String username, String password) async {
    ready.value = false;
    try {
      error.value = '';
      final response = await repository.login(username, password);
      ready.value = true;
      if (response!.isEmpty) {
        error.value = 'Lỗi không đăng nhập được';
        return;
      }
      Get.delete<FeedbackController>();
      Get.delete<LoginController>();
      Get.delete<NavigationController>();
      Get.toNamed(Routes.NAVIGATIONADMIN);
    } catch (e) {
      error.value = 'Lỗi không đăng nhập được';
      ready.value = true;
    }
  }
}
