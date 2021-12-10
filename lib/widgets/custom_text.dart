import 'package:flutter/material.dart';

const Color myColor = Color(0xFFAFAFF2);

class CustomText extends StatelessWidget {
  String content = "";
  String type;

  CustomText(String content, [this.type = ""]) {
    this.content = content;
    this.type = type;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 5),
        child: RichText(
          text: TextSpan(
            style: DefaultTextStyle.of(context).style,
            children: <TextSpan>[
              if (type != "")
                TextSpan(
                    text: type,
                    style: const TextStyle(
                      color: Colors.black,
                      fontFamily: "Trajan Pro",
                      height: 1.0,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    )),
              TextSpan(
                  text: content,
                  style: const TextStyle(
                    color: Colors.black,
                    fontFamily: "Trajan Pro",
                    height: 1.0,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  )),
            ],
          ),
        ));
  }
}
