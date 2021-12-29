import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import 'package:get/get.dart';
import 'package:vaccine_for_the_people/app/core/components/icons.dart';
import 'package:vaccine_for_the_people/app/core/theme/colors.dart';
import 'package:vaccine_for_the_people/app/core/theme/text_theme.dart';
import 'package:vaccine_for_the_people/app/modules/home/widgets/custome_app_bar.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: CustomeAppBar(),
      ),
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
                    'Đăng nhập',
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
                        const TextSpan(text: '  /  Đăng nhập'),
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
                      key: controller.loginFormKey,
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
                            AutoSizeText('Tên đăng nhập', style: labelStyle),
                            const SizedBox(height: 10),
                            FormBuilderTextField(
                              name: 'username',
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
                                hintText: 'Tên đăng nhập',
                              ),
                            ),
                            const SizedBox(height: 20),
                            AutoSizeText('Mật khẩu', style: labelStyle),
                            const SizedBox(height: 10),
                            FormBuilderTextField(
                              name: 'password',
                              style: Get.textTheme.headline5,
                              obscureText: true,
                              validator: FormBuilderValidators.compose(
                                [
                                  FormBuilderValidators.required(
                                    context,
                                    errorText: 'Mật khẩu không được để trống',
                                  ),
                                ],
                              ),
                              decoration: const InputDecoration(
                                hintText: 'Mật khẩu',
                              ),
                            ),
                            const SizedBox(height: 40),
                            ElevatedButton(
                              onPressed: () {},
                              child: const AutoSizeText('Đăng nhập'),
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
