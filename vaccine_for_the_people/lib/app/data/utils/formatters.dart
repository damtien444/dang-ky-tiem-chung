import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

final _formatterFullDate = DateFormat('yyyy-MM-dd HH:mm:ss');

DateTime _valid(DateTime? dateTime) => (dateTime ?? DateTime.now()).toLocal();

String formatterFullDate(DateTime dateTime) => _formatterFullDate.format(
      _valid(dateTime),
    );

class FormatterPhoneNumber extends TextInputFormatter {
  FormatterPhoneNumber({required this.format, required this.separator});

  final String format;
  final String separator;

  static const PHONE_NUMBER_REGEX =  r'\d{3}-\d{4}-\d{4}';

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isNotEmpty &&
        newValue.text.length > oldValue.text.length) {
      if (newValue.text.length > format.length) return oldValue;
      if (newValue.text.length < format.length &&
          format[newValue.text.length - 1] == separator) {
        return TextEditingValue(
          text: '${oldValue.text}$separator${newValue.text.substring(
            newValue.text.length - 1,
          )}',
          selection:
              TextSelection.collapsed(offset: newValue.selection.end + 1),
        );
      }
    }
    return newValue;
  }
}
