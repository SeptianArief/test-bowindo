import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:stacked/stacked.dart';
import 'package:test_bowindo/app/employee/models/employee_model.dart';
import 'package:test_bowindo/app/employee/repository/employee_repository.dart';
import 'package:test_bowindo/shared/api_helper.dart';
import 'package:test_bowindo/shared/form_helper.dart';
import 'package:intl/intl.dart';
import 'package:test_bowindo/shared/single_date_picker.dart';
import 'package:test_bowindo/shared/util/util_cubit.dart';
import 'package:test_bowindo/shared/util/util_model.dart';
import 'package:test_bowindo/shared/util/util_state.dart';
import 'package:test_bowindo/shared/yes_or_no_dialog.dart';

class EmployeeVM extends BaseViewModel {
  int pageStatus = 0;

  TextEditingController searchController = TextEditingController();
  String searchValue = '';

  UtilCubit departementCubit = UtilCubit();
  UtilCubit branchCubit = UtilCubit();
  UtilCubit employeeCubit = UtilCubit();
  UtilCubit detailEmployeeCubit = UtilCubit();

  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController mailController = TextEditingController();
  DateTime? dob;
  Departement? selectedDepartement;
  BranchModel? selectedBranch;

  Employee? currentData;

  onDetail(BuildContext context, Employee data) {
    detailEmployeeCubit.fetchEmployeeDetail(context, id: data.id.toString());
    pageStatus = 2;
    notifyListeners();
  }

  onInit(BuildContext context) {
    departementCubit.fetchDepartement(context);
    branchCubit.fetchBranch(context);
    employeeCubit.fetchEmployee(context);
  }

  onChangeBranch(BranchModel data) {
    selectedBranch = data;
    notifyListeners();
  }

  onDatePicked(BuildContext context) async {
    DateTime? result = await showDialog(
        context: context,
        builder: (context) {
          return const DateSinglePicker();
        });

    if (result != null) {
      dob = result;
      notifyListeners();
    }
  }

  onChangeDepartement(Departement data) {
    selectedDepartement = data;
    notifyListeners();
  }

  onEditEmployee(BuildContext context, Employee data) {
    currentData = data;
    pageStatus = 1;

    nameController.text = data.name;
    addressController.text = data.address;
    mailController.text = data.email;

    UtilState state = departementCubit.state;
    if (state is DepartementLoaded) {
      for (var i = 0; i < state.data.length; i++) {
        if (state.data[i].id == data.departementId) {
          selectedDepartement = state.data[i];
        }
      }
    }

    UtilState stateBranch = branchCubit.state;
    if (stateBranch is BranchLoaded) {
      for (var i = 0; i < stateBranch.data.length; i++) {
        if (stateBranch.data[i].id == data.branchId) {
          selectedBranch = stateBranch.data[i];
        }
      }
    }

    dob = DateFormat('yyyy-MM-dd').parse(data.dob);

    notifyListeners();
  }

  onDeleteEmployee(BuildContext context, Employee data) {
    yesOrNoDialog(context,
            title: 'Hapus Karyawan',
            desc: 'Apakah Anda yakin untuk menghapus data karyawan?')
        .then((value) {
      if (value) {
        EmployeeRepository.deleteEmployee(context, id: data.id.toString())
            .then((valueAPI) {
          if (valueAPI.status == RequestStatus.successRequest) {
            employeeCubit.fetchEmployee(context);

            FormHelper.showSnackbar(context,
                data: 'Berhasil menghapus data karyawan', colors: Colors.green);
          } else {
            FormHelper.showSnackbar(context,
                data: 'Gagal menghapus data karyawan', colors: Colors.orange);
          }
        });
      }
    });
  }

  onCancel() {
    pageStatus = 0;
    notifyListeners();
  }

  onCreateEmployee() {
    pageStatus = 1;
    currentData = null;
    notifyListeners();
  }

  onSearchChanged(String value) {
    searchValue = value;
    notifyListeners();
  }

  List<Employee> dataAfterFilter(List<Employee> data) {
    List<Employee> dataFinal = [];

    data.forEach((element) {
      if (element.name.toLowerCase().contains(searchValue.toLowerCase())) {
        dataFinal.add(element);
      }
    });

    return dataFinal;
  }

  onSaveEmployee(BuildContext context) async {
    EasyLoading.show();

    EmployeeRepository.saveEmployee(context,
            address: addressController.text,
            branchId: selectedBranch!.id.toString(),
            departemenId: selectedDepartement!.id.toString(),
            dob:
                '${dob!.year}-${dob!.month.toString().padLeft(2, '0')}-${dob!.day.toString().padLeft(2, '0')}',
            mail: mailController.text,
            name: nameController.text,
            id: currentData?.id.toString())
        .then((valueAPI) {
      EasyLoading.dismiss();
      if (valueAPI.status == RequestStatus.successRequest) {
        pageStatus = 0;
        employeeCubit.fetchEmployee(context);
        notifyListeners();
        FormHelper.showSnackbar(context,
            data: 'Berhasil menyimpan data karyawan', colors: Colors.green);
      } else {
        FormHelper.showSnackbar(context,
            data: 'Gagal menyimpan data karyawan, mohon coba lagi nanti',
            colors: Colors.orange);
      }
    });
  }
}
