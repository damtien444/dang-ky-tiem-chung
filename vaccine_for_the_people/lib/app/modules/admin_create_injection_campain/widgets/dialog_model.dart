import 'dart:convert';

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
                                c.promoteOneCampaignInjection(c.listCampaignNotConfirm[c.selectedIndexNotConfirm.value].sId.toString());
                                c.listCampaignAlreadyConfirm.add(c.listCampaignNotConfirm[c.selectedIndexNotConfirm.value]);
                                c.listBtnConfirm.add(ModelDropdownBtn(
                                    name: c.listCampaignNotConfirm[c.selectedIndexNotConfirm.value].name.toString(),
                                    id: c.listCampaignNotConfirm[c.selectedIndexNotConfirm.value].sId.toString(),
                                    dateStartCampaign: c.listCampaignNotConfirm[c.selectedIndexNotConfirm.value].dateStart.toString(),
                                    dateEndCampaign: c.listCampaignNotConfirm[c.selectedIndexNotConfirm.value].dateEnd.toString(),
                                    placeCampaign: c.listCampaignNotConfirm[c.selectedIndexNotConfirm.value].datePlace.toString()
                                  ),
                                );
                                c.listCampaignNotConfirm.removeAt(c.selectedIndexNotConfirm.value);
                                c.listBtnNotConfirm.removeAt(c.selectedIndexNotConfirm.value);
                                c.listCampaignAlreadyConfirm.refresh();
                                c.listCampaignNotConfirm.refresh();
                                c.listBtnConfirm.refresh();
                                c.listBtnNotConfirm.refresh();
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
                                c.deleteCampaignInjection(c.listCampaignAlreadyConfirm[c.selectedIndexConfirm.value].sId.toString());
                                c.listCampaignAlreadyConfirm.remove(c.listCampaignAlreadyConfirm[c.selectedIndexConfirm.value]);
                                c.listBtnConfirm.remove(c.listBtnConfirm[c.selectedIndexConfirm.value]);
                                c.listBtnConfirm.refresh();
                                c.listCampaignAlreadyConfirm.refresh();
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
                                c.deleteCampaignInjection(c.listCampaignNotConfirm[c.selectedIndexNotConfirm.value].sId.toString());
                                c.listCampaignNotConfirm.remove(c.listCampaignNotConfirm[c.selectedIndexNotConfirm.value]);
                                c.listBtnNotConfirm.remove(c.listBtnNotConfirm[c.selectedIndexNotConfirm.value]);
                                c.listBtnNotConfirm.refresh();
                                c.listCampaignNotConfirm.refresh();
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
    String nameCampaign=c.listBtnNotConfirm[c.selectedIndexNotConfirm.value].name.toString();
    String place = c.listBtnNotConfirm[c.selectedIndexNotConfirm.value].placeCampaign.toString();
    String startDay =  DateFormat('yyyy-MM-dd').format(DateTime.parse(c.listBtnNotConfirm[c.selectedIndexNotConfirm.value].dateStartCampaign.toString()));
    String endDay =  DateFormat('yyyy-MM-dd').format(DateTime.parse(c.listBtnNotConfirm[c.selectedIndexNotConfirm.value].dateEndCampaign.toString()));

    c.nameCp.value=c.utf8convert(nameCampaign);
    c.startCp.value=c.utf8convert(startDay);
    c.endCp.value=c.utf8convert(endDay);
    c.placeCp.value=c.utf8convert(place);

    return showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Container(
              width: 500,
              height: 610,
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
                            value: c.utf8convert(nameCampaign),
                            onPress: (value1) {
                              c.nameCp.value = value1;
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
                            value: c.utf8convert(place),
                            onPress: (value2) {
                              c.placeCp.value = value2;
                            },
                            mode: FormBuilderMode.DEFAULT1
                        ),
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
                            value: c.utf8convert(startDay),
                            onPress: (value3) {
                              c.startCp.value = value3;
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
                            value: c.utf8convert(endDay),
                            onPress: (value4) {
                              c.endCp.value = value4;
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
                                print("sau");
                                print("tên: "+c.nameCp.value);
                                print("địa chỉ: "+c.placeCp.value);
                                print("ngày start: "+c.startCp.value);
                                print("ngày end: "+c.endCp.value);

                                c.listBtnNotConfirm[c.selectedIndexNotConfirm.value].name=c.nameCp.value;
                                c.listBtnNotConfirm[c.selectedIndexNotConfirm.value].placeCampaign=c.placeCp.value;
                                c.listBtnNotConfirm[c.selectedIndexNotConfirm.value].dateStartCampaign=c.startCp.value;
                                c.listBtnNotConfirm[c.selectedIndexNotConfirm.value].dateEndCampaign=c.endCp.value;

                                c.listCampaignNotConfirm[c.selectedIndexNotConfirm.value].name=c.nameCp.value;
                                c.listCampaignNotConfirm[c.selectedIndexNotConfirm.value].datePlace=c.placeCp.value;
                                c.listCampaignNotConfirm[c.selectedIndexNotConfirm.value].dateStart=c.startCp.value;
                                c.listCampaignNotConfirm[c.selectedIndexNotConfirm.value].dateEnd=c.endCp.value;

                                c.listBtnNotConfirm.refresh();
                                c.listCampaignNotConfirm.refresh();
                                c.updateCampaignInjection(
                                    c.listCampaignNotConfirm[c.selectedIndexNotConfirm.value].sId.toString(),
                                    c.utf8convert(c.nameCp.toString()),
                                    c.startCp.toString(),
                                    c.endCp.toString(),
                                    c.utf8convert(c.placeCp.toString())
                                );
                                c.textDisplay.value=
                                "* Tên đợt tiêm: ${c.nameCp.toString()}"
                                    ", Ngày bắt đầu: ${c.startCp.toString()}"
                                    ", Ngày kết thúc: ${c.endCp.toString()}"
                                    ", Tại địa điểm: ${c.placeCp.toString()}";
                                c.textDisplay.refresh();
                                Get.back();
                              }),
                        ),
                        const SizedBox(
                          width: 20,
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
                  ],
                ),
              ),
            ),
          );
        });
  }
