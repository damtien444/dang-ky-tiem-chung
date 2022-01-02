import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: Get.width * 0.15,
                        child: FormBuilderOptions(
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
                                  title: 'Họ và tên',
                                  mode: FormBuilderMode.DEFAULT),
                            ),
                          ),
                          const Flexible(
                            flex: 1,
                            child: Padding(
                              padding: EdgeInsets.only(right: 20),
                              child: FormBuilderOptions(
                                  title: 'Ngày sinh',
                                  mode: FormBuilderMode.DATE_PICKER),
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 20),
                              child: FormBuilderOptions(
                                  title: 'Giới tính',
                                  listOptions: controller.genders,
                                  mode: FormBuilderMode.DROP_DOWN),
                            ),
                          ),
                          const Flexible(
                            flex: 1,
                            child: FormBuilderOptions(
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
                                  title: 'CCCD/Mã định danh công dân/Hộ chiếu',
                                  mode: FormBuilderMode.DEFAULT),
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 20),
                              child: FormBuilderOptions(
                                  title: 'Loại vaccine',
                                  listOptions: controller.typeVaccine,
                                  mode: FormBuilderMode.DROP_DOWN),
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: FormBuilderOptions(
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
                                  title: 'Tỉnh/Thành phố',
                                  value: controller.initialTinh.value,
                                  onPress: (data) =>
                                      controller.findListDistricts(data),
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
                                  value: controller.initialHuyen.value,
                                  listOptions: controller.listDistricts.value,
                                  onPress: (data) =>
                                      controller.findListWards(data),
                                  mode: FormBuilderMode.DROP_DOWN),
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: FormBuilderOptions(
                                title: 'Phường/Xã',
                                listOptions: controller.listWards.value,
                                value: controller.initialXa.value,
                                onPress: (data) =>
                                    {controller.initialXa.value = data},
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
                                  title: 'Tuổi',
                                  listOptions: controller.listAges,
                                  mode: FormBuilderMode.DROP_DOWN),
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: FormBuilderOptions(
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
                                  title: 'Ngày muốn được tiêm(dự kiến)',
                                  mode: FormBuilderMode.DATE_PICKER),
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 20),
                              child: FormBuilderOptions(
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
                              // controller.regInjectionFormKey.currentState!
                              //     .reset();
                            },
                            style: ButtonStyle(
                              padding: MaterialStateProperty.all<
                                      EdgeInsetsGeometry>(
                                  const EdgeInsets.symmetric(horizontal: 50)),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  kOnPrimaryColor),
                              foregroundColor:
                                  MaterialStateProperty.all<Color>(kWarning),
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
                            onPressed: () {},
                            style: ButtonStyle(
                              padding: MaterialStateProperty.all<
                                      EdgeInsetsGeometry>(
                                  const EdgeInsets.symmetric(horizontal: 30)),
                              foregroundColor: MaterialStateProperty.all<Color>(
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
