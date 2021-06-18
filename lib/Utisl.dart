import 'package:flutter/material.dart';

class Utils{
  static Future showBottomSheet(BuildContext context, Widget widget,
      {bool fixContent = false}) {
    double height = MediaQuery.of(context).size.height - 200;
    return showModalBottomSheet(
        context: context,
        enableDrag: false,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (ctx) => Container(
            width: double.infinity,
            height: fixContent ? null : height,
            child: widget));
  }
}