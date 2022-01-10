import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:vaccine_for_the_people/app/modules/register_injection/data/models/viet_nam.dart';

class VnProvider {
  static Future<List<VietNam>> getProvinces() async {
    final data = await rootBundle.loadString(
      'assets/province.json',
    );
    Iterable l = jsonDecode(data);
    List<VietNam> posts =
        List<VietNam>.from(l.map((model) => VietNam.fromJson(model)));
    return posts;
  }

}
