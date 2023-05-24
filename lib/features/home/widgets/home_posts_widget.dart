import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../models/failure.dart';
import '../../../models/placeholder_response.dart';
import '../controller/home_controller.dart';

class HomePostsWidget extends ConsumerWidget {
  const HomePostsWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(postsProvider).when(
          data: (sliders) {
            return ListView.builder(
              itemCount: sliders.length,
              itemBuilder: (BuildContext context, int index) {
                CustomPlaceholder placeholder = sliders.elementAt(index);
                return ListTile(
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      '/single',
                      arguments: placeholder.id,
                    );
                  },
                  title: Text(
                    placeholder.title,
                  ),
                );
              },
            );
          },
          error: (error, st) {
            debugPrint('error $error');
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
