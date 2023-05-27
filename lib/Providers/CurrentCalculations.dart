import 'package:flutter_riverpod/flutter_riverpod.dart';

final currentCalculationsProvider =
    StateNotifierProvider<CurrentCalculationsNotifier, String>(
        (ref) => CurrentCalculationsNotifier());

class CurrentCalculationsNotifier extends StateNotifier<String> {
  CurrentCalculationsNotifier() : super("");

  void addCalculations(String x) {
    state = state + x;
  }
}
