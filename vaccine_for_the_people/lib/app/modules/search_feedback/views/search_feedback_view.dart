import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import 'package:get/get.dart';
import 'package:vaccine_for_the_people/app/core/components/icons.dart';
import 'package:vaccine_for_the_people/app/core/components/loading_view.dart';
import 'package:vaccine_for_the_people/app/core/theme/colors.dart';
import 'package:vaccine_for_the_people/app/core/theme/text_theme.dart';
import 'package:vaccine_for_the_people/app/modules/home/widgets/bottom_screen.dart';

import '../controllers/search_feedback_controller.dart';

class SearchFeedbackView extends GetView<SearchFeedbackController> {
  SearchFeedbackView({Key? key}) : super(key: key);

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
          Positioned(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Obx(() {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 60, vertical: 20),
                      color: !controller.ready.value
                          ? Colors.black.withOpacity(0.05)
                          : kHeaderPage,
                      child: Row(
                        children: [
                          AutoSizeText(
                            'Tra cứu Phản ánh tiêm chủng vắc xin COVID-19',
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
                                const TextSpan(
                                    text:
                                        '  /  Tra cứu Phản ánh tiêm chủng vắc xin COVID-19'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                  Center(
                    child: SizedBox(
                      width: Get.width * 0.3,
                      child: Column(
                        children: [
                          FormBuilder(
                            autovalidateMode: AutovalidateMode.disabled,
                            key: controller.searchFeedbackFormKey,
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  const Image(
                                    image: kVaccineLogo,
                                    width: 120,
                                    height: 120,
                                  ),
                                  const SizedBox(height: 20),
                                  AutoSizeText('Họ và tên',
                                      style: labelStyle),
                                  const SizedBox(height: 10),
                                  FormBuilderTextField(
                                    name: 'name',
                                    style: Get.textTheme.headline6,
                                    validator: FormBuilderValidators.compose(
                                      [
                                        FormBuilderValidators.required(
                                          context,
                                          errorText: 'Tên không được bỏ trống',
                                        ),
                                      ],
                                    ),
                                    decoration: const InputDecoration(
                                      hintText: 'Họ và tên',
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  AutoSizeText('Email', style: labelStyle),
                                  const SizedBox(height: 10),
                                  FormBuilderTextField(
                                    name: 'email',
                                    style: Get.textTheme.headline6,
                                    validator: FormBuilderValidators.compose(
                                      [
                                        FormBuilderValidators.required(
                                          context,
                                          errorText:
                                              'Email không được bỏ trống',
                                        ),
                                      ],
                                    ),
                                    decoration: const InputDecoration(
                                      hintText: 'Email',
                                    ),
                                  ),
                                  const SizedBox(height: 40),
                                  ElevatedButton(
                                    onPressed: () async {
                                      if (controller
                                          .searchFeedbackFormKey.currentState!
                                          .saveAndValidate()) {
                                        await controller.searchResult(
                                            controller.searchFeedbackFormKey
                                                .currentState!.value['name'],
                                            controller.searchFeedbackFormKey
                                                .currentState!.value['email']);
                                      }
                                    },
                                    child: const AutoSizeText('Tìm kiếm'),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const BottomSceen(),
                ],
              ),
            ),
          ),
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
