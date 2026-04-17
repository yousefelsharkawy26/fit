import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/gamification_events.dart';

class GamificationNotificationService extends Notifier<List<GamificationEvent>> {
  @override
  List<GamificationEvent> build() {
    return [];
  }

  void addEvent(GamificationEvent event) {
    state = [...state, event];
  }

  void popEvent() {
    if (state.isNotEmpty) {
      state = state.sublist(1);
    }
  }

  void clearCache() {
    state = [];
  }
}

final gamificationNotificationProvider =
    NotifierProvider<GamificationNotificationService, List<GamificationEvent>>(
        () => GamificationNotificationService());
