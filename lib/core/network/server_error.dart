import 'package:dio/dio.dart' hide Headers;

class ServerError implements Exception {
  int _errorCode;
  String _errorMessage = "";

  ServerError.withError({DioError error}) {
    _handleError(error);
  }

  getErrorCode() {
    return _errorCode;
  }

  getErrorMessage() {
    return _errorMessage;
  }

  _handleError(DioError error) {
    switch (error.type) {
      case DioErrorType.CANCEL:
        _errorMessage = "Request to API server was cancelled";
        break;
      case DioErrorType.CONNECT_TIMEOUT:
        _errorMessage = "Connection timeout with API server";
        break;
      case DioErrorType.DEFAULT:
        _errorMessage =
            "Connection to API server failed due to internet connection";
        break;
      case DioErrorType.RECEIVE_TIMEOUT:
        _errorMessage = "Receive timeout in connection with API server";
        break;
      case DioErrorType.RESPONSE:
        _errorMessage =
            "Received invalid status code: ${error.response.statusCode}";
        break;
      case DioErrorType.SEND_TIMEOUT:
        _errorMessage = "Receive timeout in send request";
        break;
    }
    /*} else {
      _errorMessage = "Unexpected error occured";
    }*/
    return _errorMessage;
  }
}
