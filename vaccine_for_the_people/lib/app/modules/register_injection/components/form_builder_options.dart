import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vaccine_for_the_people/app/core/theme/colors.dart';
import 'package:vaccine_for_the_people/app/core/theme/text_theme.dart';
import 'package:vaccine_for_the_people/app/data/utils/formatters.dart';
import 'package:vaccine_for_the_people/app/modules/register_injection/controllers/register_injection_controller.dart';

class FormBuilderOptions extends StatefulWidget {
  const FormBuilderOptions({
    Key? key,
    required this.regFormKey,
    required this.title,
    this.require = true,
    this.mode = FormBuilderMode.DEFAULT,
    required this.nameForm,
    this.inputMode = InputMode.NAME,
    this.dropDownMode = DropDownMode.ORDER,
  }) : super(key: key);
  final GlobalKey<FormBuilderState> regFormKey;
  final String title;
  final bool require;
  final String nameForm;
  final FormBuilderMode mode;
  final InputMode inputMode;
  final DropDownMode dropDownMode;

  @override
  _FormBuilderOptionsState createState() => _FormBuilderOptionsState();
}

class _FormBuilderOptionsState extends State<FormBuilderOptions> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AutoSizeText.rich(
          TextSpan(
            style: Get.textTheme.headline6,
            children: [
              TextSpan(text: widget.title),
              if (widget.require)
                const TextSpan(
                  text: ' (*)',
                  style: TextStyle(
                    color: kError,
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        () {
          switch (widget.mode) {
            case FormBuilderMode.DEFAULT:
              return FormBuilderTextField(
                autovalidateMode: widget.require
                    ? AutovalidateMode.onUserInteraction
                    : AutovalidateMode.disabled,
                name: widget.nameForm,
                style: Get.textTheme.headline6,
                maxLength: widget.inputMode == InputMode.PHONE ? 10 : null,
                validator: FormBuilderValidators.compose(
                  [
                    FormBuilderValidators.required(
                      context,
                      errorText: '${widget.title} không được bỏ trống',
                    ),
                    if (widget.inputMode == InputMode.NAME)
                      ...[]
                    else if (widget.inputMode == InputMode.EMAIL) ...[
                      FormBuilderValidators.email(
                        context,
                        errorText: 'Vui lòng nhập đúng định dạng email',
                      ),
                    ] else if (widget.inputMode == InputMode.PHONE) ...[
                      FormBuilderValidators.match(
                        context,
                        regexPhoneNumber,
                        errorText: 'Số điện thoại sai định dạng',
                      ),
                    ],
                  ],
                ),
                decoration: InputDecoration(
                  hintText: widget.title,
                  counterText: "",
                ),
              );
            case FormBuilderMode.DROP_DOWN:
              return FormBuilderDropdown(
                autovalidateMode: widget.require
                    ? AutovalidateMode.onUserInteraction
                    : AutovalidateMode.disabled,
                name: widget.nameForm,
                decoration: InputDecoration(
                  hintText: widget.title,
                ),
                allowClear: true,
                validator: FormBuilderValidators.compose(
                  [
                    FormBuilderValidators.required(
                      context,
                      errorText: '${widget.title} không được bỏ trống',
                    )
                  ],
                ),
                focusColor: Colors.transparent,
                items: createSelectionItem(widget.dropDownMode),
              );
            case FormBuilderMode.DATE_PICKER:
              return FormBuilderDateTimePicker(
                autovalidateMode: widget.require
                    ? AutovalidateMode.onUserInteraction
                    : AutovalidateMode.disabled,
                name: widget.title,
                style: Get.textTheme.headline6,
                inputType: InputType.date,
                decoration: const InputDecoration(
                  hintText: 'Ngày/Tháng/Năm',
                ),
                validator: FormBuilderValidators.compose(
                  [
                    FormBuilderValidators.required(
                      context,
                      errorText: '${widget.title} không được bỏ trống',
                    )
                  ],
                ),
                format: DateFormat("dd/MM/yyyy"),
                enabled: true,
              );
          }
        }(),
      ],
    );
  }

  final labelStyle = Get.textTheme.headline6!.copyWith(
    fontWeight: kFontWeightBold,
  );
  final noteStyle = Get.textTheme.headline6!.copyWith(
    color: kError,
  );
}

List<DropdownMenuItem> createSelectionItem(DropDownMode dropDownMode) {
  switch (dropDownMode) {
    case DropDownMode.ORDER:
      return Get.find<RegisterInjectionController>().orderInjection.map(
        (order) {
          return DropdownMenuItem(
            value: order,
            child: AutoSizeText(
              order,
              style: Get.textTheme.headline6,
            ),
          );
        },
      ).toList();
    case DropDownMode.GENDER:
      return Get.find<RegisterInjectionController>().genders.map(
        (gender) {
          return DropdownMenuItem(
            value: gender,
            child: AutoSizeText(
              gender,
              style: Get.textTheme.headline6,
            ),
          );
        },
      ).toList();
  }
}

enum FormBuilderMode {
  DEFAULT,
  DROP_DOWN,
  DATE_PICKER,
}
enum InputMode {
  NAME,
  EMAIL,
  PHONE,
}
enum DropDownMode {
  ORDER,
  GENDER,
}
