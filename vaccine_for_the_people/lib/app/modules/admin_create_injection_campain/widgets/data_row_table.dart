
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vaccine_for_the_people/app/core/values/custome_colors.dart';
import 'package:vaccine_for_the_people/app/data/models/model_detail_one_campaign_injection.dart';
import 'package:vaccine_for_the_people/app/modules/admin_create_injection_campain/controller/create_injection_campaign_controller.dart';

class DataRowTable extends StatefulWidget {
  DataRowTable({
    Key? key,
    required this.size, required this.index, required this.dataPeople
  }) : super(key: key);

  final Size size;
  final int index;
  final ListOfPeopleDetail dataPeople;

  @override
  State<DataRowTable> createState() => _DataRowTableState();
}

class _DataRowTableState extends State<DataRowTable> {
  final c=Get.find<CreateInjectionCampaignController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: (widget.index+1)%2!=0? Colors.grey.withOpacity(0.08):Colors.white
      ),
      child: Row(
        children: [
          Container(
            width: 30,
            height: 40,
            decoration: const BoxDecoration(
              borderRadius:
              BorderRadius.only(topLeft: Radius.circular(10)),
            ),
            child: Center(
              child: Text((widget.index+1).toString(),textAlign: TextAlign.center),
            ),
          ),
          SizedBox(
            width: 200,
            height: 40,
            child:  Center(
              child: Text(widget.dataPeople.name.toString(),textAlign: TextAlign.center),
            ),
          ),
          const SizedBox(
            width: 30,
            height: 40,
            child: Center(
              child: Text("20",textAlign: TextAlign.center),
            ),
          ),
          SizedBox(
            width: 150,
            height: 40,
            child: Center(
              child: Text(widget.dataPeople.priorityGroup.toString(),textAlign: TextAlign.center),
            ),
          ),
          SizedBox(
            width: 50,
            height: 40,
            child: Center(
              child: widget.dataPeople.sex! ? Text("Nam",textAlign: TextAlign.center):Text("Nữ",textAlign: TextAlign.center),
            ),
          ),
          SizedBox(
            width: 200,
            height: 40,
            child: Center(
              child: Text(c.utf8convert(widget.dataPeople.nextExpectedShotType.toString()),textAlign: TextAlign.center),
            ),
          ),
          SizedBox(
            width: 150,
            height: 40,
            child: Center(
              child: Text(DateFormat('yyyy/MM/dd').format(DateTime.parse(widget.dataPeople.nextExpectedShotDate.toString())).toString(),textAlign: TextAlign.center),
            ),
          ),
           SizedBox(
            width: 100,
            height: 40,
            child: Center(
              child: widget.dataPeople.illnessHistory! ? Text("Có",textAlign: TextAlign.center):Text("Không",textAlign: TextAlign.center),
            ),
          ),
          SizedBox(
            width: 350,
            height: 40,
            child: Center(
              child: Text(c.utf8convert(widget.dataPeople.address!.ward.toString()+" - "+widget.dataPeople.address!.district.toString()+" - "+widget.dataPeople.address!.province.toString()),textAlign: TextAlign.center,style: TextStyle(fontSize: 12)),
            ),
          ),
          !c.isHaveBtnConfirm.value ? Container(
            width: 30,
            height: 40,
            decoration: const BoxDecoration(
              borderRadius:
              BorderRadius.only(topRight: Radius.circular(10)),
            ),
            child: Center(
              child: IconButton(
                icon: const Icon(Icons.delete,color: Colors.red,size: 16,),
                onPressed: (){
                  showDialog(
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
                                  Text(
                                    "Xác nhận xóa",
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "impact"),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Text(
                                    "Bạn chắc chắn muốn xóa ${widget.dataPeople.name} ra khoi danh sách ??",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
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
                                            child: Text("Xác nhận",
                                                style: TextStyle(
                                                    color:
                                                    Colors.white,
                                                    fontSize: 15,
                                                    fontWeight:
                                                    FontWeight
                                                        .normal,
                                                    fontFamily:
                                                    "impact")),
                                            onPressed: () async {
                                              print(c.idCampaignClick.value+" "+widget.dataPeople.sId.toString());
                                              c.deletePeopleCampaignInjection(c.idCampaignClick.value.toString(), widget.dataPeople.sId.toString());
                                              Get.back();
                                              Future.delayed(Duration(seconds: 2),(){
                                                c.getDataOneCampaignInjection(c.idCampaignClick.value);
                                              });
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
                                          child: Text("Hủy bỏ",
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
                },
              ),
            ),
          ):SizedBox.shrink()
        ],
      ),
    );
  }
}