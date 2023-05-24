import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/home_posts_widget.dart';

class HomeBodyWidget extends ConsumerWidget {
  const HomeBodyWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const HomePostsWidget();
  }
}
