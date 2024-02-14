import 'package:flutter/material.dart';

import 'circle_progress.dart';

class ProgressPage extends StatelessWidget {
  const ProgressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircleProgress(
          color: Colors.blueAccent,
        ),
      ),
    );
  }
}
