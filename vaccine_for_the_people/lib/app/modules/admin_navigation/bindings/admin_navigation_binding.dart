import 'package:get/get.dart';
import 'package:vaccine_for_the_people/app/data/providers/provider_service.dart';
import 'package:vaccine_for_the_people/app/data/providers/viet_nam_provider.dart';
import 'package:vaccine_for_the_people/app/data/services/repository.dart';
import 'package:vaccine_for_the_people/app/data/services/viet_nam_repository.dart';
import 'package:vaccine_for_the_people/app/modules/admin_navigation/controller/admin_navigation_controller.dart';
import 'package:vaccine_for_the_people/app/modules/injection_statistic/controller/injection_statistic_controller.dart';
import 'package:vaccine_for_the_people/app/modules/statement_data/controllers/statement_data_controller.dart';

class AdminNavigationBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<AdminNavigationController>(() => AdminNavigationController());
    Get.lazyPut<StatementDataController>(() => StatementDataController(
        vietNamRepository: VietNamRepository(vnProvider: VnProvider()),
        repository: Repository(providerService: ProviderService())));
    Get.put(InjectionStatisticController(
        repository: Repository(providerService: ProviderService())));

  }
}
