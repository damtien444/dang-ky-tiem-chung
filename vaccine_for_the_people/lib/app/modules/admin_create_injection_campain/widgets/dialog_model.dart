import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
                                print("chi so: "+c.selectedIndexNotConfirm.value.toString());
                                c.listCampaignNotConfirm.remove(c.listCampaignNotConfirm[c.selectedIndexNotConfirm.value]);
                                c.listBtnNotConfirm.remove(c.listBtnNotConfirm[c.selectedIndexNotConfirm.value]);
                                c.listBtnNotConfirm.refresh();
                                c.deleteCampaignInjection(c.listCampaignNotConfirm1[c.selectedIndexNotConfirm.value].sId.toString());
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
    return showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Container(
              width: 800,
              height: 800,
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
                      "Bạn chắc chắn muốn xác nhận đợt tiêm: ${c.utf8convert(c.listCampaignAlreadyConfirm[c.selectedIndexConfirm.value].name.toString())}  vào đợt tiêm chính thức không ??",
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
                              onPressed: (){
                                c.promoteOneCampaignInjection(c.listCampaignNotConfirm[c.selectedIndexNotConfirm.value].sId.toString());
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
  Future<dynamic> updateDialogConfirm1(BuildContext context, CreateInjectionCampaignController c) {
    return showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Container(
              width: 800,
              height: 800,
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
                              onPressed: (){
                                c.promoteOneCampaignInjection(c.listCampaignNotConfirm[c.selectedIndexNotConfirm.value].sId.toString());
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
