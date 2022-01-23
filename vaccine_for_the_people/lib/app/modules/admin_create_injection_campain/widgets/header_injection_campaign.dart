import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vaccine_for_the_people/app/core/theme/colors.dart';
import 'package:vaccine_for_the_people/app/core/theme/text_theme.dart';
import 'package:vaccine_for_the_people/app/core/values/custome_colors.dart';
import 'package:vaccine_for_the_people/app/modules/admin_create_injection_campain/controller/create_injection_campaign_controller.dart';

class HeaderInjectionCampaign extends StatefulWidget {
  HeaderInjectionCampaign({
    Key? key,
  }) : super(key: key);

  @override
  State<HeaderInjectionCampaign> createState() => _HeaderInjectionCampaignState();
}

class _HeaderInjectionCampaignState extends State<HeaderInjectionCampaign> {

  @override
  Widget build(BuildContext context) {
    final c=Get.find<CreateInjectionCampaignController>();
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
                'Xác nhận tạo đợt tiêm chủng',
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
                    const TextSpan(text: '  /  Xác nhận tạo đợt tiêm chủng'),
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
              Padding(
                padding: const EdgeInsets.only(left: 190),
                child: Container(
                  child: c.textDisplay.value.isNotEmpty ? Text(
                    c.textDisplay.toString(),
                    style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize: 14),
                  ):Text(" Trống "),
                ),
              ),
              Container(
                child: Row(
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
                ),
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
