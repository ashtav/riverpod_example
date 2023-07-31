import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';
import 'package:riverpod_example/app/utils/fetch/fetch.dart';

import '../../data/api/api.dart';

final authProvider = ChangeNotifierProvider((ref) => Auth());

class Auth with ChangeNotifier, UseApi {
  final forms = LzForm.make(['username', 'password']);

  Future login() async {
    try {
      final form = LzForm.validate(forms);

      LzToast.overlay('Logging in...');
      ResHandler res = await authApi.login(form.value);

      if (!res.status) {
        return LzToast.show(res.message);
      }

      return LzToast.show('Nice! You are logged in');
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      LzToast.dismiss();
    }
  }
}
