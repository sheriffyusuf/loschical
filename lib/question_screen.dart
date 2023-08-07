import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loshical/answer_image.dart';
import 'package:loshical/assets.dart';
import 'package:loshical/how_to_play_screen.dart';
import 'package:loshical/hugged_child.dart';
import 'package:loshical/question_image.dart';
import 'package:loshical/result_provider.dart';

extension MapWithIndex<T> on List<T> {
  List<R> mapWithIndex<R>(R Function(T, int i) callback) {
    List<R> result = [];

    for (int i = 0; i < length; i++) {
      R item = callback(this[i], i);
      result.add(item);
    }
    return result;
  }

  Iterable<R> mapWithIndexIterable<R>(R Function(T, int i) callback) {
    return asMap().keys.toList().map((index) => callback(this[index], index));
  }
}

class QuestionScreen extends ConsumerWidget {
  const QuestionScreen({super.key});
  static String get routeName => 'home';
  static String get routeLocation => '/';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Loshical'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (_) => const HowToPlayScreen()));
            },
            icon: const Icon(Icons.info_outlined),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            children: [
              const Text('Choose the image that completes the pattern: '),
              const SizedBox(
                height: 16,
              ),
              Wrap(
                children: AssetManager.questionPaths
                    .map(
                      (e) => DragTarget<String>(
                        builder: (
                          BuildContext context,
                          List<String?> accepted,
                          List<dynamic> rejected,
                        ) {
                          return Container(
                            decoration: accepted.isNotEmpty
                                ? BoxDecoration(
                                    border: Border.all(
                                        color: accepted.first ==
                                                AssetManager.path(
                                                    id: 5,
                                                    assetType: AssetType.answer)
                                            ? Colors.green
                                            : Colors.red,
                                        width: 2))
                                : null,
                            child: QuestionImage(
                              assetPath: e,
                            ),
                          );
                        },
                        onAccept: (data) {
                          int idx = AssetManager.answerPaths.indexOf(data) + 1;
                          if (idx == 5) {
                            ref.read(resultProvider.notifier).state =
                                Result(idx, AnswerStatus.correct);
                          } else {
                            ref.read(resultProvider.notifier).state =
                                Result(idx, AnswerStatus.incorrect);
                          }
                        },
                      ),
                    )
                    .toList(),
              ),
              const Spacer(),
              const Text('Which of the shapes below continues the sequence'),
              const SizedBox(
                height: 16,
              ),
              Wrap(
                children: AssetManager.answerPaths
                    .map(
                      (e) => Draggable<String>(
                        data: e,
                        feedback: AnswerImage(assetPath: e),
                        childWhenDragging: HuggedChild(child: Container()),
                        child: AnswerImage(
                          assetPath: e,
                        ),
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(
                height: 42,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
