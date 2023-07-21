import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stacked/stacked.dart';
import 'package:test_bowindo/app/employee/models/employee_model.dart';
import 'package:test_bowindo/app/employee/pages/employee_detail_page.dart';
import 'package:test_bowindo/app/employee/pages/employee_form_page.dart';
import 'package:test_bowindo/app/employee/viewmodel/employee_vm.dart';
import 'package:test_bowindo/shared/form_helper.dart';
import 'package:test_bowindo/shared/style_helper.dart';
import 'package:test_bowindo/shared/util/util_cubit.dart';
import 'package:test_bowindo/shared/util/util_state.dart';

class EmployeeMainPage extends StatelessWidget {
  const EmployeeMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<EmployeeVM>.reactive(viewModelBuilder: () {
      return EmployeeVM();
    }, onViewModelReady: (model) {
      model.onInit(context);
    }, builder: (context, model, child) {
      if (model.pageStatus == 0) {
        return Container(
          width: double.infinity,
          height: double.infinity,
          color: const Color(0xffecf0f4),
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 20),
            children: [
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Karyawan',
                    style: mainFont.copyWith(
                        fontSize: 16,
                        color: Colors.black87,
                        fontWeight: FontWeight.bold),
                  ),
                  InkWell(
                    borderRadius: BorderRadius.circular(4),
                    onTap: () {
                      model.onCreateEmployee();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: Theme.of(context).primaryColor),
                      child: Text(
                        'Tambah Karyawan',
                        style: mainFont.copyWith(
                            fontSize: 12, color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 5,
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(8))),
                    ),
                    Container(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          FormHelper.roundedTextfield(context,
                              controller: model.searchController,
                              onChanged: (value) {
                            model.onSearchChanged(value);
                          },
                              prefixIcon: const Icon(
                                Icons.search,
                                color: Colors.grey,
                              ),
                              hintText: 'Cari Karyawan..'),
                          BlocBuilder<UtilCubit, UtilState>(
                              bloc: model.employeeCubit,
                              builder: (context, state) {
                                if (state is UtilLoading) {
                                  return Container(
                                    alignment: Alignment.center,
                                    margin: const EdgeInsets.only(top: 20),
                                    child: CircularProgressIndicator(
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  );
                                } else if (state is EmployeeLoaded) {
                                  List<Employee> dataFinal =
                                      model.dataAfterFilter(state.data);
                                  return dataFinal.isEmpty
                                      ? Container(
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 40),
                                          alignment: Alignment.center,
                                          child: Text(
                                            'Data Tidak Ditemukan',
                                            style:
                                                mainFont.copyWith(fontSize: 20),
                                          ),
                                        )
                                      : Column(
                                          children: List.generate(
                                              dataFinal.length, (index) {
                                            Employee data = dataFinal[index];
                                            return Container(
                                              margin: const EdgeInsets.only(
                                                  top: 10),
                                              child: Card(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8)),
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.all(20),
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                          child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            data.name,
                                                            style: mainFont.copyWith(
                                                                fontSize: 13,
                                                                color: Colors
                                                                    .black87,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          FormHelper.dataSplit(
                                                              title: 'Branch',
                                                              desc: data
                                                                  .branchName),
                                                          FormHelper.dataSplit(
                                                              title:
                                                                  'Departement',
                                                              desc: data
                                                                  .departementName),
                                                        ],
                                                      )),
                                                      Container(
                                                          margin:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 10),
                                                          child: InkWell(
                                                            onTap: () {
                                                              model.onDetail(
                                                                  context,
                                                                  data);
                                                            },
                                                            child: Container(
                                                              width: 40,
                                                              height: 40,
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                  color: Theme.of(
                                                                          context)
                                                                      .primaryColor),
                                                              child: const Icon(
                                                                Icons
                                                                    .visibility,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                          )),
                                                      Container(
                                                          margin:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 10),
                                                          child: InkWell(
                                                            onTap: () {
                                                              model
                                                                  .onEditEmployee(
                                                                      context,
                                                                      data);
                                                            },
                                                            child: Container(
                                                              width: 40,
                                                              height: 40,
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                  color: Colors
                                                                      .orange),
                                                              child: const Icon(
                                                                Icons.edit,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                          )),
                                                      Container(
                                                          margin:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 10),
                                                          child: InkWell(
                                                            onTap: () {
                                                              model
                                                                  .onDeleteEmployee(
                                                                      context,
                                                                      data);
                                                            },
                                                            child: Container(
                                                              width: 40,
                                                              height: 40,
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                  color: Colors
                                                                      .red),
                                                              child: const Icon(
                                                                Icons.delete,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                          )),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          }),
                                        );
                                } else {
                                  return Container();
                                }
                              })
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 40,
              ),
            ],
          ),
        );
      } else if (model.pageStatus == 1) {
        return EmployeeFormPage(
          model: model,
        );
      } else if (model.pageStatus == 2) {
        return EmployeeDetailPage(model: model);
      } else {
        return Container();
      }
    });
  }
}
