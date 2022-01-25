import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vaccine_for_the_people/app/modules/admin_create_injection_campain/controller/create_injection_campaign_controller.dart';
import 'package:vaccine_for_the_people/app/modules/admin_feedback/controller/admin_feedback_controller.dart';

class FirstRowTableFeedBack extends StatefulWidget {
  const FirstRowTableFeedBack({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  State<FirstRowTableFeedBack> createState() => _FirstRowTableState();
}

class _FirstRowTableState extends State<FirstRowTableFeedBack> {
  final c=Get.find<AdminFeedBackController>();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  width: 3,
                  color: Colors.grey.withOpacity(0.5)
              )
          )
      ),
      child: Row(
        children: [
          Container(
            width: 200,
            height: 50,
            decoration: const BoxDecoration(
              borderRadius:
              BorderRadius.only(topLeft: Radius.circular(10)),
            ),
            child: const Center(
              child: Text("Tên",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold),),
            ),
          ),
          const SizedBox(
            width: 200,
            height: 50,
            child: Center(
              child: Text("Email",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
          const SizedBox(
            width: 150,
            height: 50,
            child: Center(
              child: Text("Ngày Tháng",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
          const SizedBox(
            width: 350,
            height: 50,
            child: Center(
              child: Text("Nội dung phản hồi",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
          const SizedBox(
            width: 300,
            height: 50,
            child: Center(
              child: Text("Trả lời",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
          c.isClickBtnNotSolve.value ?
          Container(
            width: 70,
            height: 50,
            decoration: const BoxDecoration(
              borderRadius:
              BorderRadius.only(topRight: Radius.circular(10)),
            ),
            child: const Center(
              child: Text("Phản hồi",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ):SizedBox.shrink()
        ],
      ),
    );
  }
}