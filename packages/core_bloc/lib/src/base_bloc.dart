import 'dart:async';

import 'package:bloc/bloc.dart';

abstract class BaseBloc<Event, State, Action> extends Bloc<Event, State> {
  BaseBloc(super.initialState, {List<Stream<Event?>?> streams = const []}) {
    for (final stream in streams) {
      stream!.listen((event) {
        if (event != null) {
          add(event);
        }
      });
    }
  }

  final StreamController<Action> _actionsStreamController = StreamController.broadcast();

  /// Поток [Action]-ов.
  Stream<Action> get actions => _actionsStreamController.stream;

  /// Добавляет новый [action] в поток [actions].
  void emitAction(Action action) {
    if (_actionsStreamController.isClosed) {
      return;
    }
    _actionsStreamController.add(action);
  }

  @override
  Future<void> close() async {
    if (!_actionsStreamController.isClosed) {
      await _actionsStreamController.close();
    }
    return super.close();
  }
}
