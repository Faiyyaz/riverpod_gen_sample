import 'package:flutter/cupertino.dart';
import '../../../apis/single_api.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../models/placeholder_response.dart';

part 'single_controller.g.dart';

/// Whenever flag is change we need to rebuild app
/// flutter pub run build_runner build
/// Also if we mark anything keepAlive then all related provider should be keepAlive

/// With keepAlive
// @Riverpod(keepAlive: true)

/// Without keepAlive (default)
@riverpod
Future<CustomPlaceholder> single(
  SingleRef ref, {
  required int postId,
}) {
  ref.onDispose(() => debugPrint('dispose: fetchPost $postId'));
  return ref.watch(singleAPIProvider).getSingle(
        postId: postId,
      );
}
