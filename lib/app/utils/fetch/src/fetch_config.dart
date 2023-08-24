part of fetch;

// manage base url
String _baseUrl = '';

// manage header
Map<String, dynamic> _header = {'Accept': 'application/json', 'Content-Type': 'application/json'};

// manage ignore status
List<int> _ignoreErrorStatus = [401, 422];

// manage request listener
Function(int, dynamic)? _onRequest;

BaseOptions dioOptions({String? baseUrl}) => BaseOptions(
    followRedirects: false,
    baseUrl: _baseUrl,
    connectTimeout: const Duration(seconds: 60),
    receiveTimeout: const Duration(seconds: 200),
    headers: _header,
    responseType: ResponseType.plain,
    validateStatus: (status) => status! <= 598);

Dio dio = Dio(dioOptions());

class UseFetch {
  final String? baseUrl;
  final Map<String, dynamic>? header;
  final List<int>? ignoreStatus;
  final Function(int statusCode, dynamic data)? onRequest;

  UseFetch({this.baseUrl, this.header, this.ignoreStatus, this.onRequest});

  void init() {
    _baseUrl = baseUrl ?? '';
    _header = header ?? {'Accept': 'application/json', 'Content-Type': 'application/json'};
    _ignoreErrorStatus = ignoreStatus ?? [401, 422];
    _onRequest = onRequest;
  }
}
