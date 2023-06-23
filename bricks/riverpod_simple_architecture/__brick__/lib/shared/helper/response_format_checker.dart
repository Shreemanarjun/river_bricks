import 'package:dio/dio.dart';
import 'package:{{project_name.snakeCase()}}/bootstrap.dart';
import 'package:{{project_name.snakeCase()}}/shared/exception/base_exception.dart';

extension ResponseFormatChecker<T> on Response<T> {
  bool isFormatValid({
    String? key,
  }) {
    if ((statusCode == 200 || statusCode == 201) &&
        data != null &&
        data is Map &&
        (key != null
            ? ((data as Map).containsKey(key) && (data as Map)[key] != null)
            : true)) {
      talker.debug('valid response');
      return true;
    } else {
      talker.debug('invalid response $realUri $statusCode');
      if (statusCode == 401) {
        talker.error("UNauthorized");
      }
      return false;
    }
  }

  APIException getErrorMessage() {
    if (data != null && data is Map && ((data as Map?)?['Message'] != null)) {
      return APIException(
          statusCode: statusCode,
          statusMessage: statusMessage,
          errorMessage: (data as Map?)?['Message']);
    } else {
      return APIException(
        statusCode: statusCode,
        statusMessage: statusMessage,
        errorMessage: data.toString(),
      );
    }
  }
}
