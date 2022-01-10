import 'package:get/get.dart';
import 'package:vaccine_for_the_people/app/data/providers/provider_service.dart';
import 'package:vaccine_for_the_people/app/data/services/repository.dart';
import 'package:vaccine_for_the_people/app/modules/injection_statistic/controller/injection_statistic_controller.dart';
import 'package:vaccine_for_the_people/app/modules/register_injection/data/providers/viet_nam_provider.dart';
import 'package:vaccine_for_the_people/app/modules/register_injection/data/services/viet_nam_repository.dart';

class InjectionStatistic extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<InjectionStatisticController>( ()=>
        InjectionStatisticController(repository: Repository(providerService: ProviderService())),
    );
  }

}