import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import 'package:get/get.dart';
import 'package:vaccine_for_the_people/app/core/theme/colors.dart';
import 'package:vaccine_for_the_people/app/core/theme/text_theme.dart';
import 'package:vaccine_for_the_people/app/data/utils/formatters.dart';

import '../controllers/feedback_controller.dart';

class FeedbackView extends GetView<FeedbackController> {
  FeedbackView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FeedbackView'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FormBuilder(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              key: controller.feedBackFormKey,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AutoSizeText(
                      '下記フォームに必要事項をご記入ください。',
                      style: Get.textTheme.headline6,
                    ),
                    const SizedBox(height: 20),
                    AutoSizeText('お名前', style: labelStyle),
                    const SizedBox(height: 10),
                    FormBuilderTextField(
                      name: 'name',
                      style: Get.textTheme.headline5,
                      validator: FormBuilderValidators.compose(
                        [
                          FormBuilderValidators.required(
                            context,
                            errorText: 'Tên đăng nhập không được bỏ trống',
                          ),
                        ],
                      ),
                      decoration: const InputDecoration(
                        hintText: 'Họ và tên ',
                      ),
                      keyboardType: TextInputType.name,
                    ),
                    const SizedBox(height: 20),
                    AutoSizeText('メールアドレス', style: labelStyle),
                    const SizedBox(height: 10),
                    FormBuilderTextField(
                      name: 'mail_from',
                      style: Get.textTheme.headline5,
                      validator: FormBuilderValidators.compose(
                        [
                          FormBuilderValidators.required(
                            context,
                            errorText: 'Email không được bỏ trống',
                          ),
                          FormBuilderValidators.email(
                            context,
                            errorText: 'Vui lòng nhập đúng định dạng email',
                          )
                        ],
                      ),
                      decoration: const InputDecoration(
                        hintText: 'covid19@gov.com',
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 20),
                    AutoSizeText('電話番号', style: labelStyle),
                    const SizedBox(height: 10),
                    FormBuilderTextField(
                      name: 'phone_number',
                      style: Get.textTheme.headline5,
                      inputFormatters: [
                        FormatterPhoneNumber(
                          format: 'xxx-xxxx-xxxx',
                          separator: '-',
                        ),
                      ],
                      validator: FormBuilderValidators.compose(
                        [
                          FormBuilderValidators.required(
                            context,
                            errorText: '電話番号を入力してください',
                          ),
                          FormBuilderValidators.match(
                            context,
                            FormatterPhoneNumber.PHONE_NUMBER_REGEX,
                            errorText: '090-1234-5678の形式で入力してください。',
                          ),
                        ],
                      ),
                      decoration: const InputDecoration(
                        hintText: '090-1234-5678',
                      ),
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: 20),
                    AutoSizeText('お問い合わせ内容', style: labelStyle),
                    const SizedBox(height: 10),
                    FormBuilderTextField(
                      name: 'message',
                      style: Get.textTheme.headline5,
                      minLines: 7,
                      maxLines: null,
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(
                          context,
                          errorText: 'ご入力ください',
                        ),
                      ]),
                      decoration: const InputDecoration(
                        hintText: 'ご要望をご記入ください。',
                      ),
                      keyboardType: TextInputType.text,
                    ),
                    const SizedBox(height: 20),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () {},
                      child: const AutoSizeText('内容を確認する'),
                    ),
                  ],
                ),
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
  final noteStyle = Get.textTheme.headline6!.copyWith(
    color: kPrimaryColor,
    decoration: TextDecoration.underline,
  );
}
