import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
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
  GlobalKey<FormBuilderState> confirmFeedBackFormKey = GlobalKey<FormBuilderState>();
  RxString feedback="".obs;
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
  Future<void> replyFeedback(String id,String content,int index)async{
    bool checkData=await Repository.replyFeedback(id,content);
    if(checkData){
      listFeedbackSolve.add(
          Solved(
              sId: listFeedbackNotSolve[index].sId,
              name: listFeedbackNotSolve[index].name,
              email: listFeedbackNotSolve[index].email,
              dateCreatedVn: listFeedbackNotSolve[index].dateCreatedVn,
              hasResponse: true,
              status: "SOLVED",
              content: listFeedbackNotSolve[index].content,
              response: feedback.value
          )
      );
      listFeedbackNotSolve.removeAt(index);
      Get.back();
      Get.snackbar(
        "Phản hồi thành công",
        "Bạn đã phản hồi yêu cầu khách hàng",
        titleText: Text("Phản hồi thành công",style: TextStyle(color: Colors.white),textAlign: TextAlign.center,),
        messageText: Text(
          "Bạn đã phản hồi yêu cầu khách hàng",
          style: TextStyle(color: Colors.white),textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.green,
        snackPosition: SnackPosition.TOP,
        maxWidth: 300,
        padding: EdgeInsets.symmetric(horizontal: 25,vertical: 10),
        margin: EdgeInsets.only(top:10),
      );
    }
    else{
      Get.back();
      Get.snackbar(
        "Phản hồi thất bại",
        "Có lỗi xảy ra, hãy thử lại sau",
        titleText: Text("Phản hồi thất bại",style: TextStyle(color: Colors.white),textAlign: TextAlign.center,),
        messageText: Text(
          "Có lỗi xảy ra, hãy thử lại sau",
          style: TextStyle(color: Colors.white),textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.TOP,
        maxWidth: 300,
        padding: EdgeInsets.symmetric(horizontal: 25,vertical: 10),
        margin: EdgeInsets.only(top:10),
      );
    }
  }
  Future<void> deleteFeedback(String id, int index)async{
    bool checkData=await Repository.deleteFeedback(id);
    if(checkData){
      if(isClickBtnSolve.value){
        listFeedbackSolve.removeAt(index);
        listFeedbackSolve.refresh();
      }
      else{
        listFeedbackNotSolve.removeAt(index);
        listFeedbackNotSolve.refresh();
      }
      Get.back();
      Get.snackbar(
        "Xóa thành công",
        "Bạn đã xóa thành công phản hồi từ khách hàng",
        titleText: Text("Xóa thành công",style: TextStyle(color: Colors.white),textAlign: TextAlign.center,),
        messageText: Text(
          "Bạn đã xóa thành công phản hồi từ khách hàng",
          style: TextStyle(color: Colors.white),textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.green,
        snackPosition: SnackPosition.TOP,
        maxWidth: 300,
        padding: EdgeInsets.symmetric(horizontal: 25,vertical: 10),
        margin: EdgeInsets.only(top:10),
      );
    }
    else{
      Get.back();
      Get.snackbar(
        "Xóa thất bại",
        "Vui lòng thử lại sau",
        titleText: Text("Xóa thất bại",style: TextStyle(color: Colors.white),textAlign: TextAlign.center,),
        messageText: Text(
          "Vui lòng thử lại sau",
          style: TextStyle(color: Colors.white),textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.TOP,
        maxWidth: 300,
        padding: EdgeInsets.symmetric(horizontal: 25,vertical: 10),
        margin: EdgeInsets.only(top:10),
      );
    }
  }
  @override
  Future<void> onInit() async{
    // TODO: implement onInit
    super.onInit();
    await getDataFeedBack();
  }

}