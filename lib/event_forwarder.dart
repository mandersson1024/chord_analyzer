import 'package:event_bus/event_bus.dart';

class EventForwarder<T> {
  EventBus _eventBus;

  EventForwarder(this._eventBus);

  void listen(Function(T event) listener) {
    _eventBus.on<T>().listen(listener);
  }
}
