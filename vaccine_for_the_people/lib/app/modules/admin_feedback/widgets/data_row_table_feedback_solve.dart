
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vaccine_for_the_people/app/core/values/custome_colors.dart';
import 'package:vaccine_for_the_people/app/data/models/feed_back_model.dart';
import 'package:vaccine_for_the_people/app/data/models/model_detail_one_campaign_injection.dart';
import 'package:vaccine_for_the_people/app/modules/admin_create_injection_campain/controller/create_injection_campaign_controller.dart';
import 'package:vaccine_for_the_people/app/modules/admin_feedback/controller/admin_feedback_controller.dart';
import 'package:vaccine_for_the_people/app/modules/admin_feedback/widgets/dialog_model_feedback.dart';

class DataRowTableFeedBackSolve extends StatefulWidget {
  DataRowTableFeedBackSolve({
    Key? key,
    required this.size, required this.index, required this.data
  }) : super(key: key);

  final Size size;
  final int index;
  final Solved data;

  @override
  State<DataRowTableFeedBackSolve> createState() => _DataRowTableState();
}

class _DataRowTableState extends State<DataRowTableFeedBackSolve> {
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
            width: 50,
            height: 50,
            decoration: const BoxDecoration(
              borderRadius:
              BorderRadius.only(topLeft: Radius.circular(10)),
            ),
            child: Center(
              child: Text((widget.index+1).toString(),textAlign: TextAlign.center,),
            ),
          ),
          SizedBox(
            width: 200,
            height: 50,
            child: Center(
              child: Text(c.utf8convert(widget.data.name.toString()),textAlign: TextAlign.start),
            ),
          ),
           SizedBox(
            width: 200,
            height: 50,
            child: Center(
              child: Text(c.utf8convert(widget.data.email.toString()),textAlign: TextAlign.center),
            ),
          ),
           SizedBox(
            width: 150,
            height: 50,
            child: Center(
              child: Text(DateFormat('yyyy/MM/dd').format(DateTime.parse(c.utf8convert(widget.data.dateCreatedVn.toString()))),textAlign: TextAlign.center),
            ),
          ),
          SizedBox(
            width: 320,
            height: 50,
            child: Center(
              child: Text(c.utf8convert(widget.data.content.toString()),textAlign: TextAlign.center),
            ),
          ),
          SizedBox(
            width: 320,
            height: 50,
            child: Center(
              child: Text(c.utf8convert(widget.data.response.toString()),textAlign: TextAlign.center),
            ),
          ),
          Container(
            width: 50,
            height: 50,
            decoration: const BoxDecoration(
              borderRadius:
              BorderRadius.only(topRight: Radius.circular(10)),
            ),
            child: Center(
              child: IconButton(
                onPressed: (){
                  DialogConfirmDeleteFeedback(context,c,c.listFeedbackSolve[widget.index].sId.toString(),c.listFeedbackSolve[widget.index].name.toString(),widget.index);
                },
                icon: Icon(Icons.delete,color: Colors.red,),
              ),
            ),
          ),
        ],
      ),
    );
  }
}