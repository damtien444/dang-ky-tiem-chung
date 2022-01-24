import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vaccine_for_the_people/app/core/components/loading_view.dart';
import 'package:vaccine_for_the_people/app/core/values/custome_colors.dart';
import 'package:vaccine_for_the_people/app/data/providers/provider_service.dart';
import 'package:vaccine_for_the_people/app/data/services/repository.dart';
import 'package:vaccine_for_the_people/app/modules/admin_create_injection_campain/controller/create_injection_campaign_controller.dart';
import 'package:vaccine_for_the_people/app/modules/admin_create_injection_campain/widgets/data_row_table.dart';
import 'package:vaccine_for_the_people/app/modules/admin_create_injection_campain/widgets/dialog_model.dart';
import 'package:vaccine_for_the_people/app/modules/admin_create_injection_campain/widgets/first_row_table.dart';
import 'package:vaccine_for_the_people/app/modules/admin_create_injection_campain/widgets/header_injection_campaign.dart';
import 'package:vaccine_for_the_people/app/modules/home/widgets/bottom_screen.dart';

class CreateInjectionCampaignView extends GetView<CreateInjectionCampaignController> {
  const CreateInjectionCampaignView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final c = Get.put(CreateInjectionCampaignController(
        repository: Repository(providerService: ProviderService())));
    return GetX<CreateInjectionCampaignController>(
      initState: (state) {
        c.getDataConfirmed();
      },
      builder: (_) {
        return  ListView(
                scrollDirection: Axis.vertical,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Column(
                          children: [
                            HeaderInjectionCampaign(),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 40),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    mainAxisAlignment:MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            color: Colors.grey.withOpacity(0.1),
                                            borderRadius: BorderRadius.circular(10)
                                        ),
                                        child: Column(
                                          children: [
                                            GestureDetector(
                                              onTap: (){
                                                c.isClickListConfirm.value=!c.isClickListConfirm.value;
                                              },
                                              child: Container(
                                                width: 170,
                                                height: 45,
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(10),
                                                    color: CustomeColor.colorAppBar
                                                ),
                                                child: const Center(
                                                  child: Text("Đợt tiêm đã xác nhận",style: TextStyle(color: Colors.white),),
                                                ),
                                              ),
                                            ),
                                            c.isClickListConfirm.value ?
                                            SizedBox(
                                              width: 170,
                                              height: 405,
                                              child: c.listBtnConfirm.isNotEmpty ? ListView.builder(
                                                itemCount:c.listBtnConfirm.length,
                                                itemBuilder: (context, index){
                                                  return Padding(
                                                    padding: const EdgeInsets.only(top: 2),
                                                    child: GestureDetector(
                                                      onTap: (){
                                                        c.selectedIndexNotConfirm.value=1000;
                                                        c.isHaveBtnConfirm.value=true;
                                                        c.selectedIndexConfirm.value=index;
                                                        c.textDisplay.value=
                                                        "* Tên đợt tiêm: ${c.utf8convert(c.listBtnConfirm[index].name)}"
                                                            ", Ngày bắt đầu: ${DateFormat('yyyy/MM/dd').format(DateTime.parse(c.utf8convert(c.listBtnConfirm[index].dateStartCampaign)))}"
                                                            ", Ngày kết thúc: ${DateFormat('yyyy/MM/dd').format(DateTime.parse(c.utf8convert(c.listBtnConfirm[index].dateEndCampaign)))}"
                                                            ", Tại địa điểm: ${c.utf8convert(c.listBtnConfirm[index].placeCampaign)}";
                                                        controller.getDataOneCampaignInjection(c.listBtnConfirm[index].id.toString());
                                                        c.idCampaignClick.value=c.listBtnConfirm[index].id.toString();
                                                      },
                                                      child: Container(
                                                        width: 150,
                                                        height: 45,
                                                        decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(10),
                                                            color: controller.selectedIndexConfirm.value==index ? Colors.green:Colors.green.withOpacity(0.4)
                                                        ),
                                                        child: Center(
                                                          child: Text(c.utf8convert(c.listBtnConfirm[index].name),style: const TextStyle(color: Colors.white),),
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ):const SizedBox.shrink(),
                                            ):const SizedBox.shrink(),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 5,),
                                      Container(
                                        decoration: BoxDecoration(
                                            color: Colors.grey.withOpacity(0.1),
                                            borderRadius: BorderRadius.circular(10)
                                        ),
                                        child:Column(
                                          children: [
                                            GestureDetector(
                                              onTap: (){
                                                c.isClickListNotConfirm.value=!c.isClickListNotConfirm.value;
                                              },
                                              child: Container(
                                                width: 170,
                                                height: 45,
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(10),
                                                    color: CustomeColor.colorAppBar
                                                ),
                                                child: const Center(
                                                  child: Text("Đợt tiêm chưa xác nhận",style: TextStyle(color: Colors.white),),
                                                ),
                                              ),
                                            ),
                                            c.isClickListNotConfirm.value ?
                                            SizedBox(
                                              width: 170,
                                              height: 405,
                                              child: c.listBtnNotConfirm.isNotEmpty ? ListView.builder(
                                                itemCount:c.listBtnNotConfirm.length,
                                                itemBuilder: (context, index){
                                                  return Padding(
                                                    padding: const EdgeInsets.only(top: 2),
                                                    child: GestureDetector(
                                                      onTap: (){
                                                        c.selectedIndexNotConfirm.value=index;
                                                        c.selectedIndexConfirm.value=1000;
                                                        c.isHaveBtnConfirm.value=false;
                                                        c.textDisplay.value=
                                                        "* Tên đợt tiêm: ${c.utf8convert(c.listBtnNotConfirm[index].name)}"
                                                            ", Ngày bắt đầu: ${DateFormat('yyyy/MM/dd').format(DateTime.parse(c.utf8convert(c.listBtnNotConfirm[index].dateStartCampaign)))}"
                                                            ", Ngày kết thúc: ${DateFormat('yyyy/MM/dd').format(DateTime.parse(c.utf8convert(c.listBtnNotConfirm[index].dateEndCampaign)))}"
                                                            ", Tại địa điểm: ${c.utf8convert(c.listBtnNotConfirm[index].placeCampaign)}";
                                                        controller.getDataOneCampaignInjection(c.listBtnNotConfirm[index].id.toString());
                                                        c.idCampaignClick.value=c.listBtnNotConfirm[index].id.toString();
                                                      },
                                                      child: Container(
                                                        width: 150,
                                                        height: 45,
                                                        decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(10),
                                                            color: controller.selectedIndexNotConfirm.value==index ? Colors.green:Colors.green.withOpacity(0.4)
                                                        ),
                                                        child: Center(
                                                          child: Text(c.utf8convert(c.listBtnNotConfirm[index].name),style: const TextStyle(color: Colors.white),),
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ):const SizedBox.shrink(),
                                            ):const SizedBox.shrink(),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(width: 20,),
                                  Expanded(
                                    child: Container(
                                      height: controller.listPeopleInCampaign.isNotEmpty ? 500: 210,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: Colors.white,
                                          boxShadow: const [
                                            BoxShadow(
                                                color: Colors.grey,
                                                offset: Offset(0, 0),
                                                blurRadius: 1,
                                                spreadRadius: 1)
                                          ]),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 20),
                                        child: Column(
                                          children: [
                                            FirstRowTable(size: size),
                                            controller.listPeopleInCampaign.isNotEmpty ? Expanded(
                                              child:!controller.isLoadingWidget.value ?
                                              ListView.builder(
                                                  physics: const ClampingScrollPhysics(),
                                                  scrollDirection: Axis.vertical,
                                                  itemCount: controller.listPeopleInCampaign.length,
                                                  itemBuilder: (context, index) {
                                                    return DataRowTable(
                                                      size: size,
                                                      index: index, dataPeople: controller.listPeopleInCampaign[index],
                                                    );
                                                  }):SizedBox(
                                                  width: 50,
                                                  height: 50,
                                                  child: LoadingWidget()
                                              ),
                                            ):Center(
                                              child:!controller.isLoadingWidget.value ?
                                              const Padding(
                                                padding: EdgeInsets.only(top: 70,bottom: 30),
                                                child: Text("Chưa có dữ liêu"),
                                              ) :
                                              Padding(
                                                padding: const EdgeInsets.symmetric(vertical: 20),
                                                child: LoadingWidget(),
                                              ),
                                            ),
                                            const SizedBox(height: 10,),

                                            ((controller.selectedIndexConfirm.value!=1000 && controller.selectedIndexNotConfirm.value==1000 ) ||
                                                (controller.selectedIndexNotConfirm.value!=1000 && controller.selectedIndexConfirm.value==1000 ))
                                                ?
                                            Padding(
                                              padding: EdgeInsets.only(left: controller.isHaveBtnConfirm.value ? 390: 460),
                                              child: Row(
                                                children: [
                                                  SizedBox(
                                                    width: 100,
                                                    height: 35,
                                                    child: !controller.isHaveBtnConfirm.value ? ElevatedButton(
                                                        style: ElevatedButton.styleFrom(
                                                          primary: CustomeColor.colorAppBar,
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.circular(10)),
                                                        ),
                                                        child: const Text("Xác nhận",
                                                            style: TextStyle(color: Colors.white,fontSize: 12, fontWeight: FontWeight.normal, fontFamily: "impact")),
                                                        onPressed: (){
                                                          DialogConfirm(context, c);
                                                        }):const SizedBox.shrink(),
                                                  ),
                                                  !controller.isHaveBtnConfirm.value ? const SizedBox(
                                                    width: 30,
                                                  ):const SizedBox.shrink(),
                                                  SizedBox(
                                                    width: 100,
                                                    height: 35,
                                                    child: !controller.isHaveBtnConfirm.value ? ElevatedButton(
                                                        style: ElevatedButton.styleFrom(
                                                          primary: Colors.green,
                                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                                        ),
                                                        child: const Text("Chỉnh Sửa",
                                                            style: TextStyle(color: Colors.white, fontSize: 12, fontFamily: "impact", fontWeight: FontWeight.normal)),
                                                        onPressed: () async {
                                                          updateDialogConfirm0(
                                                              context, c);
                                                        }
                                                    ):const SizedBox.shrink(),
                                                  ),
                                                  !controller.isHaveBtnConfirm.value ? const SizedBox(
                                                    width: 30,
                                                  ):const SizedBox.shrink(),
                                                  SizedBox(
                                                    width: 100,
                                                    height: 35,
                                                    child: ElevatedButton(
                                                      style: ElevatedButton.styleFrom(
                                                        primary: Colors.red,
                                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                                      ),
                                                      child: const Text("Xóa Đợt",
                                                          style: TextStyle(color: Colors.white, fontSize: 12, fontFamily: "impact", fontWeight: FontWeight.normal)),
                                                      onPressed: () {
                                                        print(c.selectedIndexConfirm.value.toString());
                                                        c.isClickListConfirm.value ?
                                                        DialogConfirmDeleteCampaign0(context,c,c.selectedIndexConfirm.value):
                                                        DialogConfirmDeleteCampaign1(context,c,c.selectedIndexNotConfirm.value);
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ):const SizedBox.shrink(),
                                            const SizedBox(
                                              height: 15,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 105,),
                      const BottomSceen()
                    ],
                  )
                ],
              );
      },
    );
  }
}
