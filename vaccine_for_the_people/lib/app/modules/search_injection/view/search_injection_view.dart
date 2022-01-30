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
import 'package:vaccine_for_the_people/app/data/providers/provider_service.dart';
import 'package:vaccine_for_the_people/app/data/services/repository.dart';
import 'package:vaccine_for_the_people/app/modules/home/widgets/bottom_screen.dart';
import 'package:vaccine_for_the_people/app/modules/search_injection/controller/search_injection_controller.dart';

class SearchInjectionView extends GetView<SearchInjectionController> {
  SearchInjectionView({Key? key}) : super(key: key);
  final c=Get.put(SearchInjectionController(repository: Repository(providerService: ProviderService())));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(child: Obx(() {
            return controller.isLoading.value
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
                      color: !controller.isLoading.value
                          ? Colors.black.withOpacity(0.05)
                          : Colors.black12,
                      child: Row(
                        children: [
                          AutoSizeText(
                            'Tra cứu xác nhận tiêm chủng COVID',
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
                                    '  /  Tra cứu xác nhận tiêm vắc xin COVID-19'),
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
                            key: controller.searchInjectionFormKey,
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Image(
                                    image: kVaccineLogo,
                                    width: 120,
                                    height: 120,
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
                                      if (controller.searchInjectionFormKey.currentState!.saveAndValidate()) {
                                        // print(controller.searchInjectionFormKey.currentState!.value["email"]);
                                        controller.isLoading.value=true;
                                        controller.searchDataSearchInjection(controller.searchInjectionFormKey.currentState!.value["email"]);
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
                    height: 70,
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
