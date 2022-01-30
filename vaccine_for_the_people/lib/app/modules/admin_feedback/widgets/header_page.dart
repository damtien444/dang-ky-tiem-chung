import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vaccine_for_the_people/app/core/theme/colors.dart';
import 'package:vaccine_for_the_people/app/core/theme/text_theme.dart';
import 'package:vaccine_for_the_people/app/core/values/custome_colors.dart';
import 'package:vaccine_for_the_people/app/modules/admin_create_injection_campain/widgets/dialog_model.dart';
import 'package:vaccine_for_the_people/app/modules/admin_feedback/controller/admin_feedback_controller.dart';

class HeaderPage extends StatefulWidget {
  HeaderPage({
    Key? key,
  }) : super(key: key);

  @override
  State<HeaderPage> createState() => _HeaderInjectionCampaignState();
}

class _HeaderInjectionCampaignState extends State<HeaderPage> {

  @override
  Widget build(BuildContext context) {
    final c=Get.find<AdminFeedBackController>();
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 20),
          color: kHeaderPage,
          child: Row(
            children: [
              AutoSizeText(
                'Thống kê phản hồi',
                style: Get.textTheme.headline5,
              ),
              const Spacer(
                flex: 1,
              ),
              AutoSizeText.rich(
                TextSpan(
                  style: Get.textTheme.bodyText2,
                  children: [
                    TextSpan(
                      text: 'Trang chủ',
                      style: noteStyle,
                      recognizer: TapGestureRecognizer()..onTap = () {},
                    ),
                    const TextSpan(text: '  /  Thống kê phản hồi'),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 170,
                    height: 45,
                    child: ElevatedButton(
                      style: ElevatedButton
                          .styleFrom(
                        primary: CustomeColor.colorAppBar,
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
                      child: const Text("Làm mới dữ liệu",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontFamily:
                              "impact",
                              fontWeight:
                              FontWeight
                                  .normal)),
                      onPressed: () async {
                        dialogLoading(context);
                        c.listFeedbackNotSolve.clear();
                        c.listFeedbackSolve.clear();
                        await c.getDataFeedBack();
                        Future.delayed(const Duration(seconds: 2),(){
                          Get.back();
                          Get.snackbar(
                            "Cập nhật dữ liệu thành công",
                            "Bạn đã cập nhật dữ liệu thành công",
                            titleText: Text("Cập nhật dữ liệu thành công",style: TextStyle(color: Colors.white),textAlign: TextAlign.center,),
                            messageText: Text(
                              "Bạn đã cập nhật dữ liệu thành công",
                              style: TextStyle(color: Colors.white),textAlign: TextAlign.center,
                            ),
                            backgroundColor: Colors.green,
                            snackPosition: SnackPosition.TOP,
                            maxWidth: 300,
                            padding: EdgeInsets.symmetric(horizontal: 25,vertical: 10),
                            margin: EdgeInsets.only(top:10),
                          );

                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 10,),
                  GestureDetector(
                    onTap: (){
                      c.isClickBtnSolve.value=true;
                      c.isClickBtnNotSolve.value=false;
                      c.isClickBtn.value=true;
                      // c.isLoadingWidget.value=true;
                    },
                    child: Container(
                      width: 170,
                      height: 45,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: c.isClickBtnSolve.value ? Colors.green :CustomeColor.colorAppBar
                      ),
                      child: const Center(
                        child: Text("Phản hồi đã xử lí",style: TextStyle(color: Colors.white),),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10,),
                  GestureDetector(
                    onTap: (){
                      c.isClickBtnNotSolve.value=true;
                      c.isClickBtnSolve.value=false;
                      c.isClickBtn.value=true;
                      // c.isLoadingWidget.value=true;
                    },
                    child: Container(
                      width: 170,
                      height: 45,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: c.isClickBtnNotSolve.value ? Colors.green :CustomeColor.colorAppBar
                      ),
                      child: const Center(
                        child: Text("Phản hồi chưa xử lí",style: TextStyle(color: Colors.white),),
                      ),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    width: 200,
                    height: 35,
                    child: TextFormField(
                      decoration: InputDecoration(
                          contentPadding:
                          const EdgeInsets.symmetric(vertical: 10.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)),
                          prefixIcon: const Icon(
                            CupertinoIcons.search,
                            size: 18,
                          )),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      width: 80,
                      height: 30,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: CustomeColor.colorAppBar),
                      child: const Center(
                        child: Text(
                          "Tìm kiếm",
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ],
    );
  }

  final labelStyle = Get.textTheme.headline6!.copyWith(
    fontWeight: kFontWeightBold,
  );

  final noteStyle = Get.textTheme.bodyText2!.copyWith(
    color: kError,
  );
}
