import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:test_bowindo/app/employee/viewmodel/employee_vm.dart';
import 'package:test_bowindo/shared/style_helper.dart';
import 'package:test_bowindo/shared/table_widget_data.dart';
import 'package:test_bowindo/shared/util/util_cubit.dart';
import 'package:test_bowindo/shared/util/util_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmployeeDetailPage extends StatelessWidget {
  final EmployeeVM model;
  const EmployeeDetailPage({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: double.infinity,
        color: const Color(0xffecf0f4),
        child:
            ListView(padding: EdgeInsets.symmetric(horizontal: 20), children: [
          const SizedBox(
            height: 20,
          ),
          Text(
            'Karyawan Detail',
            style: mainFont.copyWith(
                fontSize: 16,
                color: Colors.black87,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8), color: Colors.white),
              child: Column(children: [
                Container(
                  width: double.infinity,
                  height: 5,
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8))),
                ),
                BlocBuilder<UtilCubit, UtilState>(
                    bloc: model.detailEmployeeCubit,
                    builder: (context, state) {
                      if (state is UtilLoading) {
                        return Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.symmetric(vertical: 40),
                          child: CircularProgressIndicator(
                              color: Theme.of(context).primaryColor),
                        );
                      } else if (state is EmployeeDetailLoaded) {
                        return Container(
                            padding: const EdgeInsets.all(20),
                            child: Column(children: [
                              TableWidgetData(
                                  title: 'Nama',
                                  data: Text(
                                    state.data.name,
                                    style: mainFont.copyWith(
                                      fontSize: 16,
                                    ),
                                  )),
                              TableWidgetData(
                                  title: 'Alamat',
                                  data: Text(
                                    state.data.address,
                                    style: mainFont.copyWith(
                                      fontSize: 16,
                                    ),
                                  )),
                              TableWidgetData(
                                  title: 'Tanggal Lahir',
                                  data: Text(
                                    state.data.dob,
                                    style: mainFont.copyWith(
                                      fontSize: 16,
                                    ),
                                  )),
                              TableWidgetData(
                                  title: 'Email',
                                  data: Text(
                                    state.data.email,
                                    style: mainFont.copyWith(
                                      fontSize: 16,
                                    ),
                                  )),
                              TableWidgetData(
                                  title: 'Cabang',
                                  data: Text(
                                    state.data.branchName,
                                    style: mainFont.copyWith(
                                      fontSize: 16,
                                    ),
                                  )),
                              TableWidgetData(
                                  title: 'Departemen',
                                  data: Text(
                                    state.data.departementName,
                                    style: mainFont.copyWith(
                                      fontSize: 16,
                                    ),
                                  ))
                            ]));
                      }
                      return Container();
                    }),
                InkWell(
                  borderRadius: BorderRadius.circular(4),
                  onTap: () {
                    model.onCancel();
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        border:
                            Border.all(color: Theme.of(context).primaryColor)),
                    child: Text(
                      'Kembali',
                      style: mainFont.copyWith(
                          fontSize: 12, color: Theme.of(context).primaryColor),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ]))
        ]));
  }
}
