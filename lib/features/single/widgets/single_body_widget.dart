import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/single_post_widget.dart';

class SingleBodyWidget extends ConsumerWidget {
  final int id;

  const SingleBodyWidget({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SinglePostWidget(id: id);
  }
}
