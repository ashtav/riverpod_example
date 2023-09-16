import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';

import '../../providers/user/user_provider.dart';
import 'widgets/form_user.dart';

class UsersView extends ConsumerWidget {
  const UsersView({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final notifier = ref.read(userProvider.notifier);

    return Scaffold(
        appBar: AppBar(
          title: const Text('RDR2 Characters'),
          actions: [
            const Icon(Ti.reload).onPressed(() {
              notifier.getData(isRefreshing: true);
            }),
            const Icon(Ti.plus).onPressed(() {
              notifier.add(Faker.name());
            })
          ],
        ),
        body: Consumer(
          builder: (context, ref, _) {
            final asyncData = ref.watch(userProvider);

            return asyncData.when(
              data: (users) {
                if (users.isEmpty) {
                  return const LzNoData(message: 'Opps! No data found');
                }

                return Refreshtor(
                  onRefresh: () async => notifier.getData(isRefreshing: true),
                  child: LzListView(
                    children: users.generate((item, i) => ListItem(name: item, index: i)),
                  ),
                );
              },
              loading: () => LzLoader.bar(message: 'Loading...'),
              error: (error, _) => LzNoData(message: 'Opps! $error'),
            );
          },
        ));
  }
}

class ListItem extends ConsumerWidget {
  final String name;
  final int index;
  const ListItem({super.key, required this.name, this.index = 0});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final key = GlobalKey();

    return InkTouch(
      onTap: () {
        final options = ['Edit', 'Delete'].options(options: {
          1: ['Yes, Delete It!', 'Cancel'].options(values: ['Delete'], pops: [1])
        }, icons: [
          Ti.pencil,
          Ti.trash
        ], dangers: [
          1
        ]);

        DropX.show(key.context, options: options, onSelect: (state) {
          final value = state.value;

          if (state.option == 'Edit') {
            context.bottomSheet(FormUser(name: name, index: index));
            return;
          }

          if (value == 'Delete') {
            ref.read(userProvider.notifier).delete(index);
          }
        });
      },
      padding: Ei.all(20),
      border: Br.only(['t'], except: index == 0),
      child: Row(
        mainAxisAlignment: Maa.spaceBetween,
        children: [Text(name), Icon(Ti.dotsVertical, key: key, color: Colors.black45)],
      ),
    );
  }
}
