import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';
import 'package:riverpod_example/app/core/extension.dart';
import 'package:riverpod_example/app/utils/fetch/fetch.dart';

import '../../data/api/api.dart';
import '../../data/models/todo_model.dart';
import '../appstate/appstate_provider.dart';

class TodoNotifier extends StateNotifier<AsyncValue<List<Todo>>> with UseApi {
  final AppState appState;
  final AutoDisposeStateNotifierProviderRef? ref; // if you want to use ref inside this provider

  TodoNotifier({required this.appState, this.ref}) : super(const AsyncValue.loading()) {
    getTodo();
  }

  // if you want to access another provider inside this provider
  void setName() {
    appState.setName(Faker.name());
  }

  Future getTodo() async {
    try {
      state = const AsyncValue.loading();

      ResHandler res = await todoApi.getTodo();
      // List data = res.body?['todos'] ?? [];
      // state = AsyncValue.data(data.map((e) => Todo.fromJson(e)).toList());
      List data = res.data['todos'] ?? [];
      logg(res.message);

      state = AsyncValue.data(data.map((e) => Todo.fromJson(e)).toList());
    } catch (e, s) {
      Errors.check(e, s);
      state = const AsyncValue.data([]);

      // state = AsyncValue.error(e, s); // Use this if you want to show error message on screen
    }
  }

  Future markTodo(int id, bool value) async {
    try {
      if(id == 0) {
        // mark all todo
        state.whenData((data) {
          data = data.map((e) => Todo.fromJson(e.toJson()..['completed'] = value)).toList();
          state = AsyncValue.data(data);
        });

        return;
      }

      // find the index of the todo
      // Todo todo = (state.value ?? []).firstWhere((e) => e.id == id, orElse: () => Todo());

       // shorter way to find the todo, don't need to check if state.value is null or not
      Todo todo = state.value.find((e) => e.id == id, () => Todo());

      if (todo.id != null) {
        state.whenData((data) {
          // todo = Todo.fromJson(todo.toJson()..['completed'] = !value);
          // final index = data.indexWhere((element) => element.id == id);
          // data[index] = todo;

          // or you can use this way, `updateWhere` is a helper function from `lazyui`
          data.updateWhere((e) => e.id == id, (todos, i) {
            todos[i] = Todo.fromJson(todos[i].toJson()..['completed'] = !value);
          });

          state = AsyncValue.data(data);
        });
      } else {
        LzToast.show('Todo not found');
      }
    } catch (e, s) {
      Errors.check(e, s);
    }
  }
}

final todoProvider = StateNotifierProvider.autoDispose<TodoNotifier, AsyncValue<List<Todo>>>((ref) {
  ref.onDispose(() {
    logg('--- todoProvider disposed');
  });

  return TodoNotifier(appState: ref.read(appStateProvider.notifier), ref: ref);
});