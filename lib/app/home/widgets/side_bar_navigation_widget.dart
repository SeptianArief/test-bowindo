import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_bowindo/app/home/viewmodel/home_vm.dart';
import 'package:test_bowindo/app/home/widgets/menu_bar_widget.dart';
import 'package:test_bowindo/app/login/cubits/auth_cubit.dart';
import 'package:test_bowindo/app/login/cubits/auth_state.dart';
import 'package:test_bowindo/app/login/pages/login_page.dart';
import 'package:test_bowindo/shared/style_helper.dart';

class SidebarHomeNavigation extends StatelessWidget {
  final HomeVM model;
  const SidebarHomeNavigation({Key? key, required this.model})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
        bloc: BlocProvider.of<AuthCubit>(context),
        builder: (context, state) {
          return Column(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Selamat Datang,',
                      style: mainFont.copyWith(
                          fontSize: 12, color: Colors.black54),
                    ),
                    state is AuthLoaded
                        ? Text(
                            state.data.name,
                            style: mainFont.copyWith(
                                fontSize: 13, color: Colors.black87),
                          )
                        : Container(),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  children: [
                    MenuBarWidget(
                      icon: Icons.group,
                      index: 0,
                      title: 'Data Karyawan',
                      onTap: (index) {
                        model.onChangeIndex(index);
                      },
                      selectedIndex: model.selectedIndex,
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.all(10),
                child: InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: () {
                    BlocProvider.of<AuthCubit>(context).emit(AuthInitial());

                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (_) => LoginPage()),
                        (route) => false);
                  },
                  child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.red),
                      child: Row(
                        children: [
                          const Icon(Icons.logout, color: Colors.white),
                          const SizedBox(
                            width: 5,
                          ),
                          Expanded(
                              child: Text(
                            'Keluar',
                            style: mainFont.copyWith(
                                fontSize: 12, color: Colors.white),
                          ))
                        ],
                      )),
                ),
              )
            ],
          );
        });
  }
}
