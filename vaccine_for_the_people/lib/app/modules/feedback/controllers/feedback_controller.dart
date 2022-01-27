import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:vaccine_for_the_people/app/core/components/my_dialog.dart';
import 'package:vaccine_for_the_people/app/data/services/repository.dart';

class FeedbackController extends GetxController {
  GlobalKey<FormBuilderState> feedBackFormKey = GlobalKey<FormBuilderState>();
  final ready = true.obs;
  Repository repository;

  FeedbackController({required this.repository});

  Future<void> report(Map<String, dynamic> infoUser) async {
    try {
      ready.value = false;
      final response = await repository.report(infoUser);
      if (response?.result == 'success') {
        _showDialog(true);
        ready.value = true;
        return;
      }
    } catch (e) {
      ready.value = true;
      _showDialog(false);
    }
  }

  void _showDialog(bool isSuccess) {
    Get.dialog(MyDialog(
      isSuccess: isSuccess,
      title: 'Gửi phản hồi thành công',
      failedTitle: 'Gửi phản hồi thất bại, xin vui lòng thử lại',
    ));
  }
}
