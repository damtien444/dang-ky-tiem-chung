import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

final _formatterFullDate = DateFormat('yyyy-MM-dd HH:mm:ss');

DateTime _valid(DateTime? dateTime) => (dateTime ?? DateTime.now()).toLocal();

String formatterFullDate(DateTime dateTime) => _formatterFullDate.format(
      _valid(dateTime),
    );
const regexPhoneNumber = r'^[0-9]{10}$';
