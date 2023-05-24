import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../enums/http_method.dart';
import '../models/failure.dart';
import '../models/placeholder_response.dart';
import '../services/api_service.dart';
import '../utilities/api_constants.dart';

part 'single_api.g.dart';

/// Whenever flag is change we need to rebuild app
/// flutter pub run build_runner build
/// Also if we mark anything keepAlive then all related provider should be keepAlive

/// With keepAlive
// @Riverpod(keepAlive: true)

/// Without keepAlive (default)
@riverpod
SingleAPI singleAPI(SingleAPIRef ref) => SingleAPI(
      apiService: ref.watch(apiServiceProvider),
    );

abstract class ISingleAPI {
  Future<CustomPlaceholder> getSingle({
    CancelToken? cancelToken,
    required int postId,
  });
}

class SingleAPI implements ISingleAPI {
  final APIService _apiService;

  SingleAPI({
    required APIService apiService,
  }) : _apiService = apiService;

  @override
  Future<CustomPlaceholder> getSingle({
    CancelToken? cancelToken,
    required int postId,
  }) async {
    final Map<String, dynamic> response = await _apiService.callAPI(
      cancelToken: cancelToken,
      url: '$kTodosAPI/$postId',
      httpMethod: HttpMethod.get,
    );
    if (response['success']) {
      CustomPlaceholder customPlaceholders =
          CustomPlaceholder.fromJson(response['data']);
      return customPlaceholders;
    } else {
      throw Failure.fromJson(response['data']);
    }
  }
}
