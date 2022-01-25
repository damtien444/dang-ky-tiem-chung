import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vaccine_for_the_people/app/core/components/loading_view.dart';
import 'package:vaccine_for_the_people/app/core/values/custome_colors.dart';
import 'package:vaccine_for_the_people/app/data/providers/provider_service.dart';
import 'package:vaccine_for_the_people/app/data/services/repository.dart';
import 'package:vaccine_for_the_people/app/modules/admin_feedback/controller/admin_feedback_controller.dart';
import 'package:vaccine_for_the_people/app/modules/admin_feedback/widgets/data_row_table.dart';
import 'package:vaccine_for_the_people/app/modules/admin_feedback/widgets/first_row_table.dart';
import 'package:vaccine_for_the_people/app/modules/admin_feedback/widgets/header_page.dart';

class AdminFeedBackView extends GetView<AdminFeedBackController> {
  const AdminFeedBackView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    final c = Get.put(AdminFeedBackController(
        repository: Repository(providerService: ProviderService())));
    return GetX<AdminFeedBackController>(
      builder: (_){
        return ListView(
          children: [
            HeaderPage(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment:MainAxisAlignment.start,
                    children: [
                      Column(
                        children: [
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
                                  color: controller.isClickBtnSolve.value ? Colors.green :CustomeColor.colorAppBar
                              ),
                              child: const Center(
                                child: Text("Phản hồi đã xử lí",style: TextStyle(color: Colors.white),),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5,),
                      Column(
                        children: [
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
                                  color: controller.isClickBtnNotSolve.value ? Colors.green :CustomeColor.colorAppBar
                              ),
                              child: const Center(
                                child: Text("Phản hồi chưa xử lí",style: TextStyle(color: Colors.white),),
                              ),
                            ),
                          )

                        ],
                      )
                    ],
                  ),
                  const SizedBox(width: 20,),
                  Expanded(
                    child: Container(
                      height: controller.isClickBtn.value ? 500: 210,
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
                            FirstRowTableFeedBack(size: size),
                            controller.isClickBtn.value ? Expanded(
                              child:!controller.isLoadingWidget.value ?
                              ListView.builder(
                                  physics: const ClampingScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  itemCount: controller.isClickBtnSolve.value ?
                                              controller.listFeedbackSolve.length :
                                              controller.isClickBtnNotSolve.value ?
                                              controller.listFeedbackNotSolve.length :1 ,
                                  itemBuilder: (context, index) {
                                    return DataRowTableFeedBack(
                                      size: size,
                                      index: index,
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
            )
          ],
        );
      },
    );
  }
}
