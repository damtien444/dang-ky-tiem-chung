import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vaccine_for_the_people/app/core/theme/theme.dart';
import 'package:vaccine_for_the_people/app/modules/feedback/bindings/feedback_binding.dart';
import 'package:vaccine_for_the_people/app/modules/home/binding/home_binding.dart';
import 'package:vaccine_for_the_people/app/modules/home/view/home_view.dart';
import 'package:vaccine_for_the_people/app/modules/login/bindings/login_binding.dart';
import 'package:vaccine_for_the_people/app/modules/register_injection/bindings/register_injection_binding.dart';
import 'package:vaccine_for_the_people/app/routes/app_pages.dart';
import 'package:vaccine_for_the_people/app/routes/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: defaultAppThemeData,
      initialRoute: Routes.REGISTER_INJECTION,
      initialBinding: RegisterInjectionBinding(),
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
    );
  }
}
