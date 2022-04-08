part of 'locations_bloc.dart';

abstract class LocationsEvent extends Equatable {
  const LocationsEvent();

  @override
  List<Object> get props => [];
}

class LocationsReset extends LocationsEvent {}

class LocationsFetchFirstPage extends LocationsEvent {}

class LocationsFetchNextPage extends LocationsEvent {
  const LocationsFetchNextPage({this.reset = false});
  final bool reset;

  @override
  List<Object> get props => [reset];
}
