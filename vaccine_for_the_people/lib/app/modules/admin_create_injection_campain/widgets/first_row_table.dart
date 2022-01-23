import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vaccine_for_the_people/app/modules/admin_create_injection_campain/controller/create_injection_campaign_controller.dart';

class FirstRowTable extends StatefulWidget {
  const FirstRowTable({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  State<FirstRowTable> createState() => _FirstRowTableState();
}

class _FirstRowTableState extends State<FirstRowTable> {
  final c=Get.find<CreateInjectionCampaignController>();
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
            width: 30,
            height: 50,
            decoration: const BoxDecoration(
              borderRadius:
              BorderRadius.only(topLeft: Radius.circular(10)),
            ),
            child: const Center(
              child: Text("STT",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold),),
            ),
          ),
          const SizedBox(
            width: 200,
            height: 50,
            child: Center(
              child: Text("Tên",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
          const SizedBox(
            width: 30,
            height: 50,
            child: Center(
              child: Text("Tuổi",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
          const SizedBox(
            width: 150,
            height: 50,
            child: Center(
              child: Text("Loại đối tượng",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
          const SizedBox(
            width: 50,
            height: 50,
            child: Center(
              child: Text("Giới tính",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
          const SizedBox(
            width: 200,
            height: 50,
            child: Center(
              child: Text("Mũi tiêm trước đó",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
          const SizedBox(
            width: 150,
            height: 50,
            child: Center(
              child: Text("Thời gian mũi tiêm đến",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
          const SizedBox(
            width: 100,
            height: 50,
            child: Center(
              child: Text("Bệnh nền",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
          const SizedBox(
            width: 350,
            height: 50,
            child: Center(
              child: Text("Địa chỉ",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
          !c.isHaveBtnConfirm.value ? Container(
            width: 30,
            height: 50,
            decoration: const BoxDecoration(
              borderRadius:
              BorderRadius.only(topRight: Radius.circular(10)),
            ),
            child: const Center(
              child: Text("Xóa",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ):SizedBox.shrink()
        ],
      ),
    );
  }
}