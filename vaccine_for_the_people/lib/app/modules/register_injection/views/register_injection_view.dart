import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:get/get.dart';
import 'package:vaccine_for_the_people/app/core/components/loading_view.dart';
import 'package:vaccine_for_the_people/app/core/theme/colors.dart';
import 'package:vaccine_for_the_people/app/core/theme/text_theme.dart';
import 'package:vaccine_for_the_people/app/modules/home/widgets/bottom_screen.dart';
import 'package:vaccine_for_the_people/app/modules/register_injection/widgets/form_builder_options.dart';

import '../controllers/register_injection_controller.dart';

class RegisterInjectionView extends GetView<RegisterInjectionController> {
  RegisterInjectionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(child: Obx(() {
            return !controller.ready.value
                ? Container(
                    color: Colors.black45,
                    child: Center(
                      child: SizedBox(
                          width: 50, height: 50, child: LoadingWidget()),
                    ),
                  )
                : const SizedBox.shrink();
          })),
          Obx(() {
            return Positioned(
              child: FormBuilder(
                key: controller.regInjectionFormKey,
                child: ListView(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 60, vertical: 20),
                      color: !controller.ready.value
                          ? Colors.black.withOpacity(0.05)
                          : kHeaderPage,
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
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {},
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
                                    formKey: controller.keyOrderInjection,
                                    title: 'Đăng kí mũi tiêm',
                                    onPress: (orderShot) {
                                      controller.orderShot.value = orderShot ==
                                              controller.orderInjection[0]
                                          ? 1
                                          : 2;
                                    },
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
                                          title: 'Tỉnh/Thành phố',
                                          value: controller.initialTinh.value,
                                          onPress: (data) {
                                            controller.findListDistricts(data);
                                            controller.province.value = data;
                                          },
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
                                          title: 'Quận/Huyện',
                                          value: controller.initialHuyen.value,
                                          listOptions:
                                              controller.listDistricts.value,
                                          onPress: (data) {
                                            controller.district.value = data;
                                            controller.findListWards(data);
                                          },
                                          mode: FormBuilderMode.DROP_DOWN),
                                    ),
                                  ),
                                  Flexible(
                                    flex: 1,
                                    child: FormBuilderOptions(
                                        title: 'Phường/Xã',
                                        listOptions: controller.listWards.value,
                                        value: controller.initialXa.value,
                                        onPress: (data) {
                                          controller.initialXa.value = data;
                                          controller.ward.value = data;
                                        },
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
                                          title: 'Họ và tên',
                                          inputMode: InputMode.NAME,
                                          controller:
                                              controller.nameEditingController,
                                          onPress: (data) {
                                            controller.name.value = data;
                                          },
                                          mode: FormBuilderMode.DEFAULT),
                                    ),
                                  ),
                                  Flexible(
                                    flex: 1,
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 20),
                                      child: FormBuilderOptions(
                                          value: controller.init.value,
                                          title: 'Ngày sinh',
                                          onPress: (birthDay) {
                                            controller.birthDay.value =
                                                birthDay;
                                          },
                                          mode: FormBuilderMode.DATE_PICKER),
                                    ),
                                  ),
                                  Flexible(
                                    flex: 1,
                                    child: FormBuilderOptions(
                                        formKey: controller.keySex,
                                        title: 'Giới tính',
                                        onPress: (sex) {
                                          controller.sex.value = sex;
                                        },
                                        listOptions: controller.genders,
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
                                          value: controller.init.value,
                                          controller:
                                              controller.emailEditingController,
                                          title: 'Email',
                                          inputMode: InputMode.EMAIL,
                                          onPress: (email) {
                                            controller.email.value = email;
                                          },
                                          mode: FormBuilderMode.DEFAULT),
                                    ),
                                  ),
                                  Flexible(
                                    flex: 1,
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 20),
                                      child: FormBuilderOptions(
                                          value: controller.init.value,
                                          controller:
                                              controller.idEditingController,
                                          title:
                                              'CCCD/Mã định danh công dân/Hộ chiếu',
                                          onPress: (identificationCard) {
                                            controller.identificationCard
                                                .value = identificationCard;
                                          },
                                          mode: FormBuilderMode.DEFAULT),
                                    ),
                                  ),
                                  Flexible(
                                    flex: 1,
                                    child: FormBuilderOptions(
                                        formKey: controller.keyPriorityGroup,
                                        title: 'Nhóm ưu tiên',
                                        onPress: (type) {
                                          controller.priorityType.value =
                                              (controller.typeObject
                                                          .indexOf(type) +
                                                      1)
                                                  .toString();
                                        },
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
                                          value: controller.init.value,
                                          title: 'Địa chỉ hiện tại',
                                          controller: controller
                                              .addressEditingController,
                                          onPress: (data) {
                                            controller.stNo.value = data;
                                          },
                                          mode: FormBuilderMode.DEFAULT),
                                    ),
                                  ),
                                  Flexible(
                                    flex: 1,
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 20),
                                      child: FormBuilderOptions(
                                          value: controller.init.value,
                                          title: 'Số điện thoại',
                                          controller:
                                              controller.phoneEditingController,
                                          inputMode: InputMode.PHONE,
                                          onPress: (phone) {
                                            controller.phone.value = phone;
                                          },
                                          mode: FormBuilderMode.DEFAULT),
                                    ),
                                  ),
                                  Flexible(
                                    flex: 1,
                                    child: FormBuilderOptions(
                                        formKey: controller.keyAnamesis,
                                        title: 'Tiền sử bệnh',
                                        listOptions: controller.anamesis,
                                        onPress: (illnessHistory) {
                                          controller.illnessHistory.value =
                                              illnessHistory;
                                        },
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
                                          controller: controller.potentialDate,
                                          title: 'Ngày muốn được tiêm(dự kiến)',
                                          onPress: (injectionDay) {
                                            controller.injectionDay.value =
                                                injectionDay;
                                          },
                                          mode: FormBuilderMode.DATE_PICKER),
                                    ),
                                  ),
                                  const Spacer(flex: 2),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Visibility(
                                visible: controller.orderShot.value == 2
                                    ? true
                                    : false,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AutoSizeText('3. Lịch sử tiêm mũi 1',
                                        style: labelStyle),
                                    const SizedBox(height: 20),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Flexible(
                                          flex: 1,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                right: 20),
                                            child: FormBuilderOptions(
                                                require: false,
                                                title: 'Địa chỉ tiêm mũi 1',
                                                value: controller.init.value,
                                                onPress: (place) {
                                                  controller.place.value =
                                                      place;
                                                },
                                                controller: controller.placeEditingController,
                                                mode: FormBuilderMode.DEFAULT),
                                          ),
                                        ),
                                        Flexible(
                                          flex: 1,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                right: 20),
                                            child: FormBuilderOptions(
                                                value: controller.init.value,
                                                onPress: (injectionDay) {
                                                  controller.injectionFirstDay
                                                      .value = injectionDay;
                                                },
                                                controller: controller.dayFirstInjectionEditingController,
                                                title: 'Thời gian tiêm mũi 1',
                                                mode: FormBuilderMode
                                                    .DATE_PICKER),
                                          ),
                                        ),
                                        Flexible(
                                          flex: 1,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                right: 20),
                                            child: FormBuilderOptions(
                                                require: false,
                                                formKey: controller.typeVaccineKey,
                                                title: 'Loại vaccine mũi 1',
                                                listOptions:
                                                    controller.typeVaccine,
                                                onPress: (type) {
                                                  controller
                                                      .typeFirstInjectionDay
                                                      .value = type;
                                                },
                                                mode:
                                                    FormBuilderMode.DROP_DOWN),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 50),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      controller.resetData();
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
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  ElevatedButton(
                                    onPressed: () async {
                                      if (controller
                                          .regInjectionFormKey.currentState!
                                          .validate()) {
                                        await controller.vaccinationSign({
                                          "order_shot":
                                              controller.orderShot.value,
                                          "name": controller.name.value,
                                          "birth_day":
                                              controller.birthDay.value,
                                          "sex": controller.sex.value == "Nam"
                                              ? true
                                              : false,
                                          "phone": controller.phone.value,
                                          "email": controller.email.value,
                                          "CCCD": controller
                                              .identificationCard.value,
                                          "BHXH_id": '',
                                          "address": {
                                            "province":
                                                controller.province.value,
                                            "district":
                                                controller.district.value,
                                            "ward": controller.initialXa.value,
                                            "st_no": controller.stNo.value
                                          },
                                          "priority_group": int.parse(
                                              controller.priorityType.value),
                                          "illness_history":
                                              controller.illnessHistory.value ==
                                                      "Có"
                                                  ? true
                                                  : false,
                                          "expected_shot_date":
                                              controller.injectionDay.value,
                                          "first_shot":
                                              controller.orderShot.value == 2
                                                  ? {
                                                      "type_name": controller
                                                          .typeFirstInjectionDay
                                                          .value,
                                                      "shot_date": controller
                                                          .injectionFirstDay
                                                          .value,
                                                      "shot_place":
                                                          controller.place.value
                                                    }
                                                  : null
                                        });
                                        Future.delayed(
                                            const Duration(milliseconds: 500),
                                            () {
                                          controller.resetData();
                                        });
                                      }
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
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const BottomSceen(),
                  ],
                ),
              ),
            );
          }),
        ],
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
