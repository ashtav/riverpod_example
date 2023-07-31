part of api;

class AuthApi extends Fetch {
  Future<ResHandler> login(Map<String, dynamic> data) async => await post('auth/login', data);
}