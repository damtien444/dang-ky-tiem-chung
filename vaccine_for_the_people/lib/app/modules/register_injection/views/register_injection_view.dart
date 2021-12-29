import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:get/get.dart';
import 'package:vaccine_for_the_people/app/core/theme/colors.dart';
import 'package:vaccine_for_the_people/app/core/theme/text_theme.dart';
import 'package:vaccine_for_the_people/app/modules/register_injection/components/form_builder_options.dart';

import '../controllers/register_injection_controller.dart';

class RegisterInjectionView extends GetView<RegisterInjectionController> {
  RegisterInjectionView({Key? key}) : super(key: key);
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scrollbar(
        controller: _scrollController, // <---- Here, the controller
        isAlwaysShown: true,
        child: ListView(
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
                    'Đăng kí tiêm cá nhân',
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
                        const TextSpan(text: '  /  Đăng kí tiêm'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  FormBuilder(
                    key: controller.regInjectionFormKey,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: Get.width * 0.15,
                            child: FormBuilderOptions(
                                nameForm: 'order',
                                regFormKey: controller.regInjectionFormKey,
                                title: 'Đăng kí mũi tiêm',
                                listOptions: controller.orderInjection,
                                mode: FormBuilderMode.DROP_DOWN),
                          ),
                          const SizedBox(height: 20),
                          AutoSizeText('1. Thông tin người đăng ký tiêm',
                              style: labelStyle),
                          const SizedBox(height: 20),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Flexible(
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 20),
                                  child: FormBuilderOptions(
                                      nameForm: 'name',
                                      regFormKey:
                                          controller.regInjectionFormKey,
                                      title: 'Họ và tên',
                                      mode: FormBuilderMode.DEFAULT),
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 20),
                                  child: FormBuilderOptions(
                                      nameForm: 'dob',
                                      regFormKey:
                                          controller.regInjectionFormKey,
                                      title: 'Ngày sinh',
                                      mode: FormBuilderMode.DATE_PICKER),
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 20),
                                  child: FormBuilderOptions(
                                      nameForm: 'gender',
                                      regFormKey:
                                          controller.regInjectionFormKey,
                                      title: 'Giới tính',
                                      listOptions: controller.genders,
                                      mode: FormBuilderMode.DROP_DOWN),
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                child: FormBuilderOptions(
                                    nameForm: 'phone_number',
                                    regFormKey: controller.regInjectionFormKey,
                                    title: 'Số điện thoại',
                                    inputMode: InputMode.PHONE,
                                    mode: FormBuilderMode.DEFAULT),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Flexible(
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 20),
                                  child: FormBuilderOptions(
                                      nameForm: 'email',
                                      regFormKey:
                                          controller.regInjectionFormKey,
                                      title: 'Email',
                                      inputMode: InputMode.EMAIL,
                                      mode: FormBuilderMode.DEFAULT),
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 20),
                                  child: FormBuilderOptions(
                                      nameForm: 'cmnd',
                                      regFormKey:
                                          controller.regInjectionFormKey,
                                      title:
                                          'CCCD/Mã định danh công dân/Hộ chiếu',
                                      mode: FormBuilderMode.DEFAULT),
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 20),
                                  child: FormBuilderOptions(
                                      nameForm: 'type_vaccine',
                                      regFormKey:
                                          controller.regInjectionFormKey,
                                      title: 'Loại vaccine',
                                      listOptions: controller.typeVaccine,
                                      mode: FormBuilderMode.DROP_DOWN),
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                child: FormBuilderOptions(
                                    nameForm: 'type_object',
                                    regFormKey: controller.regInjectionFormKey,
                                    title: 'Nhóm ưu tiên',
                                    listOptions: controller.typeObject,
                                    mode: FormBuilderMode.DROP_DOWN),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Flexible(
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 20),
                                  child: FormBuilderOptions(
                                      nameForm: 'province',
                                      regFormKey:
                                          controller.regInjectionFormKey,
                                      title: 'Tỉnh',
                                      listOptions: controller.listProvince,
                                      mode: FormBuilderMode.DROP_DOWN),
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 20),
                                  child: FormBuilderOptions(
                                      nameForm: 'district',
                                      regFormKey:
                                          controller.regInjectionFormKey,
                                      title: 'Quận/Huyện',
                                      listOptions: controller.listDistrict,
                                      mode: FormBuilderMode.DROP_DOWN),
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 20),
                                  child: FormBuilderOptions(
                                      nameForm: 'ward',
                                      regFormKey:
                                          controller.regInjectionFormKey,
                                      title: 'Phường/Xã',
                                      mode: FormBuilderMode.DROP_DOWN),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Flexible(
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 20),
                                  child: FormBuilderOptions(
                                      nameForm: 'address',
                                      regFormKey:
                                          controller.regInjectionFormKey,
                                      title: 'Địa chỉ hiện tại',
                                      require: false,
                                      mode: FormBuilderMode.DEFAULT),
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 20),
                                  child: FormBuilderOptions(
                                      nameForm: 'age',
                                      regFormKey:
                                          controller.regInjectionFormKey,
                                      title: 'Tuổi',
                                      listOptions: controller.listAges,
                                      mode: FormBuilderMode.DROP_DOWN),
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                child: FormBuilderOptions(
                                    nameForm: 'anamesis',
                                    regFormKey: controller.regInjectionFormKey,
                                    title: 'Tiền sử bệnh',
                                    listOptions: controller.anamesis,
                                    mode: FormBuilderMode.DROP_DOWN),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          AutoSizeText('2. Thông tin đăng ký tiêm chủng',
                              style: labelStyle),
                          const SizedBox(height: 20),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Flexible(
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 20),
                                  child: FormBuilderOptions(
                                      nameForm: 'injection_day',
                                      regFormKey:
                                          controller.regInjectionFormKey,
                                      title: 'Ngày muốn được tiêm(dự kiến)',
                                      mode: FormBuilderMode.DATE_PICKER),
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 20),
                                  child: FormBuilderOptions(
                                      nameForm: 'name',
                                      regFormKey:
                                          controller.regInjectionFormKey,
                                      title: 'Buổi muốn được tiêm',
                                      listOptions: controller.listSession,
                                      mode: FormBuilderMode.DROP_DOWN),
                                ),
                              ),
                              const Spacer(flex: 2),
                            ],
                          ),
                          const SizedBox(height: 40),
                          ElevatedButton(
                            onPressed: () {
                              controller.regInjectionFormKey.currentState!
                                  .saveAndValidate();
                            },
                            child: const AutoSizeText('Gửi phản hồi'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
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
