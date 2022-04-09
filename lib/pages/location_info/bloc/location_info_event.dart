part of 'location_info_bloc.dart';

abstract class LocationInfoEvent extends Equatable {
  const LocationInfoEvent();

  @override
  List<Object> get props => [];
}

class LocationInfoRefresh extends LocationInfoEvent {}

class LocationInfoFetchById extends LocationInfoEvent {
  const LocationInfoFetchById({required this.id, this.refresh = false});
  final int id;
  final bool refresh;

  @override
  List<Object> get props => [id, refresh];
}
