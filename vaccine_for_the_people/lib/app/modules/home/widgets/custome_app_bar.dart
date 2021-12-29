import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vaccine_for_the_people/app/core/values/custome_colors.dart';
import 'package:vaccine_for_the_people/app/routes/app_routes.dart';

class CustomeAppBar extends StatefulWidget {
  const CustomeAppBar({
    Key? key,
  }) : super(key: key);

  @override
  State<CustomeAppBar> createState() => _CustomeAppBarState();
}

class _CustomeAppBarState extends State<CustomeAppBar> {
  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return AppBar(
      automaticallyImplyLeading: false,
      flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [
                    0.1,
                    0.4,
                  ],
                  colors: <Color>[
                    CustomeColor.colorAppBarStart,
                    CustomeColor.colorAppBar
                  ])
          )
      ),
      actions: [
        Padding(
          padding: EdgeInsets.only(top: 25,right: size.width*0.05),
          child: Container(
            child: Row(
              children: [
                GestureDetector(
                  onTap: (){
                    Get.offAndToNamed(Routes.HOMESCREEN);
                  },
                  child: Container(
                    width: size.width*0.07,
                    child: AutoSizeText(
                      'Trang chủ',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16),
                      minFontSize: 10,
                    ),
                  ),
                ),
                SizedBox(width: 20,),
                Container(
                  width: size.width*0.07,
                  child: AutoSizeText(
                    'Gửi phản hồi',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                    minFontSize: 10,
                  ),
                ),
                SizedBox(width: 20,),
                GestureDetector(
                  onTap: (){
                    Get.offAndToNamed(Routes.REGISTER_INJECTION);
                  },
                  child: Container(
                    width: size.width*0.07,
                    child: AutoSizeText(
                      'Đăng kí tiêm',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16),
                      minFontSize: 10,
                    ),
                  ),
                ),
                SizedBox(width: size.width*0.05,),
                GestureDetector(
                  onTap: (){
                    Get.offAndToNamed(Routes.LOGIN);
                  },
                  child: Container(
                    width: size.width*0.06,
                    child: AutoSizeText(
                      'Đăng nhập',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16),
                      minFontSize: 10,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
      title: Padding(
        padding: EdgeInsets.only(top: 25,left: size.width*0.05),
        child: Row(
          children: [
            Image.asset(
              "assets/images/icon_heart.png",
              fit: BoxFit.contain,
              height: 40,
              width: 40,
            ),
            SizedBox(width: 20,),
            Container(
              width: size.width*0.25,
              child: AutoSizeText(
                'CỔNG THÔNG TIN TIÊM CHỦNG COVID-19',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 19,color: Colors.white),
                minFontSize: 10,
                maxLines: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
