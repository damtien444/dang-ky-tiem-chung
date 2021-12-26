import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vaccine_for_the_people/app/core/values/custome_colors.dart';
import 'package:vaccine_for_the_people/app/modules/home/controller/home_controller.dart';

class CovidCaseRecoveredVietNam extends StatelessWidget {
  CovidCaseRecoveredVietNam({
    Key? key,
    required this.size,
    required this.c1,
  }) : super(key: key);

  final Size size;
  final HomeController c1;
  var formatter = NumberFormat('#,###,000');

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width*0.25,
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Column(
          children: [
            Container(
              width: size.width*0.2,
              child: AutoSizeText(
                'Đã bình phục',
                style: TextStyle(fontSize: 18,color: Colors.green),
                minFontSize: 10,
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 7,),
            c1.totalRecovered.value!=0 ? AutoSizeText(
              formatter.format(c1.totalRecovered.value),
              style: TextStyle(fontSize: 16),
              minFontSize: 10,
            ):SizedBox(
                width: 25,
                height: 25,
                child: CircularProgressIndicator(
                  backgroundColor: CustomeColor.colorAppBar,
                )
            ),
          ],
        ),
      ),
    );
  }
}
