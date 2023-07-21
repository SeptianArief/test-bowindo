import 'package:flutter/material.dart';
import 'package:test_bowindo/app/login/viewmodel/login_vm.dart';
import 'package:test_bowindo/shared/form_helper.dart';
import 'package:test_bowindo/shared/style_helper.dart';
import 'package:stacked/stacked.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginVM>.reactive(viewModelBuilder: () {
      return LoginVM();
    }, builder: (context, model, child) {
      return Scaffold(
        body: Center(
          child: Container(
            width: 700,
            height: 400,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.white),
            child: Row(
              children: [
                Flexible(
                  flex: 6,
                  child: Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 400,
                        decoration: const BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                bottomLeft: Radius.circular(10))),
                        alignment: Alignment.center,
                        child: Text(
                          'Test Demo Bowindo',
                          style: mainFont.copyWith(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  flex: 4,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Login',
                          style: mainFont.copyWith(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        FormHelper.titleWithWidget(
                            title: 'Username',
                            validation: model.usernameValidation,
                            widget: FormHelper.roundedTextfield(context,
                                hintText: 'Username', onChanged: (value) {
                              model.usernameValidationChanged(value);
                            }, controller: model.usernameController)),
                        const SizedBox(
                          height: 10,
                        ),
                        FormHelper.titleWithWidget(
                            title: 'Password',
                            validation: model.passwordValidation,
                            widget: FormHelper.roundedTextfield(context,
                                obscureText: !model.passwordShow,
                                suffixWidget: InkWell(
                                    onTap: () {
                                      model.onChangedPasswordVisibility();
                                    },
                                    child: Icon(
                                      model.passwordShow
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: model.passwordShow
                                          ? Theme.of(context).primaryColor
                                          : Colors.grey,
                                    )),
                                hintText: 'Password', onChanged: (value) {
                              model.passwordValidationChanged(value);
                            }, controller: model.passwordController)),
                        const SizedBox(
                          height: 30,
                        ),
                        FormHelper.fillButton(context, onTap: () {
                          model.onLogin(context);
                        }, title: "Masuk"),
                        const SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
