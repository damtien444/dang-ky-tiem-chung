import 'package:get/get.dart';
import 'package:vaccine_for_the_people/app/data/providers/provider_service.dart';
import 'package:vaccine_for_the_people/app/data/services/repository.dart';

import '../controllers/search_feedback_controller.dart';

class SearchFeedbackBinding extends Bindings {
  @override
  void dependencies() {
    @override
    void dependencies() {
      Get.lazyPut<SearchFeedbackController>(() => SearchFeedbackController(
          repository: Repository(providerService: ProviderService())));
    }
  }
}
