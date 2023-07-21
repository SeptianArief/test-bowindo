import 'package:flutter/material.dart';
import 'package:test_bowindo/app/employee/models/employee_model.dart';
import 'package:test_bowindo/shared/api_connection.dart';
import 'package:test_bowindo/shared/api_helper.dart';

class EmployeeRepository {
  static Future<ApiReturnValue> fetchEmployee(
    BuildContext context,
  ) async {
    ApiReturnValue returnValue;

    ApiReturnValue<dynamic>? response = await ApiReturnValue.httpGETRequest(
        context,
        url: employeeListUrl,
        auth: true);

    if (response!.status == RequestStatus.successRequest) {
      returnValue = ApiReturnValue(
          data: List.generate(response.data['data'].length, (index) {
            return Employee.fromJson(response.data['data'][index]);
          }),
          status: RequestStatus.successRequest);
    } else {
      String? messages;
      try {
        messages = response.data['message'];
      } catch (e) {}
      returnValue = ApiReturnValue(data: messages, status: response.status);
    }

    return returnValue;
  }

  static Future<ApiReturnValue> deleteEmployee(BuildContext context,
      {required String id}) async {
    ApiReturnValue returnValue;

    ApiReturnValue<dynamic>? response = await ApiReturnValue.httpPostRequest(
        context,
        url: employeeDeleteUrl,
        dataBody: {'employee_id': id},
        auth: true);

    if (response!.status == RequestStatus.successRequest) {
      returnValue =
          ApiReturnValue(data: null, status: RequestStatus.successRequest);
    } else {
      String? messages;
      try {
        messages = response.data['message'];
      } catch (e) {}
      returnValue = ApiReturnValue(data: messages, status: response.status);
    }

    return returnValue;
  }

  static Future<ApiReturnValue> saveEmployee(BuildContext context,
      {String? id,
      required String name,
      required String address,
      required String mail,
      required String dob,
      required String departemenId,
      required String branchId}) async {
    ApiReturnValue returnValue;

    ApiReturnValue<dynamic>? response =
        await ApiReturnValue.httpPostRequest(context,
            url: id == null ? addEmployeeUrl : updateEmmployeeUrl,
            dataBody: id == null
                ? {
                    "employee_name": name,
                    "employee_address": address,
                    "employee_mail": mail,
                    "employee_dob": dob,
                    "department_id": departemenId,
                    "branch_id": branchId
                  }
                : {
                    "employee_id": id,
                    "employee_name": name,
                    "employee_address": address,
                    "employee_mail": mail,
                    "employee_dob": dob,
                    "department_id": departemenId,
                    "branch_id": branchId
                  },
            auth: true);

    if (response!.status == RequestStatus.successRequest) {
      returnValue =
          ApiReturnValue(data: null, status: RequestStatus.successRequest);
    } else {
      String? messages;
      try {
        messages = response.data['message'];
      } catch (e) {}
      returnValue = ApiReturnValue(data: messages, status: response.status);
    }

    return returnValue;
  }

  static Future<ApiReturnValue> detailEmployee(BuildContext context,
      {required String id}) async {
    ApiReturnValue returnValue;

    ApiReturnValue<dynamic>? response = await ApiReturnValue.httpGETRequest(
        context,
        url: "$detailEmployeeUrl?employee_id=$id",
        auth: true);

    if (response!.status == RequestStatus.successRequest) {
      returnValue = ApiReturnValue(
          data: Employee.fromJson(response.data['data']),
          status: RequestStatus.successRequest);
    } else {
      String? messages;
      try {
        messages = response.data['message'];
      } catch (e) {}
      returnValue = ApiReturnValue(data: messages, status: response.status);
    }

    return returnValue;
  }
}
