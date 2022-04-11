import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:stream_transform/stream_transform.dart';

mixin ThrottleDroppable {
  EventTransformer<E> throttleDroppable<E>() {
    return (events, mapper) {
      return droppable<E>()
          .call(events.throttle(const Duration(milliseconds: 100)), mapper);
    };
  }
}
