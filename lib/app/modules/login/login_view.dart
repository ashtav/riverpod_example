import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';

import '../../providers/auth/auth_provider.dart';

class LoginView extends ConsumerWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.read(authProvider.notifier);
    final forms = auth.forms;

    // set autofill
    forms.fill({'username': 'kminchelle', 'password': '0lelplR'});

    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 360,
          child: LzListView(
            shrinkWrap: true,
            scrollLimit: const [20],
            children: [
              LzFormGroup(
                children: [
                  LzForm.input(label: 'Useraname', hint: 'Type your username', model: forms['username']),
                  LzForm.input(
                      label: 'Password', hint: 'Type your password', obsecureToggle: true, model: forms['password']),
                ],
              ),
              LzButton(
                  text: 'Login',
                  onTap: (state) {
                    auth.login();
                  })
            ],
          ),
        ),
      ),
    );
  }
}
