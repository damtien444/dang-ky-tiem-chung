import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:get/get.dart';
import 'package:vaccine_for_the_people/app/core/theme/colors.dart';
import 'package:vaccine_for_the_people/app/core/theme/text_theme.dart';
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
              padding: const EdgeInsets.all(20),
              child: FormBuilder(
                key: controller.searchFormKey,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: FormBuilderOptions(
                            nameForm: 'age',
                            title: 'Tuổi',
                            allowClear: true,
                            require: false,
                            listOptions: controller.listAges,
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
                            nameForm: 'type_injection',
                            title: 'Loại mũi tiêm',
                            allowClear: true,
                            require: false,
                            listOptions: controller.typeVaccine,
                            mode: FormBuilderMode.DROP_DOWN),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: FormBuilderOptions(
                            nameForm: 'province',
                            title: 'Tỉnh/Thành phố',
                            require: false,
                            allowClear: true,
                            isDropDown:true,
                            listOptions: Get.find<RegisterInjectionController>()
                                .listProvinces
                                .value,
                            mode: FormBuilderMode.DROP_DOWN),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: FormBuilderOptions(
                            nameForm: 'anamesis',
                            title: 'Tiền sử bệnh',
                            require: false,
                            allowClear: true,
                            listOptions: controller.anamesis,
                            mode: FormBuilderMode.DROP_DOWN),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: FormBuilderOptions(
                          nameForm: 'type_object',
                          title: 'Nhóm ưu tiên',
                          require: false,
                          allowClear: true,
                          listOptions: controller.typeObject,
                          mode: FormBuilderMode.DROP_DOWN),
                    ),
                  ],
                ),
              ),
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
