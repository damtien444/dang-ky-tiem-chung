import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vaccine_for_the_people/app/data/models/model_create_campaign_injection.dart';
import 'package:vaccine_for_the_people/app/data/models/model_detail_one_campaign_injection.dart';
import 'package:vaccine_for_the_people/app/data/models/model_dropdown_button.dart';
import 'package:vaccine_for_the_people/app/data/services/repository.dart';

class CreateInjectionCampaignController extends GetxController{
  Repository repository;
  CreateInjectionCampaignController({required this.repository});
  final listCampaignAlreadyConfirm = <IdConfirmed>[].obs;
  final listCampaignNotConfirm = <IdConfirmed>[].obs;
  final listCampaignAlreadyConfirm1 = <IdConfirmed>[].obs;
  final listCampaignNotConfirm1 = <IdConfirmed>[].obs;
  final listBtnConfirm = <ModelDropdownBtn>[].obs;
  final listBtnNotConfirm = <ModelDropdownBtn>[].obs;
  final listPeopleInCampaign = <ListOfPeopleDetail>[].obs;
  final RxString idCampaignClick="".obs;
  final RxBool isClickListConfirm=false.obs;
  final RxBool isClickListNotConfirm=false.obs;
  final RxBool isHaveBtnConfirm=false.obs;
  final RxBool isLoadingWidget=false.obs;
  final RxBool isLoadingUpdate=false.obs;
  final RxInt selectedIndexConfirm=1000.obs;
  final RxInt selectedIndexNotConfirm=1000.obs;
  final RxInt countPage=0.obs;
  final RxString textDisplay="".obs;

  String utf8convert(String text) {
    List<int> bytes = text.toString().codeUnits;
    return utf8.decode(bytes);
  }

  Future<void> getDataConfirmed()async{
    final data=await Repository.getDataCampaignInjection();
    listCampaignAlreadyConfirm.value=data.lIdConfirmed!;
    listCampaignNotConfirm.value=data.lIdNotConfirm!;
    listCampaignNotConfirm1.value=listCampaignNotConfirm;
    listCampaignAlreadyConfirm1.value=listCampaignAlreadyConfirm;
  }

  Future<void> getListBtnData()async{
   for(int i=0;i<listCampaignAlreadyConfirm.length;i++){
     listBtnConfirm.add(ModelDropdownBtn(
         name: listCampaignAlreadyConfirm[i].name.toString(),
         id: listCampaignAlreadyConfirm[i].sId.toString(),
         dateStartCampaign: listCampaignAlreadyConfirm[i].dateStart.toString(),
         dateEndCampaign: listCampaignAlreadyConfirm[i].dateEnd.toString(),
         placeCampaign: listCampaignAlreadyConfirm[i].datePlace.toString()
      ),
     );
   }
   for(int i=0;i<listCampaignNotConfirm.length;i++){
     listBtnNotConfirm.add(
         ModelDropdownBtn(
             name: listCampaignNotConfirm[i].name.toString(),
             id: listCampaignNotConfirm[i].sId.toString(),
             dateStartCampaign: listCampaignNotConfirm[i].dateStart.toString(),
             dateEndCampaign: listCampaignNotConfirm[i].dateEnd.toString(),
             placeCampaign: listCampaignNotConfirm[i].datePlace.toString()
         )
     );
   }
  }
  Future<void> getDataOneCampaignInjection(String id)async{
    isLoadingWidget.value=true;
    final data=await Repository.getDetailOneDataCampaignInjection(id);
    listPeopleInCampaign.value=data.currentShotCampaign!.listOfPeople!;
    isLoadingWidget.value=false;
  }
  Future<void> deletePeopleCampaignInjection(String idCampaign,String idPeople)async{
    print("id1: "+idCampaign+" id2: "+idPeople);
    bool checkData=await Repository.deletePeopleInCampaignInjection(idCampaign, idPeople);
    if(checkData){

      Get.snackbar(
          "Xóa thành công",
          "Bạn đã xóa thành công",
        titleText: Text("Xóa thành công",style: TextStyle(color: Colors.white),textAlign: TextAlign.center,),
        messageText: Text(
          "Bạn đã xóa thành công",
            style: TextStyle(color: Colors.white),textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.green,
        snackPosition: SnackPosition.TOP,
        maxWidth: 200,
        padding: EdgeInsets.symmetric(horizontal: 25,vertical: 10),
        margin: EdgeInsets.only(top:10),
      );
    }
    else{
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
        maxWidth: 200,
        padding: EdgeInsets.symmetric(horizontal: 25,vertical: 10),
        margin: EdgeInsets.only(top:10),
      );
    }
  }

  Future<void> deleteCampaignInjection(String idCampaign)async{
    bool checkData=await Repository.deleteCampaignInjection(idCampaign);
    if(checkData){
      Get.snackbar(
        "Xóa thành công",
        "Bạn đã xóa thành công đợt tiêm",
        titleText: Text("Xóa thành công",style: TextStyle(color: Colors.white),textAlign: TextAlign.center,),
        messageText: Text(
          "Bạn đã xóa thành công đợt tiêm",
          style: TextStyle(color: Colors.white),textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.green,
        snackPosition: SnackPosition.TOP,
        maxWidth: 200,
        padding: EdgeInsets.symmetric(horizontal: 25,vertical: 10),
        margin: EdgeInsets.only(top:10),
      );
    }
    else{
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
        maxWidth: 200,
        padding: EdgeInsets.symmetric(horizontal: 25,vertical: 10),
        margin: EdgeInsets.only(top:10),
      );
    }
  }

  Future<void> promoteOneCampaignInjection(String id)async{
    bool checkData=await Repository.promoteOneCampaignInjection(id);
    if(checkData){
      isLoadingUpdate.value=false;
      Get.snackbar(
        "Thêm vào đợt chính thức",
        "Bạn đã thêm vào đợt chính thức thành công",
        titleText: Text("Thêm vào đợt chính thức",style: TextStyle(color: Colors.white),textAlign: TextAlign.center,),
        messageText: Text(
          "Bạn đã thêm vào đợt chính thức thành công",
          style: TextStyle(color: Colors.white),textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.green,
        snackPosition: SnackPosition.TOP,
        maxWidth: 200,
        padding: EdgeInsets.symmetric(horizontal: 25,vertical: 10),
        margin: EdgeInsets.only(top:10),
      );

    }
    else{
      isLoadingUpdate.value=false;
      Get.snackbar(
        "Thêm vào đợt chính thức thất bại",
        "Vui lòng thử lại sau",
        titleText: Text("Thêm vào đợt chính thức thất bại",style: TextStyle(color: Colors.white),textAlign: TextAlign.center,),
        messageText: Text(
          "Vui lòng thử lại sau",
          style: TextStyle(color: Colors.white),textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.TOP,
        maxWidth: 200,
        padding: EdgeInsets.symmetric(horizontal: 25,vertical: 10),
        margin: EdgeInsets.only(top:10),
      );
    }
  }

  @override
  Future<void> onInit() async{
    // TODO: implement onInit
    super.onInit();
    await getDataConfirmed();
    await getListBtnData();
  }

}