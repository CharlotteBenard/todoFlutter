import 'package:dio/dio.dart';
import 'package:repo_bookstore_flutter/shared/api/api_repository_interface.dart';
import 'package:riverpod/riverpod.dart';

final apiRepositoryProvider = Provider<IApiRepository>((ref) => Api());

class Api extends IApiRepository {
  final Dio api = Dio();
  String? accessToken;

  Api() {
    api.options.baseUrl = 'http://localhost:3031/';
    api.interceptors
        .add(InterceptorsWrapper(onRequest: (options, handler) async {
      options.headers['Authorization'] = 'Bearer $accessToken';
      return handler.next(options);
    }, onError: (DioError error, handler) async {
      // todo: will finish this
      return handler.next(error);
    }));
  }

  @override
  Future<Response> get(String requestUri) async {
    return await api.get(requestUri);
  }

  @override
  Future<Response> post(String requestUri, Map<String, dynamic> data) async {
    return await api.post(requestUri, data: data);
  }

  @override
  Future<Response> put(String requestUri, Map<String, dynamic> data) async {
    return await api.put(requestUri, data: data);
  }

  @override
  Future<Response> delete(String requestUri) async {
    return await api.delete(requestUri);
  }
}
