import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loshical/assets.dart';
import 'package:loshical/result_provider.dart';

class ResultScreen extends ConsumerWidget {
  const ResultScreen({super.key});
  static String get routeName => 'result';
  static String get routeLocation => '/$routeName';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(resultProvider);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (state != null)
            Text(
                state.status == AnswerStatus.correct
                    ? 'Congratulations'
                    : 'Game Over',
                style:
                    const TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
          const SizedBox(
            height: 36,
          ),
          if (state != null)
            Image.asset(AssetManager.path(
                id: state.answer, assetType: AssetType.answer)),
          Center(
              child: OutlinedButton(
                  onPressed: () =>
                      {ref.read(resultProvider.notifier).state = null},
                  child: const Text('Reset')))
        ],
      ),
    );
  }
}
