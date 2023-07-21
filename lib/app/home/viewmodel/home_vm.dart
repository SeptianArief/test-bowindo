import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:test_bowindo/app/employee/pages/employee_main_page.dart';

class HomeVM extends BaseViewModel {
  int selectedIndex = 0;

  List<Widget> listPage = [EmployeeMainPage()];

  onChangeIndex(int value) {
    selectedIndex = value;
    notifyListeners();
  }
}
