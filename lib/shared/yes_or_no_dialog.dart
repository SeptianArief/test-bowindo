import 'package:flutter/material.dart';
import 'package:test_bowindo/shared/style_helper.dart';

Future<bool> yesOrNoDialog(BuildContext context,
    {required String title,
    required String desc,
    String? customYesTitle,
    String? customNoTitle}) async {
  bool returnValue = false;

  await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            elevation: 2,
            backgroundColor: Colors.white,
            child: Container(
                width: MediaQuery.of(context).size.width * 0.3,
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Text(title,
                        style: mainFont.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87)),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(desc,
                        textAlign: TextAlign.center,
                        style: mainFont.copyWith(
                            fontSize: 11, color: Colors.black87)),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Flexible(
                            flex: 10,
                            child: InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      color: Colors.white,
                                      border: Border.all(
                                          width: 2,
                                          color:
                                              Theme.of(context).primaryColor)),
                                  alignment: Alignment.center,
                                  child: Text(customNoTitle ?? 'Tidak',
                                      style: mainFont.copyWith(
                                          fontSize: 13,
                                          color: Theme.of(context).primaryColor,
                                          fontWeight: FontWeight.bold))),
                            )),
                        const SizedBox(
                          width: 10,
                        ),
                        Flexible(
                            flex: 10,
                            child: InkWell(
                              onTap: () {
                                returnValue = true;
                                Navigator.pop(context);
                              },
                              child: Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      color: Theme.of(context).primaryColor),
                                  alignment: Alignment.center,
                                  child: Text(customYesTitle ?? 'Ya',
                                      style: mainFont.copyWith(
                                          fontSize: 13,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold))),
                            ))
                      ],
                    )
                  ],
                )));
      });

  return returnValue;
}
