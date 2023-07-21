import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:test_bowindo/shared/style_helper.dart';

class TableWidgetData extends StatelessWidget {
  final String title;
  final Widget data;
  const TableWidgetData({super.key, required this.title, required this.data});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [
          Flexible(
            flex: 2,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black12)),
              padding: const EdgeInsets.all(10),
              child: Text(
                title,
                style: mainFont.copyWith(
                    fontSize: 14,
                    color: Colors.black87,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Flexible(
            flex: 8,
            child: Container(
              width: double.infinity,
              alignment: Alignment.centerLeft,
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black12)),
              padding: const EdgeInsets.all(10),
              child: data,
            ),
          )
        ],
      ),
    );
  }
}
