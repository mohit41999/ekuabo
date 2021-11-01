import 'package:dio/dio.dart';
import 'package:ekuabo/network/dio_logger.dart';
import 'package:ekuabo/network/http_exception.dart';
import 'package:ekuabo/network/service/http_service.dart';

class HttpServiceImpl implements HttpService {
  var TAG = "HttpServiceImpl";
  // var  URL="https://www.ekuabo.notioninfosoft.com/";
  var URL = "https://eku-abo.com/";

  /// BASE URL
  // var BASE_URL="https://www.ekuabo.notioninfosoft.com/api/";
  var BASE_URL = "https://eku-abo.com/api/";

  ///Api Token
  var TOKEN = "123456789";

  DioError _dioError;
  Dio _dio;
  @override
  Future<Response> getRequest(
      String endpoint, Map<String, dynamic> param) async {
    Response response;
    try {
      param['token'] = TOKEN;
      response = await _dio.get(endpoint, queryParameters: param);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");

      Map<String, dynamic> map = _dioError.response.data;
      if (_dioError.response.statusCode == 500) {
        throwIfNoSuccess(map['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }

    return response;
  }

  void throwIfNoSuccess(String response) {
    throw HttpException(response);
  }

  initializeInterceptors() {
    _dio.interceptors
        .add(InterceptorsWrapper(onRequest: (options, handler) async {
      options.headers = {
        'Content-Type': 'multipart/form-data',
        'Accept': 'application/json',
      };
      DioLogger.onSend(TAG, options);
      return handler.next(options);
    }, onError: (error, handler) {
      _dioError = error;
      DioLogger.onError(TAG, error);
      return handler.next(error);
    }, onResponse: (response, handler) {
      DioLogger.onSuccess(TAG, response);
      return handler.next(response);
    }));
  }

  @override
  void init() {
    BaseOptions dioOptions = BaseOptions()..baseUrl = BASE_URL;
    _dio = Dio(dioOptions);

    initializeInterceptors();
  }

//post changes 2
  @override
  Future<Response> postRequest(
      String endpoint, Map<String, dynamic> param) async {
    Response response;
    try {
      param['token'] = TOKEN;
      response = await _dio.post(endpoint, data: FormData.fromMap(param));
    } catch (error, stacktrace) {
      print("Exception occur: $error stackTrace: $stacktrace");

      Map<String, dynamic> map = _dioError.response.data;
      if (_dioError.response.statusCode == 500) {
        throwIfNoSuccess(map['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }

    return response;
  }
}
