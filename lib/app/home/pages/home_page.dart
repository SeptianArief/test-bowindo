import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:test_bowindo/app/home/viewmodel/home_vm.dart';
import 'package:test_bowindo/app/home/widgets/side_bar_navigation_widget.dart';
import 'package:stacked/stacked.dart';
import 'package:test_bowindo/shared/style_helper.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeVM>.reactive(viewModelBuilder: () {
      return HomeVM();
    }, builder: (context, model, child) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                width: double.infinity,
                color: Theme.of(context).primaryColor,
                child: Text(
                  'Bowindo',
                  style: mainFont.copyWith(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                )),
            Expanded(
                child: Row(
              children: [
                Flexible(
                    flex: 2,
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: const BoxDecoration(
                          border: Border(
                              right:
                                  BorderSide(color: Colors.black38, width: 1))),
                      child: SidebarHomeNavigation(
                        model: model,
                      ),
                    )),
                Flexible(flex: 8, child: model.listPage[model.selectedIndex])
              ],
            )),
          ],
        ),
      );
    });
  }
}
