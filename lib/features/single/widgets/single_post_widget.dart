import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/failure.dart';
import '../../../models/placeholder_response.dart';
import '../controller/single_controller.dart';

class SinglePostWidget extends ConsumerWidget {
  final int id;

  const SinglePostWidget({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postAsync = ref.watch(singleProvider(
      postId: id,
    ));
    return postAsync.when(
      data: (slider) {
        CustomPlaceholder placeholder = slider;
        return ListTile(
          title: Text(
            placeholder.title,
          ),
        );
      },
      error: (error, st) {
        Failure failure = error as Failure;
        return Center(
          child: Text(failure.message),
        );
      },
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
