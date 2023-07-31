import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';

import '../../../providers/user/user_provider.dart';

class FormUser extends ConsumerWidget {
  final String? name;
  final int index;
  const FormUser({super.key, this.name, this.index = 0});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(userProvider.notifier);
    notifier.forms.fill({'name': name});

    return Wrapper(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Update User'),
        ),
        body: LzListView(
          children: [
            LzForm.input(label: 'Name', hint: 'Enter your name', model: notifier.forms['name'], autofocus: true),
          ],
        ),
    
        bottomNavigationBar: LzButton(
          text: 'Submit',
          onTap: (state) async {
            bool ok = await notifier.update(index);
            if(ok && context.mounted) context.pop();
          }
        ).theme1(),
      ),
    );
  }
}