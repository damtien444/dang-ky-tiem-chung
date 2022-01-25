import 'dart:convert';

import 'package:get/get.dart';
import 'package:vaccine_for_the_people/app/data/models/feed_back_model.dart';
import 'package:vaccine_for_the_people/app/data/services/repository.dart';

class AdminFeedBackController extends GetxController{
  Repository repository;
  AdminFeedBackController({required this.repository});
  RxBool isClickBtnSolve=false.obs;
  RxBool isClickBtnNotSolve=false.obs;
  RxBool isClickBtn=false.obs;
  RxBool isLoadingWidget=false.obs;

  String utf8convert(String text) {
    List<int> bytes = text.toString().codeUnits;
    return utf8.decode(bytes);
  }

  final listFeedbackSolve = <Solved>[].obs;
  final listFeedbackNotSolve = <NotSolve>[].obs;
  Future<void> getDataFeedBack()async{
    final data=await Repository.getDataFeedback();
    listFeedbackSolve.value=data.solved!;
    listFeedbackNotSolve.value=data.notSolve!;
  }
  @override
  Future<void> onInit() async{
    // TODO: implement onInit
    super.onInit();
    await getDataFeedBack();
  }

}