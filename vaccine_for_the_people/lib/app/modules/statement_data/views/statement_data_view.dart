import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:vaccine_for_the_people/app/core/theme/colors.dart';
import 'package:vaccine_for_the_people/app/core/theme/text_theme.dart';
import 'package:vaccine_for_the_people/app/core/values/custome_colors.dart';
import 'package:vaccine_for_the_people/app/modules/home/widgets/bottom_screen.dart';
import 'package:vaccine_for_the_people/app/modules/register_injection/components/form_builder_options.dart';
import 'package:vaccine_for_the_people/app/modules/register_injection/controllers/register_injection_controller.dart';

import '../controllers/statement_data_controller.dart';

class StatementDataView extends GetView<StatementDataController> {
  StatementDataView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
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
                    'Tạo đợt tiêm chủng',
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
                        const TextSpan(text: '  /  Tạo đợt tiêm chủng'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 40, horizontal: 100),
              child: Obx(() {
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
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
                        Material(
                          color:Colors.white,
                          child: InkWell(
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
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Flexible(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: FormBuilderOptions(
                                title: 'Tuổi',
                                require: false,
                                listOptions:
                                    Get.find<RegisterInjectionController>()
                                        .listAges,
                                mode: FormBuilderMode.DROP_DOWN),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Flexible(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: FormBuilderOptions(
                                title: 'Tỉnh/Thành phố',
                                value: Get.find<RegisterInjectionController>()
                                    .initialTinh
                                    .value,
                                onPress: (data) =>
                                    Get.find<RegisterInjectionController>()
                                        .findListDistricts(data),
                                listOptions:
                                    Get.find<RegisterInjectionController>()
                                        .listProvinces
                                        .value,
                                mode: FormBuilderMode.DROP_DOWN),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Flexible(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: FormBuilderOptions(
                                title: 'Quận/Huyện',
                                value: Get.find<RegisterInjectionController>()
                                    .initialHuyen
                                    .value,
                                listOptions:
                                    Get.find<RegisterInjectionController>()
                                        .listDistricts
                                        .value,
                                onPress: (data) =>
                                    Get.find<RegisterInjectionController>()
                                        .findListWards(data),
                                mode: FormBuilderMode.DROP_DOWN),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Flexible(
                          flex: 1,
                          child: FormBuilderOptions(
                              title: 'Phường/Xã',
                              listOptions:
                                  Get.find<RegisterInjectionController>()
                                      .listWards
                                      .value,
                              value: Get.find<RegisterInjectionController>()
                                  .initialXa
                                  .value,
                              onPress: (data) => {
                                    Get.find<RegisterInjectionController>()
                                        .initialXa
                                        .value = data
                                  },
                              mode: FormBuilderMode.DROP_DOWN),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Flexible(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: FormBuilderOptions(
                                title: 'Loại mũi tiêm',
                                require: false,
                                listOptions:
                                    Get.find<RegisterInjectionController>()
                                        .typeVaccine,
                                mode: FormBuilderMode.DROP_DOWN),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Flexible(
                          flex: 1,
                          child: FormBuilderOptions(
                              title: 'Tiền sử bệnh',
                              listOptions:
                                  Get.find<RegisterInjectionController>()
                                      .anamesis,
                              mode: FormBuilderMode.DROP_DOWN),
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        Flexible(
                          flex: 1,
                          child: FormBuilderOptions(
                              title: 'Loại đối tượng',
                              listOptions:
                                  Get.find<RegisterInjectionController>()
                                      .typeObject,
                              mode: FormBuilderMode.DROP_DOWN),
                        ),
                      ],
                    ),
                  ],
                );
              }),
            ),
            const SizedBox(
              height: 100,
            ),
            const BottomSceen(),
          ],
        ),
      ),
    );
  }

  final labelStyle = Get.textTheme.headline6!.copyWith(
    fontWeight: kFontWeightBold,
  );
  final noteStyle = Get.textTheme.bodyText2!.copyWith(
    color: kError,
  );
}
