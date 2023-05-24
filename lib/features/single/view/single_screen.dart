import 'package:flutter/material.dart';

import '../widgets/single_body_widget.dart';

class SingleScreen extends StatelessWidget {
  final int id;

  const SingleScreen({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Single',
        ),
      ),
      body: SingleBodyWidget(
        id: id,
      ),
    );
  }
}
