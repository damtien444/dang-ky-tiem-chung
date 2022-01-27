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

import '../controllers/feedback_controller.dart';

class FeedbackView extends GetView<FeedbackController> {
  FeedbackView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Positioned.fill(child: Obx(() {
          return !controller.ready.value
              ? Container(
                  color: Colors.black45,
                  child: Center(
                    child:
                        SizedBox(width: 50, height: 50, child: LoadingWidget()),
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
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 60, vertical: 20),
                  color: controller.ready.value
                      ? Colors.black.withOpacity(0.05)
                      : kHeaderPage,
                  child: Row(
                    children: [
                      AutoSizeText(
                        'Gửi phản hồi tiêm chủng',
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
                            const TextSpan(
                                text: '  /  Gửi phản hồi tiêm chủng'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: SizedBox(
                    width: Get.width * 0.3,
                    child: Column(
                      children: [
                        FormBuilder(
                          autovalidateMode: AutovalidateMode.disabled,
                          key: controller.feedBackFormKey,
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
                                AutoSizeText('Họ và tên', style: labelStyle),
                                const SizedBox(height: 10),
                                FormBuilderTextField(
                                  name: 'name',
                                  style: Get.textTheme.headline6,
                                  validator: FormBuilderValidators.compose(
                                    [
                                      FormBuilderValidators.required(
                                        context,
                                        errorText:
                                            'Tên đăng nhập không được bỏ trống',
                                      ),
                                    ],
                                  ),
                                  decoration: const InputDecoration(
                                    hintText: 'Họ và tên ',
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
                                        errorText: 'Email không được bỏ trống',
                                      ),
                                      FormBuilderValidators.email(
                                        context,
                                        errorText:
                                            'Vui lòng nhập đúng định dạng email',
                                      )
                                    ],
                                  ),
                                  decoration: const InputDecoration(
                                    hintText: 'covid19@gov.com',
                                  ),
                                ),
                                const SizedBox(height: 20),
                                AutoSizeText('Nội dung phản hồi',
                                    style: labelStyle),
                                const SizedBox(height: 10),
                                FormBuilderTextField(
                                  name: 'content',
                                  style: Get.textTheme.headline6,
                                  minLines: 7,
                                  maxLines: null,
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.required(
                                      context,
                                      errorText: 'Nội dung không được trống',
                                    ),
                                  ]),
                                ),
                                const SizedBox(height: 40),
                                ElevatedButton(
                                  onPressed: () async {
                                    if (controller.feedBackFormKey.currentState!
                                        .saveAndValidate()) {
                                      await controller.report(controller
                                          .feedBackFormKey.currentState!.value);
                                      controller.feedBackFormKey.currentState!.reset();
                                    }
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
                ),
                const SizedBox(
                  height: 50,
                ),
                const BottomSceen(),
              ],
            ),
          ),
        )
      ]),
    );
  }

  final labelStyle = Get.textTheme.headline6!.copyWith(
    fontWeight: kFontWeightBold,
  );
  final noteStyle = Get.textTheme.bodyText2!.copyWith(
    color: kError,
  );
}
