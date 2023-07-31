import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';

import '../todo/todo.dart';
import '../users/users_view.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: true,
      ),
      body: LzListView(
          children: ['Todo (Fetch Api)', 'User (Static Data)'].generate((item, i) {
        return InkW(
          onTap: () {
            switch (i) {
              case 0:
                context.push(const TodoView());
                break;

              case 1:
                context.push(const UsersView());
                break;
              default:
            }
          },
          padding: Ei.all(20),
          border: Br.only(['t'], except: i == 0),
          child: Row(
            mainAxisAlignment: Maa.spaceBetween,
            children: [Text(item), const Icon(Ti.chevronRight, color: Colors.black45)],
          ),
        );
      })),
    );
  }
}
