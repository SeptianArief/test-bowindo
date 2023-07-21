import 'package:equatable/equatable.dart';
import 'package:test_bowindo/app/employee/models/employee_model.dart';
import 'package:test_bowindo/app/login/models/user_model.dart';
import 'package:test_bowindo/shared/api_helper.dart';
import 'package:test_bowindo/shared/util/util_model.dart';

abstract class UtilState extends Equatable {
  const UtilState();

  @override
  List<Object> get props => [];
}

class UtilInitial extends UtilState {}

class UtilLoading extends UtilState {}

class UtilFailed extends UtilState {
  final ApiReturnValue data;

  const UtilFailed(this.data);

  @override
  List<Object> get props => [data];
}

class DepartementLoaded extends UtilState {
  final List<Departement> data;

  const DepartementLoaded(this.data);

  @override
  List<Object> get props => [data];
}

class BranchLoaded extends UtilState {
  final List<BranchModel> data;

  const BranchLoaded(this.data);

  @override
  List<Object> get props => [data];
}

class EmployeeLoaded extends UtilState {
  final List<Employee> data;

  const EmployeeLoaded(this.data);

  @override
  List<Object> get props => [data];
}

class EmployeeDetailLoaded extends UtilState {
  final Employee data;

  const EmployeeDetailLoaded(this.data);

  @override
  List<Object> get props => [data];
}
