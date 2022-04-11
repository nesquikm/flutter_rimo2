import 'package:entities_repository/entities_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_rimo2/pages/utils/throttle_droppable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:json_annotation/json_annotation.dart';

part 'location_info_bloc.g.dart';
part 'location_info_event.dart';
part 'location_info_state.dart';

class LocationInfoBloc
    extends HydratedBloc<LocationInfoEvent, LocationInfoState>
    with ThrottleDroppable {
  LocationInfoBloc(EntitiesRepository entitiesRepository)
      : _apiLocation = entitiesRepository.apiLocation,
        super(LocationInfoInitial()) {
    on<LocationInfoRefresh>(
      (event, emit) {
        if (state.location != null) {
          add(LocationInfoFetchById(id: state.location!.id, refresh: true));
        }
      },
    );

    on<LocationInfoFetchById>(
      _fetchById,
      transformer: throttleDroppable(),
    );
  }

  @override
  LocationInfoState? fromJson(Map<String, dynamic> json) =>
      LocationInfoState.fromJson(json);

  @override
  Map<String, dynamic> toJson(LocationInfoState state) => state.toJson();

  final ApiLocation _apiLocation;

  Future<void> _fetchById(
    LocationInfoFetchById event,
    Emitter<LocationInfoState> emit,
  ) async {
    try {
      final id = event.id;
      final location = state.locationCache[id];
      if (location != null && !event.refresh) {
        emit(
          state.copyWith(
            status: LocationInfoStatus.success,
            location: location,
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: LocationInfoStatus.loading,
            location: location,
            forceSetLocation: true,
          ),
        );
        final locations = await _apiLocation.getListOfLocations(ids: [id]);
        if (locations.isEmpty) {
          throw Exception('LocationInfo with id $id not found');
        }
        emit(
          state.copyWith(
            status: LocationInfoStatus.success,
            locationCache: {
              ...state.locationCache,
              ...{id: locations[0]}
            },
            location: locations[0],
          ),
        );
      }
    } catch (_) {
      emit(state.copyWith(status: LocationInfoStatus.failure));
    }
  }
}
