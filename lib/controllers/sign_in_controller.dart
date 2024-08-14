import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/config/app_info.dart';
import 'package:myapp/config/enums.dart';
import 'package:myapp/config/session.dart';
import 'package:myapp/datasources/user_datasource.dart';

class SignInController extends GetxController {
  clear() {
    Get.delete<SignInController>(force: true);
  }

  final edtEmail = TextEditingController();
  final edtPassword = TextEditingController();

  final _loading = false.obs;
  bool get loading => _loading.value;
  set loading(bool n) => _loading.value = n;

  excecute(BuildContext context) {
    if (edtEmail.text == '') {
      AppInfo.failed(context, 'Email wajib diisi');
      return;
    }
    if (!GetUtils.isEmail(edtEmail.text)) {
      AppInfo.failed(context, 'Email tidak valid');
      return;
    }
    if (edtPassword.text == '') {
      AppInfo.failed(context, 'Password wajib diisi');
      return;
    }
    if (edtPassword.text.length < 8) {
      AppInfo.failed(context, 'Password minimal 8 karakter');
      return;
    }

    loading = true;
    UserDatasource.signIn(
      edtEmail.text,
      edtPassword.text,
    ).then((value) {
      loading = false;
      value.fold(
        (message) {
          AppInfo.failed(context, message);
        },
        (data) {
          AppSession.setUser(data);
          AppInfo.success(context, 'Berhasil');
          Navigator.pushReplacementNamed(context, AppRoute.dashboard.name);
        },
      );
    });
  }
}
