import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vaccine_for_the_people/app/core/values/custome_colors.dart';
import 'package:vaccine_for_the_people/app/modules/home/controller/home_controller.dart';

class CovidCaseVietNam extends StatelessWidget {
  CovidCaseVietNam({
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
      decoration: BoxDecoration(
          border:Border(
              right: BorderSide(
                  color: Colors.grey,
                  width: 1
              )
          )
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Column(
          children: [
            Container(
              width: size.width*0.2,
              child: AutoSizeText(
                'Tổng số người mắc',
                style: TextStyle(fontSize: 18,color: Colors.orange),
                minFontSize: 10,
                textAlign: TextAlign.center,
                maxLines: 2,
              ),
            ),
            SizedBox(height: 7,),
            c1.totalCase.value!=0?AutoSizeText(
              formatter.format(c1.totalCase.value),
              style: TextStyle(fontSize: 16),
              minFontSize: 10,
            ):SizedBox(
                width: 25,
                height: 25,
                child: CircularProgressIndicator(
                  backgroundColor: CustomeColor.colorAppBar,
                )
            )
          ],
        ),
      ),
    );
  }
}