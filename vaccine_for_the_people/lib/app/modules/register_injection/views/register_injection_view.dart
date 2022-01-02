import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:get/get.dart';
import 'package:vaccine_for_the_people/app/core/theme/colors.dart';
import 'package:vaccine_for_the_people/app/core/theme/text_theme.dart';
import 'package:vaccine_for_the_people/app/modules/home/widgets/bottom_screen.dart';
import 'package:vaccine_for_the_people/app/modules/register_injection/components/form_builder_options.dart';

import '../controllers/register_injection_controller.dart';

class RegisterInjectionView extends GetView<RegisterInjectionController> {
  RegisterInjectionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return ListView(
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
                              const Flexible(
                                flex: 1,
                                child: Padding(
                                  padding: EdgeInsets.only(right: 20),
                                  child: FormBuilderOptions(
                                      nameForm: 'name',
                                      title: 'Họ và tên',
                                      mode: FormBuilderMode.DEFAULT),
                                ),
                              ),
                              const Flexible(
                                flex: 1,
                                child: Padding(
                                  padding: EdgeInsets.only(right: 20),
                                  child: FormBuilderOptions(
                                      nameForm: 'dob',
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
                                      title: 'Giới tính',
                                      listOptions: controller.genders,
                                      mode: FormBuilderMode.DROP_DOWN),
                                ),
                              ),
                              const Flexible(
                                flex: 1,
                                child: FormBuilderOptions(
                                    nameForm: 'phone_number',
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
                              const Flexible(
                                flex: 1,
                                child: Padding(
                                  padding: EdgeInsets.only(right: 20),
                                  child: FormBuilderOptions(
                                      nameForm: 'email',
                                      title: 'Email',
                                      inputMode: InputMode.EMAIL,
                                      mode: FormBuilderMode.DEFAULT),
                                ),
                              ),
                              const Flexible(
                                flex: 1,
                                child: Padding(
                                  padding: EdgeInsets.only(right: 20),
                                  child: FormBuilderOptions(
                                      nameForm: 'cmnd',
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
                                      title: 'Loại vaccine',
                                      listOptions: controller.typeVaccine,
                                      mode: FormBuilderMode.DROP_DOWN),
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                child: FormBuilderOptions(
                                    nameForm: 'type_object',
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
                                      title: 'Tỉnh/Thành phố',
                                      onPress: controller.onSelectionAddress,
                                      isDropDown: true,
                                      initial: controller.listProvinces.first,
                                      listOptions:
                                          controller.listProvinces.value,
                                      mode: FormBuilderMode.DROP_DOWN),
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 20),
                                  child: FormBuilderOptions(
                                      nameForm: 'district',
                                      title: 'Quận/Huyện',
                                      initial: controller.listDistricts.first,
                                      onPress: controller.onSelectionAddress,
                                      isDropDown:
                                          controller.isDropDownDistrict.value,
                                      listOptions:
                                          controller.listDistricts,
                                      mode: FormBuilderMode.DROP_DOWN),
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                child: FormBuilderOptions(
                                    nameForm: 'ward',
                                    title: 'Phường/Xã',
                                    isDropDown: controller.isDropDownWard.value,
                                    listOptions: controller.listWards.value,
                                    mode: FormBuilderMode.DROP_DOWN),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Flexible(
                                flex: 1,
                                child: Padding(
                                  padding: EdgeInsets.only(right: 20),
                                  child: FormBuilderOptions(
                                      nameForm: 'address',
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
                                      title: 'Tuổi',
                                      listOptions: controller.listAges,
                                      mode: FormBuilderMode.DROP_DOWN),
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                child: FormBuilderOptions(
                                    nameForm: 'anamesis',
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
                              const Flexible(
                                flex: 1,
                                child: Padding(
                                  padding: EdgeInsets.only(right: 20),
                                  child: FormBuilderOptions(
                                      nameForm: 'injection_day',
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
                                      title: 'Buổi muốn được tiêm',
                                      listOptions: controller.listSession,
                                      mode: FormBuilderMode.DROP_DOWN),
                                ),
                              ),
                              const Spacer(flex: 2),
                            ],
                          ),
                          const SizedBox(height: 50),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  controller.regInjectionFormKey.currentState!
                                      .reset();
                                  controller.isDropDownDistrict.value = false;
                                  controller.isDropDownWard.value = false;
                                },
                                style: ButtonStyle(
                                  padding: MaterialStateProperty.all<
                                          EdgeInsetsGeometry>(
                                      const EdgeInsets.symmetric(
                                          horizontal: 50)),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          kOnPrimaryColor),
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                          kWarning),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    const RoundedRectangleBorder(
                                      side: BorderSide(color: kWarning),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(12),
                                        topRight: Radius.circular(12),
                                        bottomRight: Radius.circular(12),
                                      ),
                                    ),
                                  ),
                                ),
                                child: const AutoSizeText('Hủy bỏ'),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  controller.regInjectionFormKey.currentState!
                                      .saveAndValidate();
                                },
                                style: ButtonStyle(
                                  padding: MaterialStateProperty.all<
                                          EdgeInsetsGeometry>(
                                      const EdgeInsets.symmetric(
                                          horizontal: 30)),
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.white),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(12),
                                        topRight: Radius.circular(12),
                                        bottomRight: Radius.circular(12),
                                      ),
                                    ),
                                  ),
                                ),
                                child: const AutoSizeText('Đăng kí tiêm'),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const BottomSceen(),
          ],
        );
      }),
    );
  }

  final labelStyle = Get.textTheme.headline6!.copyWith(
    fontWeight: kFontWeightBold,
  );
  final noteStyle = Get.textTheme.bodyText2!.copyWith(
    color: kError,
  );
}
