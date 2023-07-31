library api;

import 'package:riverpod_example/app/utils/fetch/fetch.dart';

part 'auth_api.dart';
part 'todo_api.dart';

mixin UseApi {
  AuthApi authApi = AuthApi();
  TodoApi todoApi = TodoApi();
}