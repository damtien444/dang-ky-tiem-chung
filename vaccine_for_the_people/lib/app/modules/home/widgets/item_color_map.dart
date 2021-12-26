import 'package:flutter/material.dart';

class ItemColorMap extends StatelessWidget {
  const ItemColorMap({
    Key? key, required this.text, required this.color,
  }) : super(key: key);
  final String text;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Container(
            width: 15,
            height: 15,
            decoration: BoxDecoration(
              color: color,
            ),
          ),
          SizedBox(width: 5,),
          Text(text)
        ],
      ),

    );
  }
}

