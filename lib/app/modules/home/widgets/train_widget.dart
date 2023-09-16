import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';

final counterStateProvider = StateProvider<int>((ref) => 0);

class TrainWidget extends ConsumerWidget {
  const TrainWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final value = ref.watch(counterStateProvider);

    return Column(
      mainAxisAlignment: Maa.center,
      children: [
        Container(
          margin: Ei.only(b: 25),
          child: Row(
            mainAxisSize: Mas.min,
            children: [
              Text(
                'Counter: $value',
                style: Gfont.fs(25),
              )
            ],
          ),
        ),
        Wrap(
          children: ['32', '15', '45', '29', '41'].generate((item, i) {
            return InkTouch(
              onTap: () {},
              padding: Ei.all(20),
              color: Colors.black12,
              margin: Ei.sym(h: 3),
              radius: Br.radius(7),
              child: Text(item, style: Gfont.bold),
            );
          }),
        )
      ],
    );
  }
}
