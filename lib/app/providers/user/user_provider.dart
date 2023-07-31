import 'package:lazyui/lazyui.dart';
import 'package:riverpod/riverpod.dart';

class UserNotifier extends StateNotifier<AsyncValue<List<String>>> {
  UserNotifier() : super(const AsyncValue.loading()) {
    getData();
  }

  final forms = LzForm.make(['name']);

  Future getData({bool isRefreshing = false}) async {
    // Set the state to loading before fetching data
    if (isRefreshing) state = const AsyncValue.loading();

    try {
      await Future.delayed(2.s);
      state = AsyncValue.data(List.generate(3, (i) => Faker.name()));
    } catch (error, st) {
      state = AsyncValue.error(error, st);
    }
  }

  void add(String item) {
    state.whenData((data) {
      data.insert(0, item);
      state = AsyncValue.data(data);
    });
  }

  Future<bool> update(int index) async {
    try {
      final form = LzForm.validate(forms, required: ['name'], notifierType: LzFormNotifier.text);

      if (form.ok) {
        LzToast.overlay('Updating...');
        await Future.delayed(1.s);

        state.whenData((data) {
          data[index] = form.value['name'].toString().ucwords;
          state = AsyncValue.data(data);
        });

        LzToast.show('User has been updated');
        return true;
      }
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      LzToast.dismiss();
    }

    return false;
  }

  void delete(int index) {
    state.whenData((data) => state = AsyncValue.data(data..removeAt(index)));
    LzToast.show('User has been deleted');
  }
}

final userProvider = StateNotifierProvider.autoDispose<UserNotifier, AsyncValue<List<String>>>((ref) {
  return UserNotifier();
});
