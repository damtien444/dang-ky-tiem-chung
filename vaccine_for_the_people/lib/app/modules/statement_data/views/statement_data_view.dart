import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import 'package:get/get.dart';
import 'package:vaccine_for_the_people/app/core/components/loading_view.dart';
import 'package:vaccine_for_the_people/app/core/theme/colors.dart';
import 'package:vaccine_for_the_people/app/core/theme/text_theme.dart';
import 'package:vaccine_for_the_people/app/modules/home/widgets/bottom_screen.dart';
import 'package:vaccine_for_the_people/app/modules/register_injection/widgets/form_builder_options.dart';
import 'package:vaccine_for_the_people/app/modules/statement_data/widgets/data_injection.dart';
import 'package:vaccine_for_the_people/app/modules/statement_data/widgets/lable_injection.dart';

import '../controllers/statement_data_controller.dart';

class StatementDataView extends GetView<StatementDataController> {
  StatementDataView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = Get.size;
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
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Obx(() {
                return Column(
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    Row(
                      children: [
                        Flexible(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: FormBuilderOptions(
                                title: 'Tỉnh/Thành phố',
                                require: false,
                                value: controller.initialTinh.value,
                                onPress: (data) async {
                                  controller.findListDistricts(data);
                                  controller.province.value = data;
                                  controller.setDataFilter();
                                  await controller.getListInjectionRegistrants(
                                      controller.dataFilter);
                                },
                                listOptions: controller.listProvinces.value,
                                mode: FormBuilderMode.DROP_DOWN),
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: FormBuilderOptions(
                                title: 'Quận/Huyện',
                                require: false,
                                value: controller.initialHuyen.value,
                                listOptions: controller.listDistricts.value,
                                onPress: (data) async {
                                  controller.findListWards(data);
                                  controller.district.value = data;
                                  controller.setDataFilter();
                                  await controller.getListInjectionRegistrants(
                                      controller.dataFilter);
                                },
                                mode: FormBuilderMode.DROP_DOWN),
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: FormBuilderOptions(
                              title: 'Phường/Xã',
                              require: false,
                              listOptions: controller.listWards.value,
                              value: controller.initialXa.value,
                              onPress: (data) async {
                                controller.initialXa.value = data;
                                controller.ward.value = data;
                                controller.setDataFilter();
                                await controller.getListInjectionRegistrants(
                                    controller.dataFilter);
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
                                listOptions: controller.typeVaccine,
                                onPress: (data) async {
                                  controller.vaccineType.value = data;
                                  controller.setDataFilter();
                                  await controller.getListInjectionRegistrants(
                                      controller.dataFilter);
                                },
                                mode: FormBuilderMode.DROP_DOWN),
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: FormBuilderOptions(
                                title: 'Tiền sử bệnh',
                                require: false,
                                listOptions: controller.anamesis,
                                onPress: (data) async {
                                  controller.illnessHistory =
                                      data == "Có" ? 1 : 0;
                                  controller.setDataFilter();
                                  await controller.getListInjectionRegistrants(
                                      controller.dataFilter);
                                },
                                mode: FormBuilderMode.DROP_DOWN),
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: FormBuilderOptions(
                              title: 'Loại đối tượng',
                              require: false,
                              listOptions: controller.typeObject,
                              onPress: (data) {
                                controller.priorityType =
                                    controller.typeObject.indexOf(data) + 1;
                                controller.setDataFilter();
                                controller.getListInjectionRegistrants(
                                    controller.dataFilter);
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
                                title: 'Ngày bắt đầu tiêm',
                                require: false,
                                onPress: (data) async {
                                  controller.startDate.value = data;
                                  controller.setDataFilter();
                                  await controller.getListInjectionRegistrants(
                                      controller.dataFilter);
                                },
                                mode: FormBuilderMode.DATE_PICKER),
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: FormBuilderOptions(
                                title: 'Ngày kết thúc tiêm',
                                require: false,
                                onPress: (data) async {
                                  controller.endDate.value = data;
                                  controller.setDataFilter();
                                  await controller.getListInjectionRegistrants(
                                      controller.dataFilter);
                                },
                                mode: FormBuilderMode.DATE_PICKER),
                          ),
                        ),
                        const Spacer(
                          flex: 1,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    !controller.ready.value
                        ? Center(child: LoadingWidget())
                        : Row(
                            children: [
                              Flexible(
                                child: Container(
                                  margin: const EdgeInsets.only(top: 20),
                                  height: controller.listInjectors.isEmpty
                                      ? 200
                                      : 94 +
                                          40 *
                                              (controller.listInjectors.length -
                                                      1)
                                                  .toDouble(),
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
                                  child: Column(
                                    children: [
                                      LabelInjection(size: size),
                                      controller.listInjectors.isNotEmpty
                                          ? Expanded(
                                              child: ListView.builder(
                                                  physics:
                                                      const NeverScrollableScrollPhysics(),
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  itemCount: controller
                                                      .listInjectors.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return DataInjection(
                                                      size: size,
                                                      index: index,
                                                      typeObject:
                                                          controller.typeObject,
                                                      element: controller
                                                          .listInjectors[index],
                                                    );
                                                  }),
                                            )
                                          : Container(
                                              padding: const EdgeInsets.only(
                                                  top: 65),
                                              alignment: Alignment.center,
                                              child: const Text(
                                                "Không tìm thấy kết quả ",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(

                                                    color: Colors.red,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                    controller.listInjectors.isNotEmpty
                        ?
                    Padding(
                            padding: const EdgeInsets.all(30),
                            child: ElevatedButton(
                              onPressed: () {
                                _showInputDialog(context);
                              },
                              child: const AutoSizeText('Tạo đợt tiêm chủng'),
                            ),
                          )
                        : const SizedBox(),
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

  void _showInputDialog(BuildContext context) {
    Get.defaultDialog(
        title: '',
        content: Container(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          width: 350,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.max,
            children: [
              TextFormField(
                onChanged: (newValue) {
                  controller.nameInjection.value = newValue;
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
                style: Get.textTheme.headline6,
                validator: FormBuilderValidators.compose(
                  [
                    FormBuilderValidators.required(
                      context,
                      errorText: 'Tên đợt tiêm chủng không được bỏ trống',
                    ),
                  ],
                ),
                decoration: const InputDecoration(
                  labelText: 'Tên đợt tiêm chủng',
                  hintMaxLines: 1,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                onChanged: (newValue) {
                  controller.place.value = newValue;
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
                style: Get.textTheme.headline6,
                validator: FormBuilderValidators.compose(
                  [
                    FormBuilderValidators.required(
                      context,
                      errorText: 'Địa điểm tiêm không được bỏ trống',
                    ),
                  ],
                ),
                decoration: const InputDecoration(
                  labelText: 'Địa điểm tiêm chủng',
                  hintMaxLines: 1,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  Get.back();
                  controller.createCampaign();
                },
                child: const Text(
                  'Tạo đợt tiêm',
                  style: TextStyle(color: Colors.white, fontSize: 16.0),
                ),
              )
            ],
          ),
        ),
        radius: 10.0);
  }

  final labelStyle = Get.textTheme.headline6!.copyWith(
    fontWeight: kFontWeightBold,
  );
  final noteStyle = Get.textTheme.bodyText2!.copyWith(
    color: kError,
  );
}
