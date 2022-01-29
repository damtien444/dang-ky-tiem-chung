import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:vaccine_for_the_people/app/core/components/my_dialog.dart';
import 'package:vaccine_for_the_people/app/data/models/search_response.dart';
import 'package:vaccine_for_the_people/app/data/services/repository.dart';
import 'package:vaccine_for_the_people/app/data/utils/formatters.dart';

class SearchFeedbackController extends GetxController {
  Repository repository;

  SearchFeedbackController({required this.repository});

  GlobalKey<FormBuilderState> searchFeedbackFormKey =
      GlobalKey<FormBuilderState>();
  final ready = true.obs;

  Future<void> searchResult(String name, String email) async {
    try {
      ready.value = false;
      final response = await repository.searchFeedBack(name, email);
      if (response != null && response.result == 'success') {
        ready.value = true;
        _showDialog(
            receiveMessage: response.report, isSuccess: true, isMessage: true);
        return;
      } else {
        _showDialog(isSuccess: false, isMessage: false);
      }
      ready.value = true;
    } catch (e) {
      ready.value = true;
      _showDialog(isSuccess: false, isMessage: false);
    }
  }

  String utf8convert(String? text) {
    List<int> bytes = text.toString().codeUnits;
    return utf8.decode(bytes);
  }

  void _showDialog(
      {Reports? receiveMessage, bool? isSuccess, bool? isMessage}) {
    String content = utf8convert(receiveMessage?.content);
    String date = utf8convert(formatterFullDate(receiveMessage?.dateCreatedVn));
    String response = utf8convert(receiveMessage?.response);
    String status = utf8convert(receiveMessage?.status);
    String name = utf8convert(receiveMessage?.name);
    Get.dialog(
      MyDialog(
        hasLongMessage: isMessage!,
        isSuccess: isSuccess!,
        title: '''
              Phản hồi từ ban tiêm chủng
           
Nội dung yêu cầu: $content
Ngày tạo:$name
Ngày tạo:$date 
Nội dung phản hồi:$response 
Trạng thái: $status
          ''',
        failedTitle: 'Tìm kiếm phản hồi thất bại, xin vui lòng thử lại',
      ),
    );
  }
}
