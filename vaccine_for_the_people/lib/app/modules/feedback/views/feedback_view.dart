import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import 'package:get/get.dart';
import 'package:vaccine_for_the_people/app/core/components/icons.dart';
import 'package:vaccine_for_the_people/app/core/theme/colors.dart';
import 'package:vaccine_for_the_people/app/core/theme/text_theme.dart';
import 'package:vaccine_for_the_people/app/data/utils/formatters.dart';
import 'package:vaccine_for_the_people/app/modules/home/widgets/custome_app_bar.dart';

import '../controllers/feedback_controller.dart';

class FeedbackView extends GetView<FeedbackController> {
  FeedbackView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
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
                      const TextSpan(text: '  /  Gửi phản hồi tiêm chủng'),
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
                            name: 'mail_from',
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
                          AutoSizeText('Số điện thoại', style: labelStyle),
                          const SizedBox(height: 10),
                          FormBuilderTextField(
                            name: 'phone_number',
                            style: Get.textTheme.headline6,
                            maxLength: 10,
                            validator: FormBuilderValidators.compose(
                              [
                                FormBuilderValidators.required(
                                  context,
                                  errorText:
                                  'Số điện thoại không được bỏ trống',
                                ),
                                FormBuilderValidators.match(
                                  context,
                                  regexPhoneNumber,
                                  errorText: 'Số điện thoại sai định dạng',
                                ),
                              ],
                            ),
                            decoration: const InputDecoration(
                              hintText: 'Số điện thoại',
                              counterText: "",
                            ),
                          ),
                          const SizedBox(height: 20),
                          AutoSizeText('Nội dung phản hồi',
                              style: labelStyle),
                          const SizedBox(height: 10),
                          FormBuilderTextField(
                            name: 'message',
                            style: Get.textTheme.headline5,
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
                            onPressed: () {},
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
