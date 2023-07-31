import 'package:hooks_riverpod/hooks_riverpod.dart';

class AppState extends StateNotifier<AppStateModel> {
  AppState() : super(AppStateModel());

  void toggleSearch(bool value) {
    state = state.copyWith(isSearch: value);
  }

  void toggleMarked(bool value) {
    state = state.copyWith(isMarked: value);
  }

  void toggleLogged(bool value) {
    state = state.copyWith(isLogged: value);
  }

  void setName(String value) {
    state = state.copyWith(randomName: value);
  }
}

class AppStateModel {
  final bool isSearch;
  final bool isMarked;
  final bool isLogged;
  final String randomName;

  AppStateModel({this.isSearch = false, this.isMarked = false, this.isLogged = false, this.randomName = 'John Doe'});

  AppStateModel copyWith({
    bool? isSearch,
    bool? isMarked,
    bool? isLogged,
    String? randomName,
  }) {
    return AppStateModel(
      isSearch: isSearch ?? this.isSearch,
      isMarked: isMarked ?? this.isMarked,
      isLogged: isLogged ?? this.isLogged,
      randomName: randomName ?? this.randomName,
    );
  }
}

final appStateProvider = StateNotifierProvider<AppState, AppStateModel>((ref) {
  return AppState();
});
