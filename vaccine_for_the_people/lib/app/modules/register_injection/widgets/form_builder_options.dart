import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vaccine_for_the_people/app/core/components/datetime_picker_formfield.dart';
import 'package:vaccine_for_the_people/app/core/theme/colors.dart';
import 'package:vaccine_for_the_people/app/core/theme/text_theme.dart';
import 'package:vaccine_for_the_people/app/data/providers/provider_service.dart';
import 'package:vaccine_for_the_people/app/data/services/repository.dart';
import 'package:vaccine_for_the_people/app/data/utils/formatters.dart';
import 'package:vaccine_for_the_people/app/modules/admin_create_injection_campain/controller/create_injection_campaign_controller.dart';

class FormBuilderOptions extends StatefulWidget {
    const FormBuilderOptions({
    Key? key,
    required this.title,
    this.require = true,
    this.mode = FormBuilderMode.DEFAULT,
    this.inputMode = InputMode.NAME,
    this.listOptions,
    this.onPress,
    this.value = '',
    this.onTextChange,
  }) : super(key: key);
  final String title;
  final bool require;
  final FormBuilderMode mode;
  final InputMode inputMode;
  final Function(String)? onPress;
  final Function(String)? onTextChange;
  final List<String>? listOptions;
  final String value;

  @override
  _FormBuilderOptionsState createState() => _FormBuilderOptionsState();
}

class _FormBuilderOptionsState extends State<FormBuilderOptions> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController textController=TextEditingController(text:  widget.value);
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
              return TextFormField(
                onChanged: (newValue) {
                  widget.onPress!(newValue);
                },
                autovalidateMode: widget.require
                    ? AutovalidateMode.onUserInteraction
                    : AutovalidateMode.disabled,
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
            case FormBuilderMode.DEFAULT1:
              return TextFormField(
                onChanged: (newValue) {
                  widget.onPress!(newValue);
                },
                controller: textController,
                autovalidateMode: widget.require
                    ? AutovalidateMode.onUserInteraction
                    : AutovalidateMode.disabled,
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
              );
            case FormBuilderMode.DROP_DOWN:
              return widget.title == 'Tỉnh/Thành phố' ||
                      widget.title == 'Quận/Huyện' ||
                      widget.title == 'Phường/Xã'
                  ? FormField<String>(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: FormBuilderValidators.compose(
                        [
                          FormBuilderValidators.match(
                            context,
                            '^(?!Tất cả).*',
                            errorText: 'Vui lòng chọn địa chỉ chính xác',
                          )
                        ],
                      ),
                      builder: (_) {
                        return InputDecorator(
                          decoration: InputDecoration(
                            labelStyle: Get.textTheme.headline6,
                            errorStyle: Get.textTheme.bodyText2!.copyWith(
                              color: kError,
                            ),
                            hintText: widget.title,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              isExpanded: true,
                              value: widget.value,
                              onChanged: (newValue) {
                                widget.onPress!(newValue!);
                              },
                              isDense: true,
                              items: widget.listOptions?.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: AutoSizeText(
                                    value,
                                    overflow: TextOverflow.ellipsis,
                                    style: Get.textTheme.headline6,
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        );
                      },
                    )
                  : DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        hintText: widget.title,
                      ),
                      isExpanded: true,
                      value: null,
                      icon: const Icon(Icons.arrow_drop_down),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: FormBuilderValidators.compose(
                        [
                          FormBuilderValidators.required(
                            context,
                            errorText: '${widget.title} không được bỏ trống',
                          ),
                        ],
                      ),
                      focusColor: Colors.transparent,
                      items: widget.listOptions?.map((value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: AutoSizeText(
                            value,
                            style: Get.textTheme.headline6,
                          ),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        widget.onPress!(newValue!);
                      },
                    );
            case FormBuilderMode.DATE_PICKER:
              return DateTimeField(
                onShowPicker: (context, currentValue) {
                  return showDatePicker(
                      context: context,
                      firstDate: DateTime(1900),
                      initialDate: currentValue ?? DateTime.now(),
                      lastDate: DateTime(2100));
                },
                onChanged: (dateTime) {
                  widget.onPress!(formatterFullDate(dateTime!));
                },
                autovalidateMode: widget.require
                    ? AutovalidateMode.onUserInteraction
                    : AutovalidateMode.disabled,
                style: Get.textTheme.headline6,
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
  DEFAULT1,
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
