import 'package:flutter/material.dart';

class LabelInjection extends StatelessWidget {
  const LabelInjection({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  width: 3,
                  color: Colors.grey.withOpacity(0.5)
              )
          )
      ),
      child: Row(
        children: [
          Container(
            width: 30,
            height: 50,
            decoration: const BoxDecoration(
              borderRadius:
              BorderRadius.only(topLeft: Radius.circular(10)),
            ),
            child: const Center(
              child: Text("STT",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold),),
            ),
          ),
          SizedBox(
            width: (size.width - 330) / 5,
            height: 50,
            child: const Center(
              child: Text("Tên",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
          const SizedBox(
            width: 30,
            height: 50,
            child: Center(
              child: Text("Tuổi",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
          SizedBox(
            width: (size.width - 330) / 5,
            height: 50,
            child: const Center(
              child: Text("Loại đối tượng",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
          const SizedBox(
            width: 50,
            height: 50,
            child: Center(
              child: Text("Giới tính",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
          SizedBox(
            width: (size.width - 330) / 5,
            height: 50,
            child: const Center(
              child: Text("Mũi tiêm trước đó",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
          SizedBox(
            width: (size.width - 330) / 5,
            height: 50,
            child: const Center(
              child: Text("Thời gian mũi tiêm đến",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
          const SizedBox(
            width: 70,
            height: 50,
            child: Center(
              child: Text("Bệnh nền",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
          SizedBox(
            width: (size.width - 330) / 5,
            height: 50,
            child: const Center(
              child: Text("Địa chỉ",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }
}