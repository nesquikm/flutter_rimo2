part of 'location_info_bloc.dart';

enum LocationInfoStatus { initial, loading, success, failure }

@JsonSerializable()
class LocationInfoState extends Equatable {
  const LocationInfoState({
    this.status = LocationInfoStatus.initial,
    this.locationCache = const <int, Location>{},
    this.location,
  });

  @override
  factory LocationInfoState.fromJson(Map<String, dynamic> json) =>
      _$LocationInfoStateFromJson(json);

  Map<String, dynamic> toJson() => _$LocationInfoStateToJson(this);

  LocationInfoState copyWith({
    LocationInfoStatus? status,
    Map<int, Location>? locationCache,
    Location? location,
    bool forceSetLocation = false,
  }) {
    return LocationInfoState(
      status: status ?? this.status,
      locationCache: locationCache ?? this.locationCache,
      location: location != null || forceSetLocation ? location : this.location,
    );
  }

  final LocationInfoStatus status;
  final Map<int, Location> locationCache;
  final Location? location;

  @override
  List<Object?> get props => [status, locationCache, location];
}

class LocationInfoInitial extends LocationInfoState {}
