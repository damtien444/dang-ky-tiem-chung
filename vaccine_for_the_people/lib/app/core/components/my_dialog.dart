import 'package:flutter/material.dart';

class MyDialog extends StatelessWidget {
  const MyDialog(
      {Key? key,
      required this.isSuccess,
      required this.title,
      required this.failedTitle,
      this.onDismissListen,
      this.hasLongMessage = false})
      : super(key: key);
  final bool isSuccess;
  final String title;
  final String failedTitle;
  final bool hasLongMessage;
  final Function? onDismissListen;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: _buildChild(context),
    );
  }

  _buildChild(BuildContext context) => Container(
        width: 360,
        height: hasLongMessage ? 430 : 225,
        decoration: BoxDecoration(
            color: isSuccess
                ? (hasLongMessage ? Colors.white : Colors.green)
                : Colors.redAccent,
            shape: BoxShape.rectangle,
            borderRadius: const BorderRadius.all(Radius.circular(12))),
        child: Column(
          children: <Widget>[
            Container(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                child: Image.asset(
                  'assets/images/logo.png',
                  height: 60,
                  width: 60,
                ),
              ),
              width: double.infinity,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12))),
            ),
            const SizedBox(
              height: 10,
            ),
            hasLongMessage
                ? const Text(
                    "Phản hồi từ ban tiêm chủng",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  )
                : const SizedBox(),
            const SizedBox(
              height: 24,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16, left: 16),
              child: Text(
                isSuccess ? title : failedTitle,
                style: TextStyle(
                    color: hasLongMessage ? Colors.black : Colors.white,
                    fontSize: 16),
                textAlign: hasLongMessage ? TextAlign.left : TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: hasLongMessage
                          ? Colors.grey.withOpacity(0.4)
                          : Colors.white,
                      onPrimary: Colors.black, // foreground
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      textStyle: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.bold)),
                  child: const Text('Đồng ý'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    if (isSuccess) {
                      onDismissListen!();
                    }
                  },
                )
              ],
            )
          ],
        ),
      );
}
