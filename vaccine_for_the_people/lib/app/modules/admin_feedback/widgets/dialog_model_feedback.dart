import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:vaccine_for_the_people/app/core/values/custome_colors.dart';
import 'package:vaccine_for_the_people/app/data/models/feed_back_model.dart';
import 'package:vaccine_for_the_people/app/modules/admin_feedback/controller/admin_feedback_controller.dart';
import 'package:vaccine_for_the_people/app/modules/register_injection/widgets/form_builder_options.dart';

Future<dynamic> confirmReplyFeedback(BuildContext context, AdminFeedBackController c, int index) {
  String name=c.utf8convert(c.listFeedbackNotSolve[index].name.toString());
  String email=c.utf8convert(c.listFeedbackNotSolve[index].email.toString());
  String content=c.utf8convert(c.listFeedbackNotSolve[index].content.toString());
  return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: SizedBox(
            width: 500,
            height: 650,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
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
                  const Center(
                      child: Text("Trả lời phản hồi",style: TextStyle(fontSize: 20),)
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  const Text("Họ tên",style: TextStyle(fontSize: 15),),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: 400,
                    child: TextFormField(
                      initialValue: name,
                      enabled: false,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: const Text("Email",style: TextStyle(fontSize: 15),),
                  ),
                  SizedBox(
                    width: 400,
                    child: TextFormField(
                      initialValue:email,
                      enabled: false,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: const Text("Phản hồi từ khách hàng",style: TextStyle(fontSize: 15),),
                  ),
                  SizedBox(
                    width: 400,
                    child: TextFormField(
                      initialValue: content,
                      maxLines: 5,
                      enabled: false,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: const Text("* Trả lời phản hồi",style: TextStyle(fontSize: 15),),
                  ),
                  SizedBox(
                    width: 400,
                    child: TextFormField(
                      maxLines: 5,
                      onChanged: (text){
                        c.feedback.value=text;
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
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
                            style: ElevatedButton.styleFrom(
                             primary: CustomeColor.colorAppBar,
                              shape:
                              RoundedRectangleBorder(
                                //to set border radius to button
                                  borderRadius:
                                  BorderRadius
                                      .circular(
                                      10)),
                            ),
                            child: const Text("Phản hồi",
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
                              print("gia tri: "+c.feedback.toString());
                              c.replyFeedback(c.listFeedbackNotSolve[index].sId.toString(), c.feedback.value, index);
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
Future<dynamic> DialogConfirmDeleteFeedback(BuildContext context, AdminFeedBackController c, String id,String name,int index) {
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
                    "Bạn chắc chắn muốn xóa phản hồi từ ${c.utf8convert(name)} không ??",
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
                              c.deleteFeedback(id,index);
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
