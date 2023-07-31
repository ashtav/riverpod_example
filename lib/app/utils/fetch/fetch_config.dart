part of fetch;

const List<int> ignoreErrorStatus = [401, 422];

void onRequest(int statusCode, dynamic data) {
  // do something on request
}

BaseOptions dioOptions({String? baseUrl}) => BaseOptions(
    followRedirects: false,
    baseUrl: AppConfig.baseUrl,
    connectTimeout: const Duration(seconds: 60),
    receiveTimeout: const Duration(seconds: 200),
    headers: {'Accept': 'application/json', 'Content-Type': 'application/json'},
    responseType: ResponseType.plain,
    validateStatus: (status) => status! <= 598);

Dio dio = Dio(dioOptions());
