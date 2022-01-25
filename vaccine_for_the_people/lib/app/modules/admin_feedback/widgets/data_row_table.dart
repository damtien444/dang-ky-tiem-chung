
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vaccine_for_the_people/app/core/values/custome_colors.dart';
import 'package:vaccine_for_the_people/app/data/models/model_detail_one_campaign_injection.dart';
import 'package:vaccine_for_the_people/app/modules/admin_create_injection_campain/controller/create_injection_campaign_controller.dart';
import 'package:vaccine_for_the_people/app/modules/admin_feedback/controller/admin_feedback_controller.dart';

class DataRowTableFeedBack extends StatefulWidget {
  DataRowTableFeedBack({
    Key? key,
    required this.size, required this.index
  }) : super(key: key);

  final Size size;
  final int index;

  @override
  State<DataRowTableFeedBack> createState() => _DataRowTableState();
}

class _DataRowTableState extends State<DataRowTableFeedBack> {
  final c=Get.find<AdminFeedBackController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: (widget.index+1)%2!=0? Colors.grey.withOpacity(0.08):Colors.white
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
          ):const SizedBox.shrink()
        ],
      ),
    );
  }
}