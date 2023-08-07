import 'package:hooks_riverpod/hooks_riverpod.dart';

enum AnswerStatus { correct, incorrect }

class Result {
  final int answer;
  final AnswerStatus status;
  Result(this.answer, this.status);
}

final resultProvider = StateProvider<Result?>((ref) {
  return null;
});
