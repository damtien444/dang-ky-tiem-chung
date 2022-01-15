import 'package:intl/intl.dart';

final _formatterFullDate = DateFormat('yyyy-MM-dd');

DateTime _valid(DateTime? dateTime) => (dateTime ?? DateTime.now()).toLocal();

String formatterFullDate(DateTime dateTime) => _formatterFullDate.format(
      _valid(dateTime),
    );
const regexPhoneNumber = r'^[0-9]{10}$';

final _formatterDateVi = DateFormat('dd/MM/yyyy');

String formatterDateVi(DateTime dateTime) => _formatterDateVi.format(
  _valid(dateTime),
);