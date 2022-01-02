import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vaccine_for_the_people/app/core/theme/colors.dart';
import 'package:vaccine_for_the_people/app/core/theme/text_theme.dart';
import 'package:vaccine_for_the_people/app/data/utils/formatters.dart';

class FormBuilderOptions extends StatefulWidget {
  const FormBuilderOptions({
    Key? key,
    required this.title,
    this.require = true,
    this.mode = FormBuilderMode.DEFAULT,
    required this.nameForm,
    this.inputMode = InputMode.NAME,
    this.listOptions,
    this.isDropDown = true,
    this.allowClear = false,
    this.onPress,
    this.initial = '', this.listItemsSelection,
  }) : super(key: key);
  final String title;
  final bool require;
  final String nameForm;
  final FormBuilderMode mode;
  final InputMode inputMode;
  final bool isDropDown;
  final bool allowClear;
  final Function(dynamic)? onPress;
  final List<String>? listOptions;
  final String initial;
  final List<String>? listItemsSelection;

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
                initialValue: widget.nameForm == 'province' ||
                        widget.nameForm == 'district'
                    ? widget.initial
                    : null,
                autovalidateMode: widget.require
                    ? AutovalidateMode.onUserInteraction
                    : AutovalidateMode.disabled,
                name: widget.nameForm,
                allowClear: widget.allowClear,
                decoration: InputDecoration(
                  hintText: widget.title,
                ),
                onChanged: widget.onPress,
                validator: FormBuilderValidators.compose(
                  [
                    FormBuilderValidators.required(
                      context,
                      errorText: '${widget.title} không được bỏ trống',
                    )
                  ],
                ),
                focusColor: Colors.transparent,
                enabled: widget.isDropDown,
                items: widget.listOptions?.map((order) {
                      return DropdownMenuItem(
                        value: order,
                        child: AutoSizeText(
                          order,
                          style: Get.textTheme.headline6,
                        ),
                      );
                    }).toList() ??
                    [],
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
