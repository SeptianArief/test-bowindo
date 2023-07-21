import 'package:flutter/material.dart';
import 'package:test_bowindo/app/login/models/user_model.dart';
import 'package:test_bowindo/shared/api_connection.dart';
import 'package:test_bowindo/shared/api_helper.dart';

class AuthRepository {
  static Future<ApiReturnValue> login(
    BuildContext context, {
    required String username,
    required String password,
  }) async {
    ApiReturnValue returnValue;

    Map<String, String> dataBody = {};

    dataBody['user_id'] = username;
    dataBody['user_password'] = password;

    ApiReturnValue<dynamic>? response = await ApiReturnValue.httpPostRequest(
        context,
        dataBody: dataBody,
        url: loginUrl,
        auth: false);

    if (response!.status == RequestStatus.successRequest) {
      returnValue = ApiReturnValue(
          data: UserModel.fromJson(response.data),
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
