import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:flutter/widgets.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../enums/http_method.dart';
import '../utilities/api_constants.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'api_service.g.dart';

/// Whenever flag is change we need to rebuild app
/// flutter pub run build_runner build
/// Also if we mark anything keepAlive then all related provider should be keepAlive

/// With keepAlive
// @Riverpod(keepAlive: true)

/// Without keepAlive (default)
@riverpod
APIService apiService(ApiServiceRef ref) {
  return APIService();
}

class APIService {
  Future<Map<String, dynamic>> callAPI({
    CancelToken? cancelToken,
    required String url,
    required HttpMethod httpMethod,
    dynamic body,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    ///Configuring Base Options
    BaseOptions baseOptions = BaseOptions(
      connectTimeout: const Duration(
        seconds: 30,
      ),
      sendTimeout: const Duration(
        seconds: 30,
      ),
      receiveTimeout: const Duration(
        seconds: 30,
      ),
    );

    if (headers != null && headers.isNotEmpty) {
      baseOptions.headers.addAll(headers);
    }

    Dio dio = Dio(
      baseOptions,
    );

    ///Adding Logger
    dio.interceptors.add(
      PrettyDioLogger(),
    );

    ///Adding Retry
    dio.interceptors.add(
      RetryInterceptor(
        dio: dio,
        logPrint: print,
        retries: 3, // retry count (optional)
        retryDelays: const [
          Duration(seconds: 1), // wait 1 sec before first retry
          Duration(seconds: 2), // wait 2 sec before second retry
          Duration(seconds: 3), // wait 3 sec before third retry
        ],
      ),
    );

    ///Adding Interceptor to handle refresh token
    dio.interceptors.add(
      InterceptorsWrapper(
        onError: (DioError error, ErrorInterceptorHandler handler) async {
          if (error.response?.statusCode == 403 ||
              error.response?.statusCode == 401) {
            ///Refreshing token here
            await _refreshToken();

            ///Retrying failed request which threw the refresh token response
            Response response = await _retry(
              dio,
              error.requestOptions,
            );

            return handler.resolve(response);
          }
          return handler.next(error);
        },
      ),
    );

    switch (httpMethod) {
      case HttpMethod.get:
        try {
          Response response = await dio.get(
            url,
            queryParameters: queryParameters,
            cancelToken: cancelToken,
          );
          return {
            'success': true,
            'data': response.data,
          };
        } on DioError catch (e) {
          return handleDioError(e);
        } on Error catch (_) {
          return {
            'success': false,
            'data': {
              'statusCode': 900,
              'message': kGeneralError,
            }
          };
        }
      case HttpMethod.post:
        try {
          Response response = await dio.post(
            url,
            data: body,
            queryParameters: queryParameters,
            cancelToken: cancelToken,
          );
          return {
            'success': true,
            'data': response.data,
          };
        } on DioError catch (e) {
          return handleDioError(e);
        } on Error catch (_) {
          return {
            'success': false,
            'data': {
              'statusCode': 900,
              'message': kGeneralError,
            }
          };
        }
      case HttpMethod.put:
        try {
          Response response = await dio.put(
            url,
            data: body,
            queryParameters: queryParameters,
            cancelToken: cancelToken,
          );
          return {
            'success': true,
            'data': response.data,
          };
        } on DioError catch (e) {
          return handleDioError(e);
        } on Error catch (_) {
          return {
            'success': false,
            'data': {
              'statusCode': 900,
              'message': kGeneralError,
            }
          };
        }
      case HttpMethod.delete:
        try {
          Response response = await dio.delete(
            url,
            data: body,
            queryParameters: queryParameters,
            cancelToken: cancelToken,
          );
          return {
            'success': true,
            'data': response.data,
          };
        } on DioError catch (e) {
          return handleDioError(e);
        } on Error catch (_) {
          return {
            'success': false,
            'data': {
              'statusCode': 900,
              'message': kGeneralError,
            }
          };
        }
      default:
        return {};
    }
  }

  void cancelCall(CancelToken? cancelToken) {
    try {
      cancelToken!.cancel();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Map<String, dynamic> handleDioError(DioError e) {
    switch (e.type) {
      case DioErrorType.connectionTimeout:
      case DioErrorType.connectionError:
        return {
          'success': false,
          'data': {
            'statusCode': 900,
            'message': kInternetError,
          },
        };
      case DioErrorType.sendTimeout:
        return {
          'success': false,
          'data': {
            'statusCode': 900,
            'message': kInternetError,
          },
        };
      case DioErrorType.receiveTimeout:
        return {
          'success': false,
          'data': {
            'statusCode': 900,
            'message': kGeneralError,
          },
        };
      case DioErrorType.badResponse:
      case DioErrorType.badCertificate:
        return {
          'success': false,
          'data': {
            'statusCode': e.response?.statusCode,
            'message': jsonEncode(e.response?.data),
          },
        };
      case DioErrorType.cancel:
        return {
          'success': false,
          'data': {
            'statusCode': 900,
            'message': null,
          },
        };
      case DioErrorType.unknown:
        return {
          'success': false,
          'data': {
            'statusCode': 900,
            'message': kGeneralError,
          },
        };
    }
  }

  Future<void> _refreshToken() async {
    //TODO: Add refresh token logic here
  }

  Future<Response> _retry(Dio dio, RequestOptions requestOptions) {
    final options = Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
    );
    return dio.request<dynamic>(
      requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      options: options,
    );
  }
}
