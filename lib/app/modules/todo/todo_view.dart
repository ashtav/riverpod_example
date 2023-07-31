part of todo;

class TodoView extends ConsumerWidget {
  const TodoView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(todoProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo'),
        centerTitle: true,
        actions: [
          const Icon(Ti.userEdit).onPressed(() {
            notifier.setName();
          }),

          todoProvider.watch<bool>((value) {
            return IconButton(
              icon: const Icon(Ti.checks),
              onPressed: !value
                  ? null
                  : () {
                      notifier.markTodo(0, true);
                    },
            ).opacity(value ? 1 : .3);
          }),

          // Consumer(
          //   builder: (context, ref, _) {
          //     final asyncData = ref.watch(todoProvider);
          //     return Opacity(
          //       opacity: asyncData.maybeWhen(
          //         data: (_) => 1,
          //         orElse: () => .5,
          //       ),
          //       child: IconButton(
          //         icon: const Icon(Ti.checks),
          //         onPressed: asyncData.maybeWhen(
          //           data: (_) => () {/* your function here */},
          //           orElse: () => null,
          //         ),
          //       ),
          //     );
          //   },
          // ),
        ],
      ),
      body: Consumer(
        builder: (context, ref, _) {
          final asyncData = ref.watch(todoProvider);

          return asyncData.when(
            data: (todos) {
              if (todos.isEmpty) {
                return LzNoData(message: 'Opps! No data found', onTap: () => notifier.getTodo());
              }

              return Refreshtor(
                onRefresh: () async => notifier.getTodo(),
                child: LzListView(
                  children: todos.generate((item, i) => TodoListItem(todo: item, index: i)),
                ),
              );
            },
            loading: () => Loader.bar(message: 'Loading...'),
            error: (error, _) => LzNoData(message: 'Opps! $error'),
          );
        },
      ),
      bottomNavigationBar: Container(
          padding: Ei.all(20),
          decoration: BoxDecoration(color: Colors.white, border: Br.only(['t'])),
          child: appStateProvider.watch((value) {
            return Text('Generated: ${value.randomName}');
          })

          // NOTE: This is the same as above, just a different way of writing it
          // Consumer(builder: (context, ref, _) {
          //   final appState = ref.watch(appStateProvider);
          //   return Text('Generated: ${appState.randomName}');
          // })

          ),
    );
  }
}
