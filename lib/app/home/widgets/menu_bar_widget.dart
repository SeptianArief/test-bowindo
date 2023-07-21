import 'package:flutter/material.dart';
import 'package:test_bowindo/shared/style_helper.dart';

class MenuBarWidget extends StatelessWidget {
  final int index;
  final int selectedIndex;
  final IconData icon;
  final String title;
  final Function(int) onTap;
  const MenuBarWidget(
      {Key? key,
      required this.index,
      required this.selectedIndex,
      required this.icon,
      required this.title,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.transparent),
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: () {
              onTap(index);
            },
            child: Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color: selectedIndex == index
                            ? Theme.of(context).primaryColor
                            : Colors.black12),
                    color: selectedIndex == index
                        ? Theme.of(context).primaryColor
                        : Colors.transparent),
                child: Row(
                  children: [
                    Icon(
                      icon,
                      color:
                          selectedIndex == index ? Colors.white : Colors.grey,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                        child: Text(
                      title,
                      style: mainFont.copyWith(
                          fontSize: 12,
                          fontWeight: selectedIndex == index
                              ? FontWeight.bold
                              : FontWeight.normal,
                          color: selectedIndex == index
                              ? Colors.white
                              : Colors.grey),
                    ))
                  ],
                )),
          ),
        ),
      ],
    );
  }
}
