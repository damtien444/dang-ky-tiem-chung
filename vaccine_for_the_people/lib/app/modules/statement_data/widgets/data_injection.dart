import 'package:flutter/material.dart';
import 'package:vaccine_for_the_people/app/data/models/injection_registrant.dart';
import 'package:vaccine_for_the_people/app/data/utils/formatters.dart';

class DataInjection extends StatelessWidget {
  const DataInjection({
    Key? key,
    required this.size,
    required this.index,
    required this.element,
    required this.typeObject,
  }) : super(key: key);

  final Size size;
  final ListElement element;
  final int index;
  final List<String> typeObject;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: (index + 1) % 2 != 0
              ? Colors.grey.withOpacity(0.08)
              : Colors.white),
      child: Row(
        children: [
          const SizedBox(
            width: 30,
          ),
          Container(
            width: 30,
            height: 40,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(10)),
            ),
            child: Center(
              child: Text((index + 1).toString(), textAlign: TextAlign.center),
            ),
          ),
          SizedBox(
            width: (size.width - 330) / 5,
            height: 40,
            child: Center(
              child: Text(element.name, textAlign: TextAlign.center),
            ),
          ),
          SizedBox(
            width: 30,
            height: 40,
            child: Center(
              child: Text(element.age.toInt().toString(),
                  textAlign: TextAlign.center),
            ),
          ),
          SizedBox(
            width: (size.width - 330) / 5,
            height: 40,
            child: Center(
              child: Text(
                  typeObject[element.priorityGroup - 1].substring(
                      typeObject[element.priorityGroup - 1].indexOf('.'),
                      typeObject[element.priorityGroup - 1].length),
                  textAlign: TextAlign.center),
            ),
          ),
          SizedBox(
            width: 50,
            height: 40,
            child: Center(
              child: Text(!element.sex ? "Nữ" : "Nam",
                  textAlign: TextAlign.center),
            ),
          ),
          SizedBox(
            width: (size.width - 330) / 5,
            height: 40,
            child: Center(
              child: Text(
                  element.nextExpectedShotType != "NO_NEXT"
                      ? element.nextExpectedShotType
                      : "Chưa xác định",
                  textAlign: TextAlign.center),
            ),
          ),
          SizedBox(
            width: (size.width - 330) / 5,
            height: 40,
            child: Center(
              child: Text(
                  formatterDateVi(element.nextExpectedShotDate) != "01/01/1900"
                      ? formatterDateVi(element.nextExpectedShotDate)
                      : "Chưa xác định",
                  textAlign: TextAlign.center),
            ),
          ),
          SizedBox(
            width: 70,
            height: 40,
            child: Center(
              child: Text(element.illnessHistory ? "Có" : "Không",
                  textAlign: TextAlign.center),
            ),
          ),
          const SizedBox(
            width: 30,
          ),
          SizedBox(
            width: (size.width - 330) / 5,
            height: 40,
            child: Center(
              child: Text(
                  element.address.ward +
                      ' ' +
                      element.address.district +
                      ' ' +
                      element.address.province,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 12)),
            ),
          ),
        ],
      ),
    );
  }
}
