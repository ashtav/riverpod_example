library fetch;

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:lazyui/lazyui.dart' hide Response, MultipartFile;

part 'extension.dart';
part 'fetch_config.dart';
part 'response_handler.dart';

abstract class Fetch extends ResHandler {
  Future<ResHandler> _fetch(String method, String path,
      {Map<String, dynamic>? query, dynamic data, Function(int, int)? onReceiveProgress}) async {
    ResHandler result = ResHandler(status: false);
    Stopwatch stopWatch = Stopwatch();

    try {
      stopWatch.start();
      Response response = await dio.fetch(RequestOptions(
          baseUrl: dio.options.baseUrl,
          method: method,
          path: path,
          queryParameters: query,
          data: data,
          onReceiveProgress: onReceiveProgress,
          followRedirects: dio.options.followRedirects,
          connectTimeout: dio.options.connectTimeout,
          receiveTimeout: dio.options.receiveTimeout,
          headers: dio.options.headers,
          responseType: dio.options.responseType,
          validateStatus: dio.options.validateStatus));

      stopWatch.stop();
      result = await check(response, stopWatch.elapsed.inMilliseconds, onRequest: (status, data) {
        _onRequest?.call(status, data);
      });
    } catch (e, s) {
      Errors.check(e, s);
    } finally {}

    return result;
  }

  /// ``` dart
  /// ResHandler res = await get('user');
  /// ```

  Future<ResHandler> get(String path,
      {Map<String, dynamic>? query, Options? options, Function(int, int)? onReceiveProgress}) async {
    return await _fetch('GET', path, query: query, onReceiveProgress: onReceiveProgress);
  }

  /// ``` dart
  /// ResHandler res = await post('user', {'name': 'John Doe'});
  /// ```

  Future<ResHandler> post(String path, dynamic data, {bool useFormData = false}) async =>
      await _fetch('POST', path, data: useFormData ? FormData.fromMap(data) : data);

  /// ``` dart
  /// ResHandler res = await put('user/1', {'name': 'John Doe'});
  /// ```

  Future<ResHandler> put(String path, dynamic data, {bool useFormData = false}) async =>
      await _fetch('PUT', path, data: useFormData ? FormData.fromMap(data) : data);

  /// ``` dart
  /// ResHandler res = await delete('user/1');
  /// ```

  Future<ResHandler> delete(String path) async => await _fetch('DELETE', path);

  /// ``` dart
  /// String path = '/storage/emulated/0/Download/1.jpg';
  /// final file = await toFile(path);
  /// ```

  Future<MultipartFile> toFile(String path) async {
    return await MultipartFile.fromFile(path);
  }
}
