import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stacked/stacked.dart';
import 'package:string_validator/string_validator.dart';
import 'package:crypto/crypto.dart';
import 'package:test_bowindo/app/home/pages/home_page.dart';
import 'package:test_bowindo/app/login/cubits/auth_cubit.dart';
import 'package:test_bowindo/app/login/cubits/auth_state.dart';
import 'package:test_bowindo/app/login/repository/auth_repository.dart';
import 'package:test_bowindo/shared/api_helper.dart';
import 'package:test_bowindo/shared/form_helper.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class LoginVM extends BaseViewModel {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool passwordShow = false;

  onChangedPasswordVisibility() {
    passwordShow = !passwordShow;
    notifyListeners();
  }

  String? usernameValidation;
  String? passwordValidation;

  passwordValidationChanged(String value) {
    if (value.isEmpty) {
      passwordValidation = 'Mohon mengisi password';
    } else {
      if (value.length < 8) {
        passwordValidation = 'Password minimal 8 karakter';
      } else {
        passwordValidation = null;
      }
    }

    notifyListeners();
  }

  usernameValidationChanged(String value) {
    if (value.isEmpty) {
      usernameValidation = 'Mohon mengisi Username Anda';
    } else {
      usernameValidation = null;
    }

    notifyListeners();
  }

  onLogin(BuildContext context) {
    usernameValidationChanged(usernameController.text);
    passwordValidationChanged(passwordController.text);

    if (passwordValidation == null && usernameValidation == null) {
      var base64Password = utf8.encode(passwordController.text);
      var encryptedPassword = sha256.convert(base64Password);

      EasyLoading.show();
      AuthRepository.login(context,
              username: usernameController.text,
              password: encryptedPassword.toString())
          .then((value) {
        EasyLoading.dismiss();
        if (value.status == RequestStatus.successRequest) {
          BlocProvider.of<AuthCubit>(context).emit(AuthLoaded(value.data));
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => HomePage()));
          FormHelper.showSnackbar(context,
              data: 'Berhasil Login', colors: Colors.green);
        } else {
          FormHelper.showSnackbar(context,
              data: value.data ?? 'Gagal Login', colors: Colors.orange);
        }
      });
    } else {
      FormHelper.showSnackbar(context,
          data: 'Mohon perbaiki isian Anda', colors: Colors.orange);
    }
  }
}
