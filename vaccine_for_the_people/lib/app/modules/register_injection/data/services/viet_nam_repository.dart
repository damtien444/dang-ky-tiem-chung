import 'package:vaccine_for_the_people/app/modules/register_injection/data/models/viet_nam.dart';
import 'package:vaccine_for_the_people/app/modules/register_injection/data/providers/viet_nam_provider.dart';

class VietNamRepository {
  VnProvider vnProvider;

  VietNamRepository({required this.vnProvider});

  static Future<List<VietNam>> getProvinces() {
    return VnProvider.getProvinces();
  }
}
