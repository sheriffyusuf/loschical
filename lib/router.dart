import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loshical/question_screen.dart';
import 'package:loshical/result_provider.dart';
import 'package:loshical/result_screen.dart';

final _key = GlobalKey<NavigatorState>();

final routerProvider = Provider<GoRouter>((ref) {
  final resultState = ref.watch(resultProvider);

  return GoRouter(
    navigatorKey: _key,
    debugLogDiagnostics: true,
    initialLocation: QuestionScreen.routeLocation,
    routes: [
      GoRoute(
        path: QuestionScreen.routeLocation,
        name: QuestionScreen.routeName,
        builder: (context, state) {
          return const QuestionScreen();
        },
      ),
      GoRoute(
        path: ResultScreen.routeLocation,
        name: ResultScreen.routeName,
        builder: (context, state) {
          return const ResultScreen();
        },
      ),
    ],
    redirect: (context, state) {
      return resultState != null
          ? ResultScreen.routeLocation
          : QuestionScreen.routeLocation;
    },
  );
});
