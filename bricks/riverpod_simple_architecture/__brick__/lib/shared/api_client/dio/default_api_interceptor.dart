import 'package:dio/dio.dart';
import 'package:{{project_name.snakeCase()}}/shared/api_client/dio/default_api_error_handler.dart';

class DefaultAPIInterceptor extends Interceptor {
  DefaultAPIInterceptor({
    required this.dio,
  });
  final Dio dio;

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    defaultAPIErrorHandler(err, handler, dio);
  }
}
