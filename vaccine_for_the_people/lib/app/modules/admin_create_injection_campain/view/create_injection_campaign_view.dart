import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vaccine_for_the_people/app/core/values/custome_colors.dart';
import 'package:vaccine_for_the_people/app/modules/admin_create_injection_campain/controller/create_injection_campaign_controller.dart';
import 'package:vaccine_for_the_people/app/modules/admin_create_injection_campain/widgets/data_row_table.dart';
import 'package:vaccine_for_the_people/app/modules/admin_create_injection_campain/widgets/first_row_table.dart';
import 'package:vaccine_for_the_people/app/modules/admin_create_injection_campain/widgets/header_injection_campaign.dart';

class CreateInjectionCampaignView
    extends GetView<CreateInjectionCampaignController> {
  const CreateInjectionCampaignView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            HeaderInjectionCampaign(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Container(
                height: 500,
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
                      Expanded(
                        child: ListView.builder(
                            physics: const ClampingScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            itemCount: 15,
                            itemBuilder: (context, index) {
                              return DataRowTable(size: size, index: index);
                            }),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Center(
                child: InkWell(
                  onTap: () {},
                  child: Container(
                    width: 100,
                    height: 30,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: CustomeColor.colorAppBar),
                    child: const Center(
                      child: Text(
                        "Xác nhận",
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
