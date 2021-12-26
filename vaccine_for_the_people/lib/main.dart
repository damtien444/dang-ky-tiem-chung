import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vaccine_for_the_people/app/modules/home/binding/home_binding.dart';
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
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: Routes.HOMESCREEN,
      initialBinding:HomeBinding(),
      getPages: AppPages.routes,
    );
  }
}

