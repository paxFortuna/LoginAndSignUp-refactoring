import 'package:flutter/material.dart';
import 'package:login_signup_refactoring/utils/theme.dart';

class MyInputField extends StatelessWidget {
  final String title;
  final String hint;
  final TextEditingController? controller;
  final Widget? widget;

  const MyInputField({
    Key? key,
    required this.title,
    required this.hint,
    this.controller,
    this.widget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: subTitleStyle, // theme.dart
          ),
          Container(
            height: 42,
            margin: const EdgeInsets.only(top: 8.0),
            padding: const EdgeInsets.only(left: 14),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 1.0),
              borderRadius: BorderRadius.circular(12),
            ),
            // BoxDecoration
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    // Date: 텍스트 필드에 widget 파라미터가 있는 경우 삼항 연산
                    readOnly: widget == null ? false : true,
                    autofocus: false,
                    //cursorColor:
                    //Get.isDarkMode ? Colors.grey[100] : Colors.grey[700],
                    controller: controller,
                    style: subTitleStyle,
                    // theme.dart
                    decoration: InputDecoration(
                      hintText: hint,
                      // MyInputField(title: "Title", hint: "Enter your title"),
                      hintStyle: subTitleStyle,
                      // theme.dart
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black54,
                          width: 0,
                        ),
                      ),
                      // UnderlineInputBorder
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black54,
                          width: 0,
                        ),
                      ), // UnderlineInputBorder
                    ), // InputDecoration
                  ), // textFormField
                ), // expanded
                widget == null ? Container() : Container(child: widget),
              ],
            ), //row
          ), // container
        ],
      ), // column
    ); // container
  }
}
