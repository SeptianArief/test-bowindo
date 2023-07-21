// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:test_bowindo/app/login/cubits/auth_cubit.dart';
import 'package:test_bowindo/app/login/cubits/auth_state.dart';
import 'package:test_bowindo/shared/form_helper.dart';

class ApiReturnValue<T> {
  T data;
  RequestStatus status;

  ApiReturnValue({required this.data, required this.status});

  static Future<ApiReturnValue<dynamic>?> httpPostRequest(BuildContext context,
      {required Object dataBody,
      required String url,
      List<int>? exceptionStatusCode,
      Map<String, String>? dataHeader,
      String? customToken,
      bool? auth}) async {
    ApiReturnValue<dynamic>? returnValue;
    bool authHeader = auth ?? true;

    Map<String, String> headerMap = dataHeader ??
        {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
        };

    if (authHeader) {
      AuthState state = BlocProvider.of<AuthCubit>(context).state;
      if (state is AuthLoaded) {
        headerMap['token'] = state.data.token;
      }
    }

    print("POST Request to:");
    print(url);
    print('Header : $headerMap');
    log('Body : $dataBody ');

    print('----------------------------------------------------');

    try {
      final response = await http.post(Uri.parse(url),
          body: json.encode(dataBody), headers: headerMap);
      var data = json.decode(response.body);
      print(response.statusCode);
      print(data);

      if (response.statusCode != 200) {
        if (response.statusCode == 401 &&
            (exceptionStatusCode == null ||
                !exceptionStatusCode.contains(401))) {
          returnValue =
              ApiReturnValue(data: null, status: RequestStatus.failedRequest);
          // BlocProvider.of<AuthCubit>(context).logout(context);
          FormHelper.showSnackbar(
            context,
            colors: Colors.orange,
            data: 'Sesi Habis, Mohon Login Kembali',
          );
        } else if (exceptionStatusCode != null) {
          if (exceptionStatusCode.contains(response.statusCode)) {
            returnValue = ApiReturnValue(
                status: RequestStatus.successRequest, data: data);
          } else {
            returnValue =
                ApiReturnValue(data: data, status: RequestStatus.failedRequest);
          }
        } else {
          returnValue =
              ApiReturnValue(data: data, status: RequestStatus.failedRequest);
        }
      } else {
        returnValue =
            ApiReturnValue(status: RequestStatus.successRequest, data: data);
      }
    } on SocketException {
      log('internet');
      returnValue =
          ApiReturnValue(data: null, status: RequestStatus.internetIssue);
    } catch (e) {
      log(e.toString());
      returnValue =
          ApiReturnValue(status: RequestStatus.serverError, data: null);
    }

    return returnValue;
  }

  static Future<ApiReturnValue<dynamic>?> httpGETRequest(BuildContext context,
      {required String url,
      List<int>? exceptionStatusCode,
      Map<String, String>? dataHeader,
      String? customToken,
      bool? auth}) async {
    ApiReturnValue<dynamic>? returnValue;
    bool authHeader = auth ?? true;

    Map<String, String> headerMap = dataHeader ??
        {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
        };

    if (authHeader) {
      AuthState state = BlocProvider.of<AuthCubit>(context).state;
      if (state is AuthLoaded) {
        headerMap['token'] = state.data.token;
      }
    }

    print("GET Request to:");
    print(url);
    print('Header : $headerMap');

    print('----------------------------------------------------');

    try {
      final response = await http.get(Uri.parse(url), headers: headerMap);
      var data = json.decode(response.body);
      print(response.statusCode);
      print(data);

      if (response.statusCode != 200) {
        if (response.statusCode == 401 &&
            (exceptionStatusCode == null ||
                !exceptionStatusCode.contains(401))) {
          returnValue =
              ApiReturnValue(data: null, status: RequestStatus.failedRequest);
          // BlocProvider.of<AuthCubit>(context).logout(context);
          FormHelper.showSnackbar(
            context,
            colors: Colors.orange,
            data: 'Sesi Habis, Mohon Login Kembali',
          );
        } else if (exceptionStatusCode != null) {
          if (exceptionStatusCode.contains(response.statusCode)) {
            returnValue = ApiReturnValue(
                status: RequestStatus.successRequest, data: data);
          } else {
            returnValue =
                ApiReturnValue(data: data, status: RequestStatus.failedRequest);
          }
        } else {
          returnValue =
              ApiReturnValue(data: data, status: RequestStatus.failedRequest);
        }
      } else {
        returnValue =
            ApiReturnValue(status: RequestStatus.successRequest, data: data);
      }
    } on SocketException {
      returnValue =
          ApiReturnValue(data: null, status: RequestStatus.internetIssue);
    } catch (e) {
      print(e);
      returnValue =
          ApiReturnValue(status: RequestStatus.serverError, data: null);
    }

    return returnValue;
  }
}

enum RequestStatus {
  successRequest,
  failedRequest,
  failedParsing,
  serverError,
  internetIssue
}
