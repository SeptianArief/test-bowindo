import 'package:flutter/material.dart';
import 'package:test_bowindo/app/login/models/user_model.dart';
import 'package:test_bowindo/shared/api_connection.dart';
import 'package:test_bowindo/shared/api_helper.dart';
import 'package:test_bowindo/shared/util/util_model.dart';

class UtilRepository {
  static Future<ApiReturnValue> fetchDepartement(
    BuildContext context,
  ) async {
    ApiReturnValue returnValue;

    ApiReturnValue<dynamic>? response = await ApiReturnValue.httpGETRequest(
        context,
        url: departementUrl,
        auth: true);

    if (response!.status == RequestStatus.successRequest) {
      returnValue = ApiReturnValue(
          data: List.generate(response.data['data'].length, (index) {
            return Departement.fromJson(response.data['data'][index]);
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

  static Future<ApiReturnValue> fetchBranch(
    BuildContext context,
  ) async {
    ApiReturnValue returnValue;

    ApiReturnValue<dynamic>? response = await ApiReturnValue.httpGETRequest(
        context,
        url: branchUrl,
        auth: true);

    if (response!.status == RequestStatus.successRequest) {
      returnValue = ApiReturnValue(
          data: List.generate(response.data['data'].length, (index) {
            return BranchModel.fromJson(response.data['data'][index]);
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
}
