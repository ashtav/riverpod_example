part of todo;

class TodoListItem extends ConsumerWidget {
  final Todo todo;
  final int index;
  const TodoListItem({super.key, required this.todo, this.index = 0});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final key = GlobalKey();
    bool completed = todo.completed.orIf();

    return InkTouch(
      onTap: () {
        final options =
            [completed ? 'Uncomplete' : 'Set Complete'].options(icons: [completed ? Ti.x : Ti.checks], dangers: [1]);

        DropX.show(key.context, options: options, onSelect: (state) {
          final notifier = ref.read(todoProvider.notifier);
          notifier.markTodo(todo.id!, completed);
        });
      },
      padding: Ei.sym(v: 20, h: 10),
      border: Br.only(['t'], except: index == 0),
      child: Row(
        mainAxisAlignment: Maa.spaceBetween,
        children: [
          Row(
            children: [
              CustomCheckbox(value: completed),
              Textr(
                todo.todo.orIf(),
                margin: Ei.only(l: 15),
              ).lz.flexible()
            ],
          ).lz.flexible(),
          Icon(Ti.dotsVertical, key: key, color: Colors.black45)
        ],
      ),
    );
  }
}
