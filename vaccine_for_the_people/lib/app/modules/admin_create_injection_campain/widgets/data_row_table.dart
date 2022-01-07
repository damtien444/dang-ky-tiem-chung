import 'package:flutter/material.dart';

class DataRowTable extends StatelessWidget {
  const DataRowTable({
    Key? key,
    required this.size, required this.index,
  }) : super(key: key);

  final Size size;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: (index+1)%2!=0? Colors.grey.withOpacity(0.08):Colors.white
      ),
      child: Row(
        children: [
          Container(
            width: 30,
            height: 40,
            decoration: const BoxDecoration(
              borderRadius:
              BorderRadius.only(topLeft: Radius.circular(10)),
            ),
            child: Center(
              child: Text((index+1).toString(),textAlign: TextAlign.center),
            ),
          ),
          SizedBox(
            width: (size.width - 330) / 5,
            height: 40,
            child: const Center(
              child: Text("Lê Văn A",textAlign: TextAlign.center),
            ),
          ),
          const SizedBox(
            width: 30,
            height: 40,
            child: Center(
              child: Text("20",textAlign: TextAlign.center),
            ),
          ),
          SizedBox(
            width: (size.width - 330) / 5,
            height: 40,
            child: const Center(
              child: Text("Nhân viên y tế",textAlign: TextAlign.center),
            ),
          ),
          const SizedBox(
            width: 50,
            height: 40,
            child: Center(
              child: Text("Nam",textAlign: TextAlign.center),
            ),
          ),
          SizedBox(
            width: (size.width - 330) / 5,
            height: 40,
            child: const Center(
              child: Text("Vaccine Astrazeneca",textAlign: TextAlign.center),
            ),
          ),
          SizedBox(
            width: (size.width - 330) / 5,
            height: 40,
            child: const Center(
              child: Text("03/02/2022",textAlign: TextAlign.center),
            ),
          ),
          const SizedBox(
            width: 70,
            height: 40,
            child: Center(
              child: Text("Có",textAlign: TextAlign.center),
            ),
          ),
          SizedBox(
            width: (size.width - 330) / 5,
            height: 40,
            child: const Center(
              child: Text("Phú gia, Phú Vang, Thừa Thiên Huế",textAlign: TextAlign.center,style: TextStyle(fontSize: 12)),
            ),
          ),
          Container(
            width: 30,
            height: 40,
            decoration: const BoxDecoration(
              borderRadius:
              BorderRadius.only(topRight: Radius.circular(10)),
            ),
            child: Center(
              child: IconButton(
                icon: Icon(Icons.delete,color: Colors.red,size: 16,),
                onPressed: (){
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}