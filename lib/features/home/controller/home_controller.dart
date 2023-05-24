import 'package:flutter/cupertino.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../apis/home_api.dart';
import '../../../models/placeholder_response.dart';

part 'home_controller.g.dart';

@riverpod
Future<List<CustomPlaceholder>> posts(PostsRef ref) {
  ref.onDispose(() => debugPrint('dispose: fetchPosts'));
  return ref.watch(homeAPIProvider).getList();
}
