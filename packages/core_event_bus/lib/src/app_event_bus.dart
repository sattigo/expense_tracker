import 'dart:async';

import 'package:core_event_bus/src/app_event.dart';

class AppEventBus {
  final StreamController<AppEvent> _controller = StreamController<AppEvent>.broadcast();

  Stream<AppEvent> get events => _controller.stream;

  Stream<T> on<T extends AppEvent>() => events.where((e) => e is T).cast<T>();

  void emit(AppEvent event) {
    if (_controller.isClosed) {
      return;
    }
    _controller.add(event);
  }

  Future<void> dispose() => _controller.close();
}
