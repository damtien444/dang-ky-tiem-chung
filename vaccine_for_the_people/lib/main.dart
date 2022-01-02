import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vaccine_for_the_people/app/core/theme/theme.dart';
import 'package:vaccine_for_the_people/app/modules/feedback/controllers/feedback_controller.dart';
import 'package:vaccine_for_the_people/app/modules/home/binding/home_binding.dart';
import 'package:vaccine_for_the_people/app/modules/login/controllers/login_controller.dart';
import 'package:vaccine_for_the_people/app/modules/register_injection/controllers/register_injection_controller.dart';
import 'package:vaccine_for_the_people/app/modules/register_injection/data/providers/viet_nam_provider.dart';
import 'package:vaccine_for_the_people/app/modules/register_injection/data/services/viet_nam_repository.dart';
import 'package:vaccine_for_the_people/app/routes/app_pages.dart';
import 'package:vaccine_for_the_people/app/routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(RegisterInjectionController(
      vietNamRepository: VietNamRepository(vnProvider: VnProvider())));
  Get.put(LoginController());
  Get.put(FeedbackController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: defaultAppThemeData,
      initialRoute: Routes.NAVIGATION,
      initialBinding: HomeBinding(),
      getPages: AppPages.routes,
    );
  }
}
