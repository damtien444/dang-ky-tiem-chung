import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:vaccine_for_the_people/app/core/values/custome_colors.dart';

class BottomSceen extends StatelessWidget {
  const BottomSceen({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width,
      height: size.height * 0.25 + 20,
      decoration: BoxDecoration(color: CustomeColor.colorAppBar),
      child: Padding(
        padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: size.width * 0.45,
                  child: AutoSizeText(
                    '© Bản quyền thuộc TRUNG TÂM CÔNG NGHỆ PHÒNG, CHỐNG DỊCH COVID-19 QUỐC GIA',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                    minFontSize: 10,
                    textAlign: TextAlign.center,
                    maxLines: 5,
                  ),
                ),
                Container(
                  width: size.width * 0.2,
                  child: AutoSizeText(
                    'Tải sổ sức khỏe điện tử để đăng ký tiêm',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                    minFontSize: 10,
                    textAlign: TextAlign.center,
                    maxLines: 5,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    child: Text(
                  "Phát triển bởi: Viettel",
                  style: TextStyle(color: Colors.white),
                )),
                Container(
                  child: Row(
                    children: [
                      Container(
                          width: 100,
                          height: 40,
                          decoration: BoxDecoration(
                              border: Border.all(width: 1, color: Colors.white),
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(15),
                                topLeft: Radius.circular(15),
                                bottomRight: Radius.circular(15),
                              )),
                          child: Center(
                            child: Text(
                              "App Store",
                              style: TextStyle(color: Colors.white),
                            ),
                          )),
                      SizedBox(
                        width: 20,
                      ),
                      Container(
                        child: Row(
                          children: [
                            Container(
                                width: 100,
                                height: 40,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1, color: Colors.white),
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(15),
                                      topLeft: Radius.circular(15),
                                      bottomRight: Radius.circular(15),
                                    )),
                                child: Center(
                                  child: Text(
                                    "Google Play",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                )),
                            SizedBox(
                              width: 20,
                            ),
                            Container(
                              child: Row(
                                children: [
                                  Container(
                                      width: 100,
                                      height: 40,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 1, color: Colors.white),
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(15),
                                            topLeft: Radius.circular(15),
                                            bottomRight: Radius.circular(15),
                                          )),
                                      child: Center(
                                        child: Text(
                                          "App Gallery",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ))
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                    height: 80,
                    child: Image.asset("assets/images/logo2bo.png")),
                SizedBox(
                    height: 80,
                    child: Image.asset("assets/images/handle_cert.png"))
              ],
            )
          ],
        ),
      ),
    );
  }
}
