import 'package:get/get.dart';
import 'package:vaccine_for_the_people/app/modules/register_injection/data/providers/viet_nam_provider.dart';
import 'package:vaccine_for_the_people/app/modules/register_injection/data/services/viet_nam_repository.dart';

import '../controllers/statement_data_controller.dart';

class StatementDataBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StatementDataController>(() => StatementDataController(
        vietNamRepository: VietNamRepository(vnProvider: VnProvider())));
  }
}
