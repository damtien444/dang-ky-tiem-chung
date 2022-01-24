import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vaccine_for_the_people/app/core/components/loading_view.dart';
import 'package:vaccine_for_the_people/app/core/values/custome_colors.dart';
import 'package:vaccine_for_the_people/app/data/models/model_dropdown_button.dart';
import 'package:vaccine_for_the_people/app/modules/admin_create_injection_campain/controller/create_injection_campaign_controller.dart';
import 'package:vaccine_for_the_people/app/modules/register_injection/widgets/form_builder_options.dart';

  Future<dynamic> DialogConfirm(BuildContext context, CreateInjectionCampaignController c) {
    return showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Container(
              width: 400,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Image.asset(
                        "assets/images/icon_heart.png",
                        fit: BoxFit.contain,
                        height: 70,
                        width: 70,
                        color: CustomeColor.colorAppBar,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Text(
                      "Thêm vào đợt chính thức",
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          fontFamily: "impact"),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Bạn chắc chắn muốn xác nhận đợt tiêm: ${c.utf8convert(c.listCampaignNotConfirm[c.selectedIndexNotConfirm.value].name.toString())}  vào đợt tiêm chính thức không ??",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                          fontFamily: "impact"),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 120,
                          height: 35,
                          child: ElevatedButton(
                              style: ElevatedButton
                                  .styleFrom(
                                primary: CustomeColor
                                    .colorAppBar,
                                //background color of button
                                // side: const BorderSide(width:1, color:Colors.grey), //border width and color//elevation of button
                                shape:
                                RoundedRectangleBorder(
                                  //to set border radius to button
                                    borderRadius:
                                    BorderRadius
                                        .circular(
                                        10)),
                              ),
                              child: const Text("Thêm vào",
                                  style: TextStyle(
                                      color:
                                      Colors.white,
                                      fontSize: 15,
                                      fontWeight:
                                      FontWeight
                                          .normal,
                                      fontFamily:
                                      "impact")),
                              onPressed: () async{
                                c.listCampaignNotConfirm.removeAt(c.selectedIndexNotConfirm.value);
                                c.listCampaignAlreadyConfirm.add(c.listCampaignNotConfirm[c.selectedIndexNotConfirm.value]);
                                c.listBtnConfirm.add(ModelDropdownBtn(
                                    name: c.listCampaignNotConfirm[c.selectedIndexNotConfirm.value].name.toString(),
                                    id: c.listCampaignNotConfirm[c.selectedIndexNotConfirm.value].sId.toString(),
                                    dateStartCampaign: c.listCampaignNotConfirm[c.selectedIndexNotConfirm.value].dateStart.toString(),
                                    dateEndCampaign: c.listCampaignNotConfirm[c.selectedIndexNotConfirm.value].dateEnd.toString(),
                                    placeCampaign: c.listCampaignNotConfirm[c.selectedIndexNotConfirm.value].datePlace.toString()
                                  ),
                                );
                                c.listCampaignAlreadyConfirm.refresh();
                                c.listCampaignNotConfirm.refresh();
                                c.promoteOneCampaignInjection(c.listCampaignNotConfirm1[c.selectedIndexNotConfirm.value].sId.toString());
                                c.selectedIndexNotConfirm.value=1000;
                                c.listCampaignAlreadyConfirm.refresh();
                                c.listCampaignNotConfirm.refresh();
                                Get.back();
                              }),
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        SizedBox(
                          width: 120,
                          height: 35,
                          child: ElevatedButton(
                            style: ElevatedButton
                                .styleFrom(
                              primary: Colors.red,
                              //background color of button
                              // side: const BorderSide(width:1, color:Colors.grey), //border width and color//elevation of button
                              shape:
                              RoundedRectangleBorder(
                                //to set border radius to button
                                  borderRadius:
                                  BorderRadius
                                      .circular(
                                      10)),
                            ),
                            child: const Text("Hủy bỏ",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontFamily:
                                    "impact",
                                    fontWeight:
                                    FontWeight
                                        .normal)),
                            onPressed: () async {
                              Get.back();
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
  Future<dynamic> DialogConfirmDeleteCampaign0(BuildContext context, CreateInjectionCampaignController c, int index) {
    return showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: SizedBox(
              width: 400,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Image.asset(
                        "assets/images/icon_heart.png",
                        fit: BoxFit.contain,
                        height: 70,
                        width: 70,
                        color: CustomeColor.colorAppBar,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Text(
                      "Xóa đợt tiêm",
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          fontFamily: "impact"),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Bạn chắc chắn muốn xóa đợt tiêm: ${c.utf8convert(c.listCampaignAlreadyConfirm[index].name.toString())} không ??",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                          fontFamily: "impact"),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 120,
                          height: 35,
                          child: ElevatedButton(
                              style: ElevatedButton
                                  .styleFrom(
                                primary: CustomeColor
                                    .colorAppBar,
                                //background color of button
                                // side: const BorderSide(width:1, color:Colors.grey), //border width and color//elevation of button
                                shape:
                                RoundedRectangleBorder(
                                  //to set border radius to button
                                    borderRadius:
                                    BorderRadius
                                        .circular(
                                        10)),
                              ),
                              child: const Text("Xác nhận",
                                  style: TextStyle(
                                      color:
                                      Colors.white,
                                      fontSize: 15,
                                      fontWeight:
                                      FontWeight
                                          .normal,
                                      fontFamily:
                                      "impact")),
                              onPressed: () async{
                                c.listCampaignAlreadyConfirm.remove(c.listCampaignAlreadyConfirm[c.selectedIndexConfirm.value]);
                                c.listBtnConfirm.remove(c.listBtnConfirm[c.selectedIndexConfirm.value]);
                                c.listBtnConfirm.refresh();
                                c.deleteCampaignInjection(c.listCampaignAlreadyConfirm1[c.selectedIndexConfirm.value].sId.toString());
                                c.getListBtnData();
                                c.selectedIndexConfirm.value=1000;
                                Get.back();
                              }),
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        SizedBox(
                          width: 120,
                          height: 35,
                          child: ElevatedButton(
                            style: ElevatedButton
                                .styleFrom(
                              primary: Colors.red,
                              //background color of button
                              // side: const BorderSide(width:1, color:Colors.grey), //border width and color//elevation of button
                              shape:
                              RoundedRectangleBorder(
                                //to set border radius to button
                                  borderRadius:
                                  BorderRadius
                                      .circular(
                                      10)),
                            ),
                            child: const Text("Hủy bỏ",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontFamily:
                                    "impact",
                                    fontWeight:
                                    FontWeight
                                        .normal)),
                            onPressed: () async {
                              Get.back();
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
  Future<dynamic> DialogConfirmDeleteCampaign1(BuildContext context, CreateInjectionCampaignController c, int index) {
    return showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: SizedBox(
              width: 400,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Image.asset(
                        "assets/images/icon_heart.png",
                        fit: BoxFit.contain,
                        height: 70,
                        width: 70,
                        color: CustomeColor.colorAppBar,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Text(
                      "Xóa đợt tiêm",
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          fontFamily: "impact"),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Bạn chắc chắn muốn xóa đợt tiêm: ${c.utf8convert(c.listCampaignNotConfirm[index].name.toString())} không ??",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                          fontFamily: "impact"),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 120,
                          height: 35,
                          child: ElevatedButton(
                              style: ElevatedButton
                                  .styleFrom(
                                primary: CustomeColor
                                    .colorAppBar,
                                //background color of button
                                // side: const BorderSide(width:1, color:Colors.grey), //border width and color//elevation of button
                                shape:
                                RoundedRectangleBorder(
                                  //to set border radius to button
                                    borderRadius:
                                    BorderRadius
                                        .circular(
                                        10)),
                              ),
                              child: const Text("Xác nhận",
                                  style: TextStyle(
                                      color:
                                      Colors.white,
                                      fontSize: 15,
                                      fontWeight:
                                      FontWeight
                                          .normal,
                                      fontFamily:
                                      "impact")),
                              onPressed: () async{
                                c.listCampaignNotConfirm.remove(c.listCampaignNotConfirm[c.selectedIndexNotConfirm.value]);
                                c.listBtnNotConfirm.remove(c.listBtnNotConfirm[c.selectedIndexNotConfirm.value]);
                                c.listBtnNotConfirm.refresh();
                                c.deleteCampaignInjection(c.listCampaignNotConfirm1[c.selectedIndexNotConfirm.value].sId.toString());
                                c.listCampaignNotConfirm.refresh();
                                // c.getListBtnData();
                                c.selectedIndexNotConfirm.value=1000;
                                Get.back();
                              }),
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        SizedBox(
                          width: 120,
                          height: 35,
                          child: ElevatedButton(
                            style: ElevatedButton
                                .styleFrom(
                              primary: Colors.red,
                              //background color of button
                              // side: const BorderSide(width:1, color:Colors.grey), //border width and color//elevation of button
                              shape:
                              RoundedRectangleBorder(
                                //to set border radius to button
                                  borderRadius:
                                  BorderRadius
                                      .circular(
                                      10)),
                            ),
                            child: const Text("Hủy bỏ",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontFamily:
                                    "impact",
                                    fontWeight:
                                    FontWeight
                                        .normal)),
                            onPressed: () async {
                              Get.back();
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
  Future<dynamic> updateDialogConfirm0(BuildContext context, CreateInjectionCampaignController c) {
    String nameCampaign=c.utf8convert(c.listBtnNotConfirm[c.selectedIndexNotConfirm.value].name.toString());
    String place = c.utf8convert(c.listBtnNotConfirm[c.selectedIndexNotConfirm.value].placeCampaign.toString());
    String startDay =  DateFormat('yyyy-MM-dd').format(DateTime.parse(c.listBtnNotConfirm[c.selectedIndexNotConfirm.value].dateStartCampaign.toString()));
    String endDay =  DateFormat('yyyy-MM-dd').format(DateTime.parse(c.listBtnNotConfirm[c.selectedIndexNotConfirm.value].dateEndCampaign.toString()));
    c.nameCp.value=nameCampaign;
    c.startCp.value=startDay;
    c.endCP.value=endDay;
    c.placeCp.value=place;
    return showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Container(
              width: 500,
              height: 600,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Image.asset(
                        "assets/images/icon_heart.png",
                        fit: BoxFit.contain,
                        height: 70,
                        width: 70,
                        color: CustomeColor.colorAppBar,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Center(
                      child: Text("Chỉnh sửa thông tin chiến dịch",style: TextStyle(fontSize: 20),)
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      width: 400,
                      child: Padding(
                        padding: EdgeInsets.only(right: 20),
                        child: FormBuilderOptions(
                            title: "Tên chiến dịch",
                            value: nameCampaign,
                            onPress: (name) {
                              c.nameCp.value = name;
                            },
                            mode: FormBuilderMode.DEFAULT1),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      width: 400,
                      child: Padding(
                        padding: EdgeInsets.only(right: 20),
                        child: FormBuilderOptions(
                            title: "Địa điểm",
                            value: place,
                            onPress: (name) {
                              c.placeCp.value = name;
                            },
                            mode: FormBuilderMode.DEFAULT1),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      width: 400,
                      child: Padding(
                        padding: EdgeInsets.only(right: 20),
                        child: FormBuilderOptions(
                            title: "Bắt đầu",
                            value: startDay,
                            onPress: (name) {
                              c.startCp.value = name;
                            },
                            mode: FormBuilderMode.DEFAULT1),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      width: 400,
                      child: Padding(
                        padding: EdgeInsets.only(right: 20),
                        child: FormBuilderOptions(
                            title: "Kết thúc",
                            value: endDay,
                            onPress: (name) {
                              c.endCP.value = name;
                            },
                            mode: FormBuilderMode.DEFAULT1),
                      ),
                    ),
                    const SizedBox(height: 30,),
                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 120,
                          height: 35,
                          child: ElevatedButton(
                              style: ElevatedButton
                                  .styleFrom(
                                primary: CustomeColor
                                    .colorAppBar,
                                //background color of button
                                // side: const BorderSide(width:1, color:Colors.grey), //border width and color//elevation of button
                                shape:
                                RoundedRectangleBorder(
                                  //to set border radius to button
                                    borderRadius:
                                    BorderRadius
                                        .circular(
                                        10)),
                              ),
                              child: const Text("Chỉnh Sửa",
                                  style: TextStyle(
                                      color:
                                      Colors.white,
                                      fontSize: 15,
                                      fontWeight:
                                      FontWeight
                                          .normal,
                                      fontFamily:
                                      "impact")),
                              onPressed: (){
                                c.listBtnNotConfirm[c.selectedIndexNotConfirm.value].name=c.utf8convert(c.nameCp.value);
                                c.listBtnNotConfirm[c.selectedIndexNotConfirm.value].placeCampaign=c.utf8convert(c.placeCp.value);
                                c.listBtnNotConfirm[c.selectedIndexNotConfirm.value].dateStartCampaign=c.utf8convert(c.startCp.value);
                                c.listBtnNotConfirm[c.selectedIndexNotConfirm.value].dateEndCampaign=c.utf8convert(c.endCP.value);
                                c.listBtnNotConfirm.refresh();
                                c.updateCampaignInjection(
                                    c.listCampaignNotConfirm[c.selectedIndexNotConfirm.value].sId.toString(),
                                    c.nameCp.toString(),
                                    c.startCp.toString(),
                                    c.endCP.toString(),
                                    c.placeCp.toString()
                                );
                                c.textDisplay.value=
                                "* Tên đợt tiêm: ${c.nameCp.toString()}"
                                    ", Ngày bắt đầu: ${c.startCp.toString()}"
                                    ", Ngày kết thúc: ${c.endCP.toString()}"
                                    ", Tại địa điểm: ${c.placeCp.toString()}";
                                c.textDisplay.refresh();
                                Get.back();
                              }),
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        SizedBox(
                          width: 120,
                          height: 35,
                          child: ElevatedButton(
                            style: ElevatedButton
                                .styleFrom(
                              primary: Colors.red,
                              //background color of button
                              // side: const BorderSide(width:1, color:Colors.grey), //border width and color//elevation of button
                              shape:
                              RoundedRectangleBorder(
                                //to set border radius to button
                                  borderRadius:
                                  BorderRadius
                                      .circular(
                                      10)),
                            ),
                            child: const Text("Hủy bỏ",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontFamily:
                                    "impact",
                                    fontWeight:
                                    FontWeight
                                        .normal)),
                            onPressed: () async {
                              Get.back();
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
