import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vaccine_for_the_people/app/core/values/custome_colors.dart';
import 'package:vaccine_for_the_people/app/data/services/repository.dart';

class SearchInjectionController extends GetxController{
  Repository repository;
  SearchInjectionController({required this.repository});

  RxBool isLoading=false.obs;
  GlobalKey<FormBuilderState> searchInjectionFormKey = GlobalKey<FormBuilderState>();
  bool sexData=false;
  bool illData=false;
  String utf8convert(String? text) {
    List<int> bytes = text.toString().codeUnits;
    return utf8.decode(bytes);
  }
  Future<void> searchDataSearchInjection(String email)async{
    final data=await Repository.getDataSearchInjection(email);
    data.fold((left){
      isLoading.value=false;
      sexData=left.person!.sex!;
      illData=left.person!.illnessHistory!;
      showDialog(
          context: Get.overlayContext!,
          builder: (context) {
            return Dialog(
              child: SizedBox(
                width: 500,
                height: 670,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 20,
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
                        child: const Text(
                          "Tra cứu tiêm chủng",
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              fontFamily: "impact"),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Họ tên: ${utf8convert(left.person!.name.toString())}",
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: "impact"),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      sexData ?
                      Text(
                        "Giới tính: Nam",
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: "impact"),
                      ) :
                      Text(
                        "Giới tính: Nữ",
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: "impact"),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Email: ${utf8convert(left.person!.email.toString())}",
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: "impact"),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      illData ?

                      const  Text(
                        "Tiền sử bệnh: Có",
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: "impact"),
                      ): Text(
                        "Tiền sử bệnh: Không",
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: "impact"),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Số điện thoại: ${utf8convert(left.person!.phone.toString())}",
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: "impact"),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Địa chỉ: ${utf8convert(left.person!.address!.ward.toString())}/"
                            "${utf8convert(left.person!.address!.district.toString())}/"
                            "${utf8convert(left.person!.address!.province.toString())}",
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: "impact"),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        "CCCD: ${utf8convert(left.person!.cCCD.toString())}",
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: "impact"),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Ngày sinh: ${DateFormat('yyyy/MM/dd').format(DateTime.parse(utf8convert(left.person!.birthDay.toString())))}",
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: "impact"),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Ngày mong muốn được tiêm: ${DateFormat('yyyy/MM/dd').format(DateTime.parse((utf8convert(left.person!.nextExpectedShotDate.toString()))))}",
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: "impact"),
                      ),
                      left.person!.vaccineShots!.isNotEmpty ? left.person!.vaccineShots!.length==2 ? Column(
                        children: [
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            "Loại Vaccine được tiêm: ${utf8convert(left.person!.vaccineShots![1].typeName.toString())}",
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: "impact"),
                          ),
                        ],
                      ): Column(
                        children: [
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            "Loại Vaccine được tiêm: ${utf8convert(left.person!.vaccineShots![0].typeName.toString())}",
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: "impact"),
                          ),
                        ],
                      ): Column(
                        children: [
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            "Loại Vaccine được tiêm: Chưa xác định",
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: "impact"),
                          ),
                        ],
                      ),
                      SizedBox(height: 15,),
                      left.person!.vaccineShots!.isNotEmpty ?const Padding(
                        padding: EdgeInsets.only(bottom: 15),
                        child: Text(
                          "Lịch sử mũi tiêm thứ nhất: ",
                          style: TextStyle(
                              fontSize: 14,
                              fontFamily: "impact"),
                        ),
                      ):SizedBox.shrink(),
                      left.person!.vaccineShots!.isNotEmpty ?
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Loại Vaccine: ${utf8convert(left.person!.vaccineShots![0].typeName.toString())}",
                              style: TextStyle(
                                  fontSize: 13,
                                  fontFamily: "impact"),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Text(
                              "Ngày tiêm: ${DateFormat('yyyy/MM/dd').format(DateTime.parse(utf8convert(left.person!.vaccineShots![0].shotDate.toString())))}",
                              style: TextStyle(
                                  fontSize: 13,
                                  fontFamily: "impact"),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Text(
                              "Địa điểm tiêm: ${utf8convert(left.person!.vaccineShots![0].shotPlace.toString())}",
                              style: TextStyle(
                                  fontSize: 13,
                                  fontFamily: "impact"),
                            ),
                          ],
                        ),
                      ):SizedBox.shrink(),
                      SizedBox(height: left.person!.vaccineShots!.isNotEmpty ? 40 :150,),
                      Center(
                        child: SizedBox(
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
                            child: const Text("Trở về",
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
                      ),
                    ],
                  ),
                ),
              ),
            );
          });
    }, (right){
      isLoading.value=false;
      showDialog(
          context: Get.overlayContext!,
          builder: (context) {
            return Dialog(
              insetPadding: EdgeInsets.symmetric(vertical: 180),
              child: SizedBox(
                width: 250,
                height: 300,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,

                    children: [
                      const SizedBox(
                        height: 20,
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
                        child: const Text(
                          "Tra cứu tiêm chủng",
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              fontFamily: "impact"),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Center(
                        child: const Text(
                          "Tên email chưa đúng, vui lòng nhập lại",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                              fontFamily: "impact"),
                        ),
                      ),
                      const SizedBox(
                        height: 50,
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
                          child: const Text("Trở về",
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
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            );
          });
    });
  }
}