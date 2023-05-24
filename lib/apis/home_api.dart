import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../enums/http_method.dart';
import '../models/failure.dart';
import '../models/placeholder_response.dart';
import '../services/api_service.dart';
import '../utilities/api_constants.dart';

part 'home_api.g.dart';

/// Provider is great for accessing dependencies that don't change,
/// such as the repositories in our app.
@riverpod
HomeAPI homeAPI(HomeAPIRef ref) => HomeAPI(
      apiService: ref.watch(apiServiceProvider),
    );

abstract class IHomeAPI {
  Future<List<CustomPlaceholder>> getList({
    CancelToken? cancelToken,
  });
}

class HomeAPI implements IHomeAPI {
  final APIService _apiService;

  HomeAPI({
    required APIService apiService,
  }) : _apiService = apiService;

  @override
  Future<List<CustomPlaceholder>> getList({
    CancelToken? cancelToken,
  }) async {
    final Map<String, dynamic> response = await _apiService.callAPI(
      cancelToken: cancelToken,
      url: kTodosAPI,
      httpMethod: HttpMethod.get,
    );
    if (response['success']) {
      return (response['data'] as List)
          .map((x) => CustomPlaceholder.fromJson(x))
          .toList();
    } else {
      throw Failure.fromJson(response['data']);
    }
  }
}
