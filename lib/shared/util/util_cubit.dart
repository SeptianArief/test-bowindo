import 'package:flutter/material.dart';
import 'package:test_bowindo/app/employee/repository/employee_repository.dart';
import 'package:test_bowindo/shared/api_helper.dart';
import 'package:test_bowindo/shared/util/util_repository.dart';
import 'package:test_bowindo/shared/util/util_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UtilCubit extends Cubit<UtilState> {
  UtilCubit() : super(UtilInitial());

  fetchBranch(BuildContext context) {
    emit(UtilLoading());
    UtilRepository.fetchBranch(context).then((value) {
      if (value.status == RequestStatus.successRequest) {
        emit(BranchLoaded(value.data));
      } else {
        emit(UtilFailed(value));
      }
    });
  }

  fetchDepartement(BuildContext context) {
    emit(UtilLoading());
    UtilRepository.fetchDepartement(context).then((value) {
      if (value.status == RequestStatus.successRequest) {
        emit(DepartementLoaded(value.data));
      } else {
        emit(UtilFailed(value));
      }
    });
  }

  fetchEmployee(BuildContext context) {
    emit(UtilLoading());
    EmployeeRepository.fetchEmployee(context).then((value) {
      if (value.status == RequestStatus.successRequest) {
        emit(EmployeeLoaded(value.data));
      } else {
        emit(UtilFailed(value));
      }
    });
  }

  fetchEmployeeDetail(BuildContext context, {required String id}) {
    emit(UtilLoading());
    EmployeeRepository.detailEmployee(context, id: id).then((value) {
      if (value.status == RequestStatus.successRequest) {
        emit(EmployeeDetailLoaded(value.data));
      } else {
        emit(UtilFailed(value));
      }
    });
  }
}
