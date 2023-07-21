import 'package:flutter/material.dart';
import 'package:test_bowindo/app/employee/viewmodel/employee_vm.dart';
import 'package:test_bowindo/shared/form_helper.dart';
import 'package:test_bowindo/shared/style_helper.dart';
import 'package:test_bowindo/shared/table_widget_data.dart';
import 'package:test_bowindo/shared/util/util_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_bowindo/shared/util/util_model.dart';
import 'package:test_bowindo/shared/util/util_state.dart';

class EmployeeFormPage extends StatelessWidget {
  final EmployeeVM model;
  const EmployeeFormPage({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
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
          Text(
            'Karyawan',
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
                      TableWidgetData(
                          title: 'Nama',
                          data: FormHelper.roundedTextfield(context,
                              controller: model.nameController,
                              hintText: 'Nama')),
                      TableWidgetData(
                          title: 'Alamat',
                          data: FormHelper.roundedTextfield(context,
                              controller: model.addressController,
                              maxLines: 5,
                              hintText: 'Alamat')),
                      TableWidgetData(
                          title: 'Email',
                          data: FormHelper.roundedTextfield(context,
                              controller: model.mailController,
                              hintText: 'Email')),
                      TableWidgetData(
                          title: 'Tanggal lahir',
                          data: InkWell(
                            onTap: () {
                              model.onDatePicked(context);
                            },
                            child: FormHelper.dropdownForm(context,
                                data: model.dob == null
                                    ? null
                                    : '${model.dob!.day.toString().padLeft(2, '0')}/${model.dob!.month.toString().padLeft(2, '0')}/${model.dob!.year}',
                                customIcons: Icons.date_range,
                                hintText: 'Tanggal Lahir'),
                          )),
                      BlocBuilder<UtilCubit, UtilState>(
                          bloc: model.departementCubit,
                          builder: (context, state) {
                            if (state is DepartementLoaded) {
                              return TableWidgetData(
                                title: 'Departemen',
                                data: Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: Colors.black45, width: 1)),
                                  child: DropdownButton(
                                      hint: Text(
                                        'Departemen',
                                        style: mainFont.copyWith(
                                            fontSize: 16,
                                            color: Colors.black54),
                                      ),
                                      underline: Container(),
                                      value: model.selectedDepartement,
                                      isExpanded: true,
                                      onChanged: (Departement? value) {
                                        model.onChangeDepartement(value!);
                                      },
                                      items: List.generate(state.data.length,
                                          (index) {
                                        return DropdownMenuItem(
                                          value: state.data[index],
                                          child: Text(state.data[index].name),
                                        );
                                      })),
                                ),
                              );
                            }
                            return Container();
                          }),
                      BlocBuilder<UtilCubit, UtilState>(
                          bloc: model.branchCubit,
                          builder: (context, state) {
                            if (state is BranchLoaded) {
                              return TableWidgetData(
                                title: 'Cabang',
                                data: Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: Colors.black45, width: 1)),
                                  child: DropdownButton(
                                      hint: Text(
                                        'Cabang',
                                        style: mainFont.copyWith(
                                            fontSize: 16,
                                            color: Colors.black54),
                                      ),
                                      underline: Container(),
                                      value: model.selectedBranch,
                                      isExpanded: true,
                                      onChanged: (BranchModel? value) {
                                        model.onChangeBranch(value!);
                                      },
                                      items: List.generate(state.data.length,
                                          (index) {
                                        return DropdownMenuItem(
                                          value: state.data[index],
                                          child: Text(state.data[index].name),
                                        );
                                      })),
                                ),
                              );
                            }
                            return Container();
                          }),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
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
                                  border: Border.all(
                                      color: Theme.of(context).primaryColor)),
                              child: Text(
                                'Batal',
                                style: mainFont.copyWith(
                                    fontSize: 12,
                                    color: Theme.of(context).primaryColor),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          InkWell(
                            borderRadius: BorderRadius.circular(4),
                            onTap: () {
                              model.onSaveEmployee(context);
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: Theme.of(context).primaryColor),
                              child: Text(
                                'Simpan Karyawan',
                                style: mainFont.copyWith(
                                    fontSize: 12, color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 40,
          ),
        ],
      ),
    );
  }
}
