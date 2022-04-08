part of 'locations_bloc.dart';

enum LocationsStatus { initial, loading, success, failure }

@JsonSerializable()
class LocationsState extends Equatable {
  const LocationsState({
    this.status = LocationsStatus.initial,
    this.locations = const <Location>[],
    this.lastPage,
  });

  @override
  factory LocationsState.fromJson(Map<String, dynamic> json) =>
      _$LocationsStateFromJson(json);

  Map<String, dynamic> toJson() => _$LocationsStateToJson(this);

  LocationsState copyWith({
    LocationsStatus? status,
    List<Location>? locations,
    PageLocation? lastPage,
  }) {
    return LocationsState(
      status: status ?? this.status,
      locations: locations ?? this.locations,
      lastPage: lastPage ?? this.lastPage,
    );
  }

  final PageLocation? lastPage;

  final LocationsStatus status;
  final List<Location> locations;
  bool get fetchedAll => lastPage != null && lastPage?.info.next == null;

  @override
  List<Object?> get props => [lastPage, status, locations];
}

class LocationsInitial extends LocationsState {}
