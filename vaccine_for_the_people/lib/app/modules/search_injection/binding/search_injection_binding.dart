import 'package:get/get.dart';
import 'package:vaccine_for_the_people/app/data/providers/provider_service.dart';
import 'package:vaccine_for_the_people/app/data/services/repository.dart';
import 'package:vaccine_for_the_people/app/modules/search_injection/controller/search_injection_controller.dart';

class SearchInjectionBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<SearchInjectionController>(() => SearchInjectionController(repository: Repository(providerService: ProviderService())));
  }
}