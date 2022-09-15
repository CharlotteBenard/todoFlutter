import 'package:dio/dio.dart';

abstract class IApiRepository {
  Future<Response> get(String requestUri);
  Future<Response> post(String requestUri, Map<String, dynamic> data);
  Future<Response> put(String requestUri, Map<String, dynamic> data);
  Future<Response> delete(String requestUri);
}
